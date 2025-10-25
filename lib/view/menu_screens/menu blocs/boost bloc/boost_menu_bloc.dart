import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hibuy/models/boost_status.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/local_storage.dart';

part 'boost_menu_event.dart';
part 'boost_menu_state.dart';

class BoostMenuBloc extends Bloc<BoostMenuEvent, BoostMenuState> {
  BoostMenuBloc() : super(BoostMenuState()) {
    on<BoostMenuEvent>(_fetchBoostStatus);
  }

  Future<void> _fetchBoostStatus(
    BoostMenuEvent event,
    Emitter<BoostMenuState> emit,
  ) async {
    emit(state.copyWith(status: BoostMenuStatus.loading));

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            status: BoostMenuStatus.error,
            message: "No token found. Please login again.",
          ),
        );
        return;
      }

      log("🚀 Fetching Boost Status from API");
      await ApiService.getMethod(
        apiUrl: "${AppUrl.baseUrl}/BoostStatus",
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) async {
          if (success && responseData != null) {
            log("✅ Boost Status API Success Response: ${responseData["data"]}");

            try {
              // Parse the response into the BoostStatus model
              final boostStatus = BoostStatus.fromJson(responseData["data"]);
              log(
                "✅ Boost Status parsed successfully - User ID: ${boostStatus.userId}",
              );

              // Determine if user is boosted
              bool isBoosted =
                  boostStatus.packageStatus != null &&
                  boostStatus.packageStatus!.isNotEmpty &&
                  boostStatus.packageDetail != null;

              log(
                "📊 Boost Status - isBoosted: $isBoosted, packageStatus: ${boostStatus.packageStatus}",
              );

              emit(
                state.copyWith(
                  status: BoostMenuStatus.success,
                  isBoosted: isBoosted,
                  boostStatus: boostStatus,
                ),
              );
            } catch (e) {
              log("❌ Error parsing Boost Status response: $e");
              emit(
                state.copyWith(
                  status: BoostMenuStatus.error,
                  message: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Boost Status API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                status: BoostMenuStatus.error,
                message: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Boost Status Bloc Error: $e\n$s");
      emit(
        state.copyWith(status: BoostMenuStatus.error, message: e.toString()),
      );
    }
  }
}
