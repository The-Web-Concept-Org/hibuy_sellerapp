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
  bool _isPickerActive = false; // 🔒 Flag to prevent simultaneous operations

  ImagePickerBloc() : super(const ImageInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<PickVideoEvent>(_onPickVideo);
    on<RemoveImageEvent>(_onRemoveImage);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<ImagePickerState> emit,
  ) async {
    // 🔒 Prevent multiple simultaneous picker operations
    if (_isPickerActive) {
      log('⚠️ Image picker already active, ignoring request');
      return;
    }

    _isPickerActive = true;
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        log('🖼️ Image picked: ${pickedFile.path}');

        final currentState = state;

        // Compress the image to be under 2048 KB
        final originalFile = File(pickedFile.path);
        final compressedFile = await ImageCompressor.compressImage(
          originalFile,
        );

        if (compressedFile == null) {
          final currentImages = Map<String, String>.from(
            currentState is ImagePicked
                ? currentState.images
                : (currentState as ImageInitial).images,
          );
          emit(
            ImagePickerError(
              "Failed to compress image. Please try a different image.",
              images: currentImages,
            ),
          );
          return;
        }

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
      final currentState = state;
      final currentImages = Map<String, String>.from(
        currentState is ImagePicked
            ? currentState.images
            : (currentState is ImageInitial ? currentState.images : {}),
      );
      emit(ImagePickerError("Failed to pick image: $e", images: currentImages));
    } finally {
      _isPickerActive = false; // 🔓 Always reset the flag
    }
  }

  Future<void> _onPickVideo(
    PickVideoEvent event,
    Emitter<ImagePickerState> emit,
  ) async {
    // 🔒 Prevent multiple simultaneous picker operations
    if (_isPickerActive) {
      log('⚠️ Video picker already active, ignoring request');
      return;
    }

    _isPickerActive = true;
    try {
      final pickedFile = await _picker.pickVideo(source: ImageSource.camera);

      if (pickedFile != null) {
        log('🎥 Video picked: ${pickedFile.path}');

        final currentState = state;

        // Check video file size (limit to 20MB to prevent memory issues)
        final videoFile = File(pickedFile.path);
        final fileSizeInBytes = await videoFile.length();
        final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        log('📊 Video size: ${fileSizeInMB.toStringAsFixed(2)} MB');

        if (fileSizeInMB > 20) {
          final currentImages = Map<String, String>.from(
            currentState is ImagePicked
                ? currentState.images
                : (currentState as ImageInitial).images,
          );
          emit(
            ImagePickerError(
              "Video is too large (${fileSizeInMB.toStringAsFixed(1)}MB). Please select a video smaller than 20MB.",
              images: currentImages,
            ),
          );
          return;
        }

        if (currentState is ImageInitial || currentState is ImagePicked) {
          final images = Map<String, String>.from(
            currentState is ImagePicked
                ? currentState.images
                : (currentState as ImageInitial).images,
          );

          // Store video path with the key
          images[event.key] = pickedFile.path;
          log('✅ Video saved: ${pickedFile.path}');

          emit(ImagePicked(images));
        }
      }
    } catch (e) {
      log('❌ Error picking video: $e');
      final currentState = state;
      final currentImages = Map<String, String>.from(
        currentState is ImagePicked
            ? currentState.images
            : (currentState is ImageInitial ? currentState.images : {}),
      );
      emit(ImagePickerError("Failed to pick video: $e", images: currentImages));
    } finally {
      _isPickerActive = false; // 🔓 Always reset the flag
    }
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<ImagePickerState> emit) {
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
      final currentState = state;
      final currentImages = Map<String, String>.from(
        currentState is ImagePicked
            ? currentState.images
            : (currentState is ImageInitial ? currentState.images : {}),
      );
      emit(
        ImagePickerError("Failed to remove image: $e", images: currentImages),
      );
    }
  }
}
