import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hibuy/models/dashboard_model.dart';
import 'package:hibuy/models/orders_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/local_storage.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<GetDashboardDataEvent>(_getDashboardData);
  }

  _getDashboardData(
    GetDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashBoardStatus.loading));

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            status: DashBoardStatus.error,
            errorMessage: "No token found. Please login again.",
          ),
        );
        return;
      }

      // ✅ Call your ApiService using GET method
      await ApiService.getMethod(
        apiUrl: "${AppUrl.dashboardData}?orderdate=thismonth",
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) {
          if (success && responseData != null) {
            log("✅ Orders API Success Response: $responseData");

            try {
              // Parse the response into the OrdersResponse model
              final dashboardResponse = DashboardResponse.fromJson(responseData);
              log("✅ Orders Response parsed successfully");

              emit(
                state.copyWith(
                  status: DashBoardStatus.success,
                  dashboardResponse: DashboardResponse.fromJson(responseData),
                ),
              );
            } catch (e) {
              log("❌ Error parsing Orders response: $e");
              emit(
                state.copyWith(
                  status: DashBoardStatus.error,
                  errorMessage: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Dashboard API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                status: DashBoardStatus.error,
                errorMessage: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Dashboard Bloc Error: $e\n$s");
      emit(
        state.copyWith(
          status: DashBoardStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

}
