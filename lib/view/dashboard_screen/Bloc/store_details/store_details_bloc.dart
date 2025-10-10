import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/store_details_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_details/store_details_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_details/store_details_state.dart';

class StoreDetailsBloc extends Bloc<StoreDetailsEvent, StoreDetailState> {
  StoreDetailsBloc() : super(const StoreDetailState()) {
    on<StoreEvent>(_onStoreEvent);
  }

  Future<void> _onStoreEvent(
      StoreEvent event, Emitter<StoreDetailState> emit) async {
    emit(state.copyWith(storeDetailsStatus: StoreDetailsStatus.loading));

    try {
      await ApiService.getMethod(
        authHeader: true,
        apiUrl: AppUrl.sellerStoreDetail,
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log("✅ Store Details Response: $responseData");

            final storeModel = StoreDetailsModel.fromJson(responseData);

            emit(state.copyWith(
              storeDetailsStatus: StoreDetailsStatus.success,
              storeDetailsModel: storeModel,
              message: "Store details fetched successfully",
            ));
          } else {
            emit(state.copyWith(
              storeDetailsStatus: StoreDetailsStatus.error,
              message: responseData['message'] ?? "Failed to fetch store details",
            ));
          }
        },
      );
    } catch (e, st) {
      log("❌ Store Details Error: $e", stackTrace: st);
      emit(state.copyWith(
        storeDetailsStatus: StoreDetailsStatus.error,
        message: e.toString(),
      ));
    }
  }
}
