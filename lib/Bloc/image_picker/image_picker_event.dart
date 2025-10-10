// image_picker_event.dart
import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends ImagePickerEvent {
  final String key; 

  const PickImageEvent(this.key);

  @override
  List<Object?> get props => [key];
}

class RemoveImageEvent extends ImagePickerEvent {
  final String key;

  const RemoveImageEvent(this.key);

  @override
  List<Object?> get props => [key];
}
