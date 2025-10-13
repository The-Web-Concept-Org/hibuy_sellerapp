import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/product_category_model.dart'; 
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_state.dart';

class ProductCategoryBloc extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  ProductCategoryBloc() : super(const ProductCategoryState()) {
    on<FetchProductCategoryEvent>(_onFetchProductCategoryEvent);
  }

  Future<void> _onFetchProductCategoryEvent(
      FetchProductCategoryEvent event, Emitter<ProductCategoryState> emit) async {
    emit(state.copyWith(status: ProductCategoryStatus.loading));

    try {
      await ApiService.getMethod(
        authHeader: true,
        apiUrl: AppUrl.productCategory,
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log("✅ Product Category Response: $responseData");

            final categoryModel = ProductCategory.fromJson(responseData);

            emit(state.copyWith(
              status: ProductCategoryStatus.success,
              productCategory: categoryModel,
              message: "Product categories fetched successfully",
            ));
          } else {
            emit(state.copyWith(
              status: ProductCategoryStatus.error,
              message: responseData['message'] ?? "Failed to fetch product categories",
            ));
          }
        },
      );
    } catch (e, st) {
      log("❌ Product Category Error: $e", stackTrace: st);
      emit(state.copyWith(
        status: ProductCategoryStatus.error,
        message: e.toString(),
      ));
    }
  }
}
