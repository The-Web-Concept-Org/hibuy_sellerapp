import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hibuy/models/return_order_detail_model.dart';
import 'package:hibuy/models/return_order_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/local_storage.dart';

part 'return_order_event.dart';
part 'return_order_state.dart';

class ReturnOrderBloc extends Bloc<ReturnOrderEvent, ReturnOrderState> {
  ReturnOrderBloc() : super(ReturnOrderState()) {
    on<GetReturnOrdersEvent>(_fetchReturnOrders);
    on<GetReturnOrderDetailEvent>(_fetchReturnOrderDetail);
    on<SetCurrentReturnOrder>(_setCurrentReturnOrder);
    on<SearchReturnOrdersEvent>(_searchReturnOrders);
    on<ClearReturnDataEvent>(_clearData);
    on<UpdateReturnOrdersEvent>(updateReturnOrders);
  }

  _clearData(ClearReturnDataEvent event, Emitter<ReturnOrderState> emit) {
    emit(
      state.copyWith(
        returnOrdersResponse: null,
        status: ReturnOrderStatus.initial,
        searchQuery: '',
      ),
    );
  }

  Future<void> updateReturnOrders(
    UpdateReturnOrdersEvent event,
    Emitter<ReturnOrderState> emit,
  ) async {
    emit(
      state.copyWith(
        updatingOrderDetailStatus: UpdatingOrderDetailStatus.loading,
      ),
    );

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            updatingOrderDetailStatus: UpdatingOrderDetailStatus.error,
            errorMessage: "No token found. Please login again.",
          ),
        );
        return;
      }

      // Prepare the data to send
      final Map<String, dynamic> postData = {
        'return_id': event.returnOrderId,
        'delivery_status': event.status,
      };

      log(
        "🚀 Updating Return Order Status - ID: ${event.returnOrderId}, Status: ${event.status}",
      );

      // ✅ Call ApiService postMethod
      await ApiService.postMethod(
        apiUrl: AppUrl.updateReturnOrderStatus,
        postData: postData,
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) {
          if (success && responseData != null) {
            log("✅ Return Order Update Success Response: $responseData");

            try {
              emit(
                state.copyWith(
                  updatingOrderDetailStatus: UpdatingOrderDetailStatus.success,
                  message:
                      responseData['message'] ?? 'Order updated successfully',
                ),
              );

              // Optionally refresh the order detail after update
              // if (event.returnOrderId.isNotEmpty) {
              //   add(GetReturnOrderDetailEvent(event.returnOrderId));
              // }
            } catch (e) {
              log("❌ Error parsing update response: $e");
              emit(
                state.copyWith(
                  updatingOrderDetailStatus: UpdatingOrderDetailStatus.error,
                  errorMessage: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Return Order Update Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                updatingOrderDetailStatus: UpdatingOrderDetailStatus.error,
                errorMessage: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Return Order Update Bloc Error: $e\n$s");
      emit(
        state.copyWith(
          updatingOrderDetailStatus: UpdatingOrderDetailStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  _fetchReturnOrderDetail(
    GetReturnOrderDetailEvent event,
    Emitter<ReturnOrderState> emit,
  ) async {
    emit(
      state.copyWith(returnOrderDetailStatus: ReturnOrderDetailStatus.loading),
    );

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            returnOrderDetailStatus: ReturnOrderDetailStatus.error,
            errorMessage: "No token found. Please login again.",
          ),
        );
        return;
      }

      // ✅ Call your ApiService using GET method
      await ApiService.getMethod(
        apiUrl: "${AppUrl.getSellerReturn}?return_id=${event.returnOrderId}",
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) {
          if (success && responseData != null) {
            log(
              "✅ @@@@@@@@@@     Return Order Detail API Success Response: ${responseData['data'][0]}",
            );

            try {
              // Parse the response into the OrdersResponse model
              final ordersResponse = ReturnOrderDetailModel.fromJson(
                responseData['data'][0],
              );
              log("✅ Return Order Detail Response parsed successfully");

              emit(
                state.copyWith(
                  returnOrderDetailStatus: ReturnOrderDetailStatus.success,
                  returnOrderDetail: ordersResponse,
                ),
              );
            } catch (e) {
              log("❌ Error parsing Orders response: $e");
              emit(
                state.copyWith(
                  // status: ReturnOrderStatus.error,
                  returnOrderDetailStatus: ReturnOrderDetailStatus.error,

                  errorMessage: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Return Order Detail API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                // status: ReturnOrderStatus.error,
                returnOrderDetailStatus: ReturnOrderDetailStatus.error,
                errorMessage: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Return Order Detail Bloc Error: $e\n$s");
      emit(
        state.copyWith(
          // status: ReturnOrderStatus.error,
          returnOrderDetailStatus: ReturnOrderDetailStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _setCurrentReturnOrder(
    SetCurrentReturnOrder event,
    Emitter<ReturnOrderState> emit,
  ) async {
    log("Return Order ------>  ${event.currentReturnOrder.createdAt}");
    emit(state.copyWith(currentReturnOrder: event.currentReturnOrder));
  }

  Future<void> _fetchReturnOrders(
    GetReturnOrdersEvent event,
    Emitter<ReturnOrderState> emit,
  ) async {
    emit(state.copyWith(status: ReturnOrderStatus.loading));

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            status: ReturnOrderStatus.error,
            errorMessage: "No token found. Please login again.",
          ),
        );
        return;
      }

      log("api url ---------------------------> ${AppUrl.getSellerReturn}");

      // ✅ Call your ApiService using GET method
      await ApiService.getMethod(
        apiUrl: AppUrl.getSellerReturn,
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) {
          if (success && responseData != null) {
            log("✅ Return Orders API Success Response: $responseData");

            try {
              // Parse the response
              final List<dynamic> dataList = responseData['data'] ?? [];
              final List<ReturnOrderModel> returnOrders = dataList
                  .map((json) => ReturnOrderModel.fromJson(json))
                  .toList();

              log(
                "✅ Return Orders parsed successfully - Count: ${dataList.length}",
              );

              emit(
                state.copyWith(
                  status: ReturnOrderStatus.success,
                  returnOrdersResponse: ReturnOrdersResponse(
                    success: responseData['success'] ?? false,
                    message: responseData['message'] ?? '',
                    returnOrders: returnOrders,
                  ),
                ),
              );
            } catch (e) {
              log("❌ Error parsing Return Orders response: $e");
              emit(
                state.copyWith(
                  status: ReturnOrderStatus.error,
                  errorMessage: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Return Orders API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                status: ReturnOrderStatus.error,
                errorMessage: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Return Order Bloc Error: $e\n$s");
      emit(
        state.copyWith(
          status: ReturnOrderStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _searchReturnOrders(
    SearchReturnOrdersEvent event,
    Emitter<ReturnOrderState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.searchQuery));
  }
}

class ReturnOrdersResponse {
  final bool success;
  final String message;
  final List<ReturnOrderModel> returnOrders;

  const ReturnOrdersResponse({
    required this.success,
    required this.message,
    required this.returnOrders,
  });

  factory ReturnOrdersResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] ?? [];
    return ReturnOrdersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      returnOrders: dataList
          .map((json) => ReturnOrderModel.fromJson(json))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': returnOrders.map((e) => e.toJson()).toList(),
    };
  }
}
