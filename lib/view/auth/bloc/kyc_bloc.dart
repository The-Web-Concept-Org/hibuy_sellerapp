import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/kyc_response_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/local_storage.dart';
import 'package:hibuy/view/auth/bloc/kyc_event.dart';
import 'package:hibuy/view/auth/bloc/kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc() : super(KycState.initial()) {
    on<FetchKycData>(_fetchKycData);
  }

  Future<void> _fetchKycData(FetchKycData event, Emitter<KycState> emit) async {
    emit(state.copyWith(status: KycStatus.loading));

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            status: KycStatus.error,
            errorMessage: "No token found. Please login again.",
          ),
        );
        return;
      }

      // ✅ Call your ApiService using GET method
      await ApiService.getMethod(
        apiUrl: AppUrl.profiledetail,
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) {
          if (success && responseData != null) {
            log("✅ KYC API Success Response: $responseData");

            try {
              // Parse the response into the KycResponse model
              final kycResponse = KycResponse.fromJson(responseData);
              log("✅ KYC Response parsed successfully");

              emit(
                state.copyWith(
                  status: KycStatus.success,
                  kycResponse: kycResponse,
                ),
              );
            } catch (e) {
              log("❌ Error parsing KYC response: $e");
              emit(
                state.copyWith(
                  status: KycStatus.error,
                  errorMessage: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ KYC API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                status: KycStatus.error,
                errorMessage: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ KYC Bloc Error: $e\n$s");
      emit(state.copyWith(status: KycStatus.error, errorMessage: e.toString()));
    }
  }
}
