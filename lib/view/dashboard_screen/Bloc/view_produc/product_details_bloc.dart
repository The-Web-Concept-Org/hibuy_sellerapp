import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/productdetails_model.dart';

import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_service.dart';
import 'product_details_event.dart';
import 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(const ProductDetailsState()) {
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
  }

  Future<void> _onFetchProductDetails(
      FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));

    try {
      await ApiService.getMethod(
        authHeader: true,
        apiUrl: "${AppUrl.viewProduct}/${event.productId}", // ✅ endpoint
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log("✅ Product details fetched successfully");
            final details = ProductDetails.fromJson(responseData);

            emit(state.copyWith(
              status: ProductDetailsStatus.success,
              productDetails: details,
              message: details.message ?? 'Success',
            ));
          } else {
            emit(state.copyWith(
              status: ProductDetailsStatus.error,
              message: responseData['message'] ?? 'Failed to fetch details',
            ));
          }
        },
      );
    } catch (e, st) {
      log("❌ Error fetching product details: $e", stackTrace: st);
      emit(state.copyWith(
        status: ProductDetailsStatus.error,
        message: e.toString(),
      ));
    }
  }
}
