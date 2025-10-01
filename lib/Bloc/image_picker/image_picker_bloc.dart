import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(const ImageInitial()) {
    on<PickImageEvent>(_onPickImage);
  }

  Future<void> _onPickImage(
      PickImageEvent event, Emitter<ImagePickerState> emit) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final currentState = state;

        if (currentState is ImageInitial || currentState is ImagePicked) {
          final images = Map<String, String>.from(
            currentState is ImagePicked ? currentState.images : (currentState as ImageInitial).images,
          );


          images[event.key] = pickedFile.path;

          emit(ImagePicked(images));
        }
      }
    } catch (e) {
      emit(ImagePickerError("Failed to pick image: $e"));
    }
  }
}
