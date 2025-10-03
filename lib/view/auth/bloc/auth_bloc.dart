import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/user_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/services/local_storage.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(_loginEvent);
    on<SignUpEvent>(_signUpEvent);

    // ✅ New handlers for KYC multi-forms
    on<SavePersonalInfoEvent>(_savePersonalInfo);
    on<SaveStoreInfoEvent>(_saveStoreInfo);
    on<SaveDocumentsInfoEvent>(_saveDocumentsInfo);
    on<SaveBankInfoEvent>(_saveBankInfo);
    on<SaveBusinessInfoEvent>(_saveBusinessInfo);
    on<SubmitAllFormsEvent>(_submitAllForms);
  }

  // ------------------ LOGIN ------------------
  void _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await ApiService.postMethod(
        apiUrl: AppUrl.loginApi,
        postData: {"user_email": event.email, "user_password": event.password},
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            UserModel userModel = UserModel.fromJson(responseData);

            emit(
              state.copyWith(
                authStatus: AuthStatus.success,
                userModel: userModel,
                errorMessage: '${responseData['message']}',
              ),
            );

            // save data locally
            LocalStorage.saveData(
              key: AppKeys.authToken,
              value: responseData["access_token"],
            );
            LocalStorage.saveData(
              key: AppKeys.uRole,
              value: responseData["user"]["user_role"],
            );
            LocalStorage.saveData(
              key: AppKeys.userData,
              value: jsonEncode(userModel.toJson()),
            );
          } else {
            emit(
              state.copyWith(
                authStatus: AuthStatus.error,
                errorMessage: '${responseData['message']}',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: 'error: $e'),
      );
    }
  }

  // ------------------ SIGNUP ------------------
  void _signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await ApiService.postMethod(
        apiUrl: AppUrl.registerApi,
        postData: {
          "user_name": event.name,
          "user_email": event.email,
          "user_password": event.password,
          "user_role": event.role,
        },
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            UserModel userModel = UserModel.fromJson(responseData);
            emit(
              state.copyWith(
                authStatus: AuthStatus.success,
                userModel: userModel,
                errorMessage: '${responseData['message']}',
              ),
            );

            LocalStorage.saveData(
              key: AppKeys.authToken,
              value: responseData["access_token"],
            );
            LocalStorage.saveData(
              key: AppKeys.uRole,
              value: responseData["user"]["user_role"],
            );
            LocalStorage.saveData(
              key: AppKeys.userData,
              value: jsonEncode(userModel.toJson()),
            );
          } else {
            emit(
              state.copyWith(
                authStatus: AuthStatus.error,
                errorMessage: '${responseData['message']}',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(authStatus: AuthStatus.error, errorMessage: 'error: $e'),
      );
    }
  }

  // ------------------ SAVE PERSONAL INFO ------------------
  void _savePersonalInfo(SavePersonalInfoEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        personalStatus: PersonalStatus.success,
        personalFullName: event.fullName,
        personalAddress: event.address,
        personalPhoneNo: event.phoneNo,
        personalEmail: event.email,
        personalCnic: event.cnic,
        personalProfilePicture: event.profilePicture,
        personalFrontImage: event.frontImage,
        personalBackImage: event.backImage,
      ),
    );

    // ✅ Debugging print
    print("Bloc state updated with images:");
    print("personalProfilePicture: ${event.profilePicture?.path}");
    print("personalFrontImage: ${event.frontImage?.path}");
    print("personalBackImage: ${event.backImage?.path}");
  }

  // ------------------ SAVE STORE INFO ------------------
  void _saveStoreInfo(SaveStoreInfoEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        storeStatus: StoreStatus.success,
        storeName: event.storeName,
        storeType: event.type,
        storePhoneNo: event.phoneNo,
        storeEmail: event.email,
        storeCountry: event.country,
        storeProvince: event.province,
        storeCity: event.city,
        storeZipCode: event.zipCode,
        storeAddress: event.address,
        storePinLocation: event.pinLocation,
        storeProfilePicture: event.profilePicture,
      ),
    );
  }

  // ------------------ SAVE DOCUMENTS INFO ------------------
  void _saveDocumentsInfo(
    SaveDocumentsInfoEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        documentsStatus: DocumentsStatus.success,
        documentsCountry: event.country,
        documentsProvince: event.province,
        documentsCity: event.city,
        documentsHomeBill: event.homeBill,
        documentsShopVideo: event.shopVideo,
      ),
    );
  }

  // ------------------ SAVE BANK INFO ------------------
  void _saveBankInfo(SaveBankInfoEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        bankStatus: BankStatus.success,
        bankAccountType: event.accountType,
        bankBankName: event.bankName,
        bankBranchCode: event.branchCode,
        bankBranchName: event.branchName,
        bankBranchPhone: event.branchPhone,
        bankAccountTitle: event.accountTitle,
        bankAccountNo: event.accountNo,
        bankIbanNo: event.ibanNo,
        bankCanceledCheque: event.canceledCheque,
        bankVerificationLetter: event.verificationLetter,
      ),
    );
  }

  // ------------------ SAVE BUSINESS INFO ------------------
  void _saveBusinessInfo(SaveBusinessInfoEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        businessStatus: BusinessStatus.success,
        businessOwnerName: event.ownerName,
        businessName: event.businessName,
        businessPhoneNo: event.phoneNo,
        businessRegNo: event.regNo,
        businessTaxNo: event.taxNo,
        businessAddress: event.address,
        businessPinLocation: event.pinLocation,
        businessPersonalProfile: event.businessPersonalProfile,
        businessLetterHead: event.letterHead,
        businessStamp: event.stamp,
      ),
    );
  }

  // ------------------ SUBMIT ALL FORMS (API CALL) ------------------
 void _submitAllForms(
  SubmitAllFormsEvent event,
  Emitter<AuthState> emit,
) async {
  emit(state.copyWith(authStatus: AuthStatus.loading));

  try {
    // ✅ Prepare formData with both strings + files (dynamic)
    final Map<String, dynamic> formData = {
      // ---------- PERSONAL INFO ----------
      "personal_status": "pending",
      "personal_full_name": state.personalFullName ?? '',
      "personal_address": state.personalAddress ?? '',
      "personal_phone_no": state.personalPhoneNo ?? '',
      "personal_email": state.personalEmail ?? '',
      "personal_cnic": state.personalCnic ?? '',
      "personal_profile_picture": state.personalProfilePicture, // File?
      "personal_front_image": state.personalFrontImage,         // File?
      "personal_back_image": state.personalBackImage,           // File?

      // ---------- STORE INFO ----------
      "store_status": "pending",
      "store_store_name": state.storeName ?? '',
      "store_type": state.storeType ?? '',
      "store_phone_no": state.storePhoneNo ?? '',
      "store_email": state.storeEmail ?? '',
      "store_country": state.storeCountry ?? '',
      "store_province": state.storeProvince ?? '',
      "store_city": state.storeCity ?? '',
      "store_zip_code": state.storeZipCode ?? '',
      "store_address": state.storeAddress ?? '',
      "store_pin_location": state.storePinLocation ?? '',
      "store_profile_picture": state.storeProfilePicture, // File?

      // ---------- DOCUMENTS INFO ----------
      "documents_status": "pending",
      "documents_country": state.documentsCountry ?? '',
      "documents_province": state.documentsProvince ?? '',
      "documents_city": state.documentsCity ?? '',
      "documents_home_bill": state.documentsHomeBill,   // File?
      "documents_shop_video": state.documentsShopVideo, // File?

      // ---------- BANK INFO ----------
      "bank_status": "pending",
      "bank_account_type": event.accountType,
      "bank_bank_name": event.bankName,
      "bank_branch_code": event.branchCode,
      "bank_branch_name": event.branchName,
      "bank_branch_phone": event.branchPhone,
      "bank_account_title": event.accountTitle,
      "bank_account_no": event.accountNo,
      "bank_iban_no": event.ibanNo,
      "bank_canceled_cheque": event.canceledCheque,           // File?
      "bank_verification_letter": event.verificationLetter,   // File?

      // ---------- BUSINESS INFO ----------
      "business_status": "pending",
      "business_owner_name": state.businessOwnerName ?? '',
      "business_business_name": state.businessName ?? '',
      "business_phone_no": state.businessPhoneNo ?? '',
      "business_reg_no": state.businessRegNo ?? '',
      "business_tax_no": state.businessTaxNo ?? '',
      "business_address": state.businessAddress ?? '',
      "business_pin_location": state.businessPinLocation ?? '',
      "business_personal_profile": state.businessPersonalProfile, // File?
      "business_letter_head": state.businessLetterHead,           // File?
      "business_stamp": state.businessStamp,                      // File?
    };

    // ✅ Debug Logs
    formData.forEach((key, value) {
      if (value is File) {
        print("📂 File attached: $key => ${value.path}");
      } else {
        print("🔤 Field: $key => $value");
      }
    });

    // ✅ Send to API
    await ApiService.postMultipartMultipleFilesMethod(
      authHeader: true,
      apiUrl: AppUrl.kycAuthentication,
      formData: formData,
      executionMethod: (bool success, dynamic responseData) {
        if (success) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.success,
              errorMessage: responseData['message'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.error,
              errorMessage: responseData['message'],
            ),
          );
        }
      },
    );
  } catch (e) {
    emit(
      state.copyWith(authStatus: AuthStatus.error, errorMessage: 'error: $e'),
    );
  }
}

}
