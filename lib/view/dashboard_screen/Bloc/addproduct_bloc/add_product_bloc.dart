import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_service.dart';
import 'add_product_event.dart';
import 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(const AddProductState()) {
    on<SubmitAddProductEvent>(_onSubmitAddProduct);
  }

  Future<void> _onSubmitAddProduct(
      SubmitAddProductEvent event, Emitter<AddProductState> emit) async {
    emit(state.copyWith(status: AddProductStatus.loading));

    try {
      // ✅ Use `formData` instead of `body`
      await ApiService.postMultipartMultipleFilesMethod(
        authHeader: true,
        apiUrl: AppUrl.storeProduct,
        formData: event.product.toJson(), // <-- this line fixed
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log("✅ Product Added Successfully: $responseData");
            emit(state.copyWith(
              status: AddProductStatus.success,
              message: "Product added successfully!",
            ));
          } else {
            emit(state.copyWith(
              status: AddProductStatus.error,
              message: responseData['message'] ?? "Failed to add product.",
            ));
          }
        },
      );
    } catch (e, st) {
      log("❌ Add Product Error: $e", stackTrace: st);
      emit(state.copyWith(
        status: AddProductStatus.error,
        message: e.toString(),
      ));
    }
  }
}
