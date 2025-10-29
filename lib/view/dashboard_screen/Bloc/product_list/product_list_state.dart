import 'package:equatable/equatable.dart';
import 'package:hibuy/models/product_list_model.dart';

enum ProductListStatus { initial, loading, success, error }

class ProductListState extends Equatable {
  final ProductListStatus status;
  final ProductListModel? productList;
  final List<Product>? boostedProducts;
  final String? message;
  final int tabBarIndex;
  final String searchQuery;

  const ProductListState({
    this.status = ProductListStatus.initial,
    this.productList,
    this.tabBarIndex = 0,
    this.boostedProducts,
    this.message,
    String? searchQuery ,
  }): searchQuery = searchQuery ?? "";

  ProductListState copyWith({
    ProductListStatus? status,
    ProductListModel? productList,
    List<Product>? boostedProducts,
    String? message,
    final String? searchQuery,
    int? tabBarIndex,
  }) {
    return ProductListState(
      status: status ?? this.status,
      productList: productList ?? this.productList,
      boostedProducts: boostedProducts ?? this.boostedProducts,
      message: message ?? this.message,
      tabBarIndex: tabBarIndex ?? this.tabBarIndex,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [status, productList, message,boostedProducts,tabBarIndex,searchQuery];
}