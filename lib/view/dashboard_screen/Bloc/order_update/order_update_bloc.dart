import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hibuy/models/orders_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/local_storage.dart';

part 'order_update_event.dart';
part 'order_update_state.dart';

class OrderUpdateBloc extends Bloc<OrderUpdateEvent, OrderUpdateState> {
  OrderUpdateBloc() : super(OrderUpdateState()) {
    on<UpdateOrderEvent>(_submitAllForms);
    on<GetCompleteOrderEvent>(_fetchCompleteOrder);
  }

  _fetchCompleteOrder(
    GetCompleteOrderEvent event,
    Emitter<OrderUpdateState> emit,
  ) async {
    emit(state.copyWith(status: GetOrderStatus.loading));
    emit(state.copyWith(orderUpdateStatus: OrderUpdateStatus.initial));

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            status: GetOrderStatus.error,
            errorMessage: "No token found. Please login again.",
          ),
        );
        return;
      }

      // ✅ Call your ApiService using GET method
      await ApiService.getMethod(
        apiUrl: "${AppUrl.getOrders}?id=${event.orderId}",
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) {
          if (success && responseData != null) {
            log("✅ Orders API Success Response: $responseData");

            try {
              // Parse the response into the OrdersResponse model
              final ordersResponse = OrdersResponse.fromJson(responseData);
              log("✅ Orders Response parsed successfully");

              emit(
                state.copyWith(
                  status: GetOrderStatus.success,
                  ordersResponse: ordersResponse.data.first,
                ),
              );
            } catch (e) {
              log("❌ Error parsing Orders response: $e");
              emit(
                state.copyWith(
                  status: GetOrderStatus.error,
                  errorMessage: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Orders API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                status: GetOrderStatus.error,
                errorMessage: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Orders Bloc Error: $e\n$s");
      emit(
        state.copyWith(
          status: GetOrderStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _submitAllForms(
    UpdateOrderEvent event,
    Emitter<OrderUpdateState> emit,
  ) async {
    emit(state.copyWith(orderUpdateStatus: OrderUpdateStatus.loading));

    try {
      log(" Submitting KYC forms...");

      final Map<String, dynamic> formData = {
        // ---------- PERSONAL INFO ----------
        "personal_status": "pending",
        if (event.orderId.isNotEmpty) "order_id": event.orderId,
        if (event.delieveryStatus.isNotEmpty)
          "delivery_status": event.delieveryStatus,
        "order_video": event.orderVideo,
        if (event.orderSize.isNotEmpty) "order_size": event.orderSize,
        if (event.orderWeight.isNotEmpty) "order_weight": event.orderWeight,
      };

      log("FormData prepared with ${formData.length} fields");

      await ApiService.postMultipartMethod(
        authHeader: true,
        file: event.orderVideo,
        fileKey: "status_video",
        apiUrl: AppUrl.kycAuthentication,
        formData: formData,
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log(" KYC submission successful!");
            log(" Clearing all AuthState data...");

            // Clear everything in AuthState after successful submission
            emit(
              const OrderUpdateState(
                orderUpdateStatus: OrderUpdateStatus.success,

                // All other fields will be reset to null/empty by default constructor
              ).copyWith(message: responseData['message']),
            );
          } else {
            log(" KYC submission failed: ${responseData['message']}");
            emit(
              state.copyWith(
                orderUpdateStatus: OrderUpdateStatus.error,
                message: responseData['message'],
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          orderUpdateStatus: OrderUpdateStatus.error,
          message: "error: $e",
        ),
      );
    }
  }

}
