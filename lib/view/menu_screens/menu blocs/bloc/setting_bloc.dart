import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hibuy/models/seller_details.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/app_const.dart';
import 'package:hibuy/services/hive_helper.dart';
import 'package:hibuy/services/local_storage.dart';
import 'package:hive/hive.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState()) {
    on<GetUserDataEvent>(_fetchUserData);
    on<CheckOldData>(_setData);
    on<UpdateProfile>(_updateData);
    on<UpdatePassword>(_updatePassword);
  }
  _updatePassword(UpdatePassword event, Emitter<SettingState> emit) async {
    emit(state.copyWith(updatePasswordStatus: UpdatePasswordStatus.loading));
    try {
      final Map<String, dynamic> formData = {
        // ---------- PERSONAL INFO ----------
        "old_password": event.oldpassword,
        "new_password": event.newPassword,
        "new_password_confirmation": event.reenterNewPassword,
      };

      log(" Submitting Password...");
      await ApiService.postMethod(
        authHeader: true,
        apiUrl: AppUrl.updatePassword,
        postData: formData,
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log(" KYC submission successful!");
            log(" Clearing all AuthState data...");

            // Clear everything in AuthState after successful submission
            emit(
              const SettingState(
                updatePasswordStatus: UpdatePasswordStatus.success,

                // All other fields will be reset to null/empty by default constructor
              ).copyWith(message: responseData['message']),
            );
          } else {
            log(" KYC submission failed: ${responseData['error']}");
            emit(
              state.copyWith(
                updatePasswordStatus: UpdatePasswordStatus.error,

                message: responseData['error'],
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          updatePasswordStatus: UpdatePasswordStatus.error,
          message: "Error: $e",
        ),
      );
    }
  }

  _updateData(UpdateProfile event, Emitter<SettingState> emit) async {
    emit(state.copyWith(savingDataStatus: SavingProfileStatus.loading));

    try {
      log(" Submitting KYC forms...");

      final Map<String, dynamic> formData = {
        // ---------- PERSONAL INFO ----------
        "full_name": event.sellerDetails.name,
        "phone_no": event.sellerDetails.phone.toString(),
        "address": event.sellerDetails.address,
      };
      final Uint8List? profileImageFile = event.profileImage?.readAsBytesSync();
      final sellerDetails = SellerDetails(
        name: event.sellerDetails.name,
        email: event.sellerDetails.email,
        phone: event.sellerDetails.phone,
        address: event.sellerDetails.address,
        referralLink: event.sellerDetails.referralLink,
        encodedUserId: event.sellerDetails.encodedUserId,
        profilePicture: (event.profileImage == null)
            ? event.sellerDetails.profilePicture?.split('.com/').last
            : null,
        profileImageFile: profileImageFile,
      );
      log("FormData prepared with ${formData.length} fields");
      if (event.profileImage != null) {
        await ApiService.postMultipartMethod(
          authHeader: true,
          file: event.profileImage,
          fileKey: "profile_picture",
          apiUrl: AppUrl.updatePersonalInfo,
          formData: formData,
          executionMethod: (bool success, dynamic responseData) {
            if (success) {
              log(" KYC submission successful!");
              log(" Clearing all AuthState data...");

              // Clear everything in AuthState after successful submission
              emit(
                const SettingState(
                  savingDataStatus: SavingProfileStatus.success,

                  // All other fields will be reset to null/empty by default constructor
                ).copyWith(message: responseData['message']),
              );
            } else {
              log(" KYC submission failed: ${responseData['message']}");
              emit(
                state.copyWith(
                  savingDataStatus: SavingProfileStatus.error,

                  message: responseData['message'],
                ),
              );
            }
          },
        );
      } else {
        await ApiService.postMethod(
          authHeader: true,
          apiUrl: AppUrl.updatePersonalInfo,
          postData: formData,
          executionMethod: (bool success, dynamic responseData) {
            if (success) {
              log(" KYC submission successful!");
              log(" Clearing all AuthState data...");

              // Clear everything in AuthState after successful submission
              emit(
                const SettingState(
                  savingDataStatus: SavingProfileStatus.success,

                  // All other fields will be reset to null/empty by default constructor
                ).copyWith(message: responseData['message']),
              );
            } else {
              log(" KYC submission failed: ${responseData['message']}");
              emit(
                state.copyWith(
                  savingDataStatus: SavingProfileStatus.error,

                  message: responseData['message'],
                ),
              );
            }
          },
        );
      }

      HiveHelper.saveData<SellerDetails>(
        AppConst.sellerHiveBox,
        AppConst.sellerHiveKey,
        sellerDetails,
      );
    } catch (e) {
      emit(
        state.copyWith(
          savingDataStatus: SavingProfileStatus.error,

          message: "error: $e",
        ),
      );
    }
  }

  _setData(CheckOldData event, Emitter<SettingState> emit) {
    emit(
      state.copyWith(
        status: SettingStatus.success,
        sellerDetails: event.sellerDetails,
      ),
    );
  }

  Future<void> _fetchUserData(
    SettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(status: SettingStatus.loading));

    try {
      // Retrieve token from local storage
      final String? token = await LocalStorage.getData(key: AppKeys.authToken);
      log("🔐 Retrieved Token: $token");

      if (token == null || token.isEmpty) {
        emit(
          state.copyWith(
            status: SettingStatus.error,
            message: "No token found. Please login again.",
          ),
        );
        return;
      }
      log("No Data in Hive Box, Fetching from API");
      await ApiService.getMethod(
        apiUrl: AppUrl.settingDetail,
        authHeader: true,
        executionMethod: (bool success, dynamic responseData) async {
          if (success && responseData != null) {
            log("✅ Orders API Success Response: ${responseData["data"]}");

            try {
              // Parse the response into the OrdersResponse model
              final sellerDetails = SellerDetails.fromJson(
                responseData["data"],
              );
              log(
                "✅ Orders Response parsed successfully ${sellerDetails.name}",
              );

              // Save the seller details
              HiveHelper.saveData<SellerDetails>(
                AppConst.sellerHiveBox,
                AppConst.sellerHiveKey,
                sellerDetails,
              );
              emit(
                state.copyWith(
                  status: SettingStatus.success,
                  sellerDetails: sellerDetails,
                ),
              );
            } catch (e) {
              log("❌ Error parsing Orders response: $e");
              emit(
                state.copyWith(
                  status: SettingStatus.error,
                  message: "Failed to parse response: $e",
                ),
              );
            }
          } else {
            log("❌ Orders API Failed: ${responseData['message']}");
            emit(
              state.copyWith(
                status: SettingStatus.error,
                message: responseData['message'] ?? "Something went wrong",
              ),
            );
          }
        },
      );
    } catch (e, s) {
      log("❌ Orders Bloc Error: $e\n$s");
      emit(state.copyWith(status: SettingStatus.error, message: e.toString()));
    }
  }
}
