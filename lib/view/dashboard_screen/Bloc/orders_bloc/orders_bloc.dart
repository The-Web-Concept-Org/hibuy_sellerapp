import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hibuy/models/orders_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/local_storage.dart';
import 'package:intl/intl.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState()) {
    on<GetOrdersEvent>(_fetchOrders);
    on<SetCurrentOrder>(_setCurrentOrder);
    on<ApplyFilterEvent>(_applyFilter);
  }
  Future<void> _setCurrentOrder(
    SetCurrentOrder event,
    Emitter<OrdersState> emit,
  ) async {
    log(" boc ------>  ${event.currentOrder.orderDate}");
    emit(state.copyWith(currentOrder: event.currentOrder));
  }

  Future<void> _fetchOrders(
    GetOrdersEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(status: OrdersStatus.loading));

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            status: OrdersStatus.error,
            errorMessage: "No token found. Please login again.",
          ),
        );
        return;
      }
      log(
        "api url ---------------------------> ${AppUrl.getOrders}?status=${state.filterStatus}&from=${state.filterStartDate}&to=${state.filterEndDate}",
      );
      final filterStatus = event.status ?? state.filterStatus;
      final filterStartDate = event.fromDate ?? state.filterStartDate;
      final filterEndDate = event.toDate ?? state.filterEndDate;
      // ✅ Call your ApiService using GET method
      await ApiService.getMethod(
        apiUrl:
            "${AppUrl.getOrders}?status=$filterStatus&from=$filterStartDate&to=$filterEndDate",
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
                  status: OrdersStatus.success,
                  ordersResponse: ordersResponse,
                ),
              );
            } catch (e) {
              log("❌ Error parsing Orders response: $e");
              emit(
                state.copyWith(
                  status: OrdersStatus.error,
                  errorMessage: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Orders API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                status: OrdersStatus.error,
                errorMessage: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Orders Bloc Error: $e\n$s");
      emit(
        state.copyWith(status: OrdersStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _applyFilter(
    ApplyFilterEvent event,
    Emitter<OrdersState> emit,
  ) async {
    // emit(state.copyWith(status: OrdersStatus.loading));
    String formattedDate = DateFormat('yyyy-MM-dd').format(event.fromDate);
    String formattedDateTo = DateFormat('yyyy-MM-dd').format(event.toDate);
    log("formattedDate ---------------------------> $formattedDate");
    log("formattedDateTo ---------------------------> $formattedDateTo");
    log("event.orderStatus ---------------------------> ${event.orderStatus}");
    emit(
      state.copyWith(
        filterStartDate: formattedDate,
        filterEndDate: formattedDateTo,
        filterStatus: event.orderStatus,
      ),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
      add(
        GetOrdersEvent(
          fromDate: formattedDate,
          toDate: formattedDateTo,
          status: event.orderStatus,
        ),
      );
    });
  }
}
