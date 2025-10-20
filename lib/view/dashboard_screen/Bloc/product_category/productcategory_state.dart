import 'package:equatable/equatable.dart';
import 'package:hibuy/models/product_category_model.dart';


enum ProductCategoryStatus { initial, loading, success, error }

class ProductCategoryState extends Equatable {
  final String? message;
  final ProductCategory? productCategory;
  final ProductCategoryStatus status;

  const ProductCategoryState({
    this.message,
    this.productCategory,
    this.status = ProductCategoryStatus.initial,
  });

  ProductCategoryState copyWith({
    String? message,
    ProductCategory? productCategory,
    ProductCategoryStatus? status,
  }) {
    return ProductCategoryState(
      message: message ?? this.message,
      productCategory: productCategory ?? this.productCategory,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        message,
        productCategory,
        status,
      ];
}
