// image_picker_bloc.dart
import 'dart:io';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hibuy/res/utils/image_compressor.dart';
import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(const ImageInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<RemoveImageEvent>(_onRemoveImage);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<ImagePickerState> emit,
  ) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        log('🖼️ Image picked: ${pickedFile.path}');

        // Compress the image to be under 2048 KB
        final originalFile = File(pickedFile.path);
        final compressedFile = await ImageCompressor.compressImage(
          originalFile,
        );

        if (compressedFile == null) {
          emit(
            ImagePickerError(
              "Failed to compress image. Please try a different image.",
            ),
          );
          return;
        }

        final currentState = state;

        if (currentState is ImageInitial || currentState is ImagePicked) {
          final images = Map<String, String>.from(
            currentState is ImagePicked
                ? currentState.images
                : (currentState as ImageInitial).images,
          );

          // Use compressed image path
          images[event.key] = compressedFile.path;
          log('✅ Compressed image saved: ${compressedFile.path}');

          emit(ImagePicked(images));
        }
      }
    } catch (e) {
      log('❌ Error picking/compressing image: $e');
      emit(ImagePickerError("Failed to pick image: $e"));
    }
  }

  void _onRemoveImage(
    RemoveImageEvent event,
    Emitter<ImagePickerState> emit,
  ) {
    try {
      final currentState = state;

      if (currentState is ImageInitial || currentState is ImagePicked) {
        final images = Map<String, String>.from(
          currentState is ImagePicked
              ? currentState.images
              : (currentState as ImageInitial).images,
        );

        // Remove the image from the map
        final removedPath = images.remove(event.key);
        
        if (removedPath != null) {
          log('🗑️ Image removed: $removedPath (key: ${event.key})');
          
          // Optionally delete the file from storage
          try {
            final file = File(removedPath);
            if (file.existsSync()) {
              file.deleteSync();
              log('🗑️ File deleted from storage: $removedPath');
            }
          } catch (e) {
            log('⚠️ Failed to delete file: $e');
          }
        }

        emit(ImagePicked(images));
      }
    } catch (e) {
      log('❌ Error removing image: $e');
      emit(ImagePickerError("Failed to remove image: $e"));
    }
  }
}
