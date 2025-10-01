import 'package:equatable/equatable.dart';

abstract class ImagePickerState extends Equatable {
  final Map<String, String> images;

  const ImagePickerState(this.images);

  @override
  List<Object?> get props => [images];
}

class ImageInitial extends ImagePickerState {
  const ImageInitial({Map<String, String> images = const {}}) : super(images);
}

class ImagePicked extends ImagePickerState {
  const ImagePicked(Map<String, String> images) : super(images);
}

class ImagePickerError extends ImagePickerState {
  final String message;

  const ImagePickerError(this.message) : super(const {});

  @override
  List<Object?> get props => [message];
}
