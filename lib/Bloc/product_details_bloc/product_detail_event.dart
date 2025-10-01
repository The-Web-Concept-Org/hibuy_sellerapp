import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Change selected image index
class ChangeImageEvent extends ProductDetailEvent {
  final int index;
  const ChangeImageEvent(this.index);

  @override
  List<Object?> get props => [index];
}
