import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final int productId;

  const FetchProductDetailsEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
