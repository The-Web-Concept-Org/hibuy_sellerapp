import 'package:equatable/equatable.dart';

abstract class ProductCategoryEvent extends Equatable {
  const ProductCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductCategoryEvent extends ProductCategoryEvent {}
