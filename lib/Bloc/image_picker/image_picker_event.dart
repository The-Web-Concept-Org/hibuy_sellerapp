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
