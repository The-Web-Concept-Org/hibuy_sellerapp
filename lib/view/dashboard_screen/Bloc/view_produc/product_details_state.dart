import 'package:equatable/equatable.dart';
import 'package:hibuy/models/productdetails_model.dart';


enum ProductDetailsStatus { initial, loading, success, error }

class ProductDetailsState extends Equatable {
  final ProductDetailsStatus status;
  final ProductDetails? productDetails;
  final String? message;

  const ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.productDetails,
    this.message = '',
  });

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    ProductDetails? productDetails,
    String? message,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      productDetails: productDetails ?? this.productDetails,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, productDetails, message];
}
