import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/product_list_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_service.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState()) {
    on<FetchProductListEvent>(_onFetchProductList);
    on<SetTabBarEvent>(setTabBarIndex);
  }
setTabBarIndex(SetTabBarEvent event,Emitter<ProductListState> emit) {
    emit(state.copyWith(tabBarIndex: event.selectedIndex));

}
  Future<void> _onFetchProductList(
      FetchProductListEvent event, Emitter<ProductListState> emit) async {
    emit(state.copyWith(status: ProductListStatus.loading));

    try {
      await ApiService.getMethod(
        authHeader: true,
        apiUrl: AppUrl.products, 
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log("✅ Products fetched successfully");
            final productList = ProductListModel.fromJson(responseData);
            final boostedProducts = <Product>[];
         if(productList.products!=null&&productList.products!.isNotEmpty){

            for (Product element in productList.products??[]) {
              if(element.isBoosted!=0){
boostedProducts.add( element);
              }
              
            }
         }
            emit(state.copyWith(
              status: ProductListStatus.success,
              productList: productList,
              boostedProducts:boostedProducts,
              message: productList.message,
            ));
          } else {
            emit(state.copyWith(
              status: ProductListStatus.error,
              message: responseData['message'] ?? "Failed to fetch products",
            ));
          }
        },
      );
    } catch (e, st) {
      log("❌ Error fetching products: $e", stackTrace: st);
      emit(state.copyWith(
        status: ProductListStatus.error,
        message: e.toString(),
      ));
    }
  }
}
