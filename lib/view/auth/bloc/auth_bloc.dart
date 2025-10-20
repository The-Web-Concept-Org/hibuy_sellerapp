import 'dart:convert';
import 'dart:developer';
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
    on<LoadKycDataToAuthStateEvent>(_loadKycDataToAuthState);
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
            log("responseData: $responseData");
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
      log("error: $e");
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
      final Map<String, dynamic> formData = {
        // ---------- PERSONAL INFO ----------
        "personal_status": "pending",
        if (state.personalFullName?.isNotEmpty ?? false)
          "personal_full_name": state.personalFullName,
        if (state.personalAddress?.isNotEmpty ?? false)
          "personal_address": state.personalAddress,
        if (state.personalPhoneNo?.isNotEmpty ?? false)
          "personal_phone_no": state.personalPhoneNo,
        if (state.personalEmail?.isNotEmpty ?? false)
          "personal_email": state.personalEmail,
        if (state.personalCnic?.isNotEmpty ?? false)
          "personal_cnic": state.personalCnic,
        if (state.personalProfilePicture != null)
          "personal_profile_picture": state.personalProfilePicture,
        if (state.personalFrontImage != null)
          "personal_front_image": state.personalFrontImage,
        if (state.personalBackImage != null)
          "personal_back_image": state.personalBackImage,
        // ---------- STORE INFO ----------
        "store_status": "pending",
        if (state.storeName?.isNotEmpty ?? false)
          "store_store_name": state.storeName,
        if (state.storeType?.isNotEmpty ?? false) "store_type": state.storeType,
        if (state.storePhoneNo?.isNotEmpty ?? false)
          "store_phone_no": state.storePhoneNo,
        if (state.storeEmail?.isNotEmpty ?? false)
          "store_email": state.storeEmail,
        if (state.storeCountry?.isNotEmpty ?? false)
          "store_country": state.storeCountry,
        if (state.storeProvince?.isNotEmpty ?? false)
          "store_province": state.storeProvince,
        if (state.storeCity?.isNotEmpty ?? false) "store_city": state.storeCity,
        if (state.storeZipCode?.isNotEmpty ?? false)
          "store_zip_code": state.storeZipCode,
        if (state.storeAddress?.isNotEmpty ?? false)
          "store_address": state.storeAddress,
        if (state.storePinLocation?.isNotEmpty ?? false)
          "store_pin_location": state.storePinLocation,
        if (state.storeProfilePicture != null)
          "store_profile_picture_store": state.storeProfilePicture,
        // ---------- DOCUMENTS INFO ----------
        "documents_status": "pending",
        if (state.documentsCountry?.isNotEmpty ?? false)
          "documents_country": state.documentsCountry,
        if (state.documentsProvince?.isNotEmpty ?? false)
          "documents_province": state.documentsProvince,
        if (state.documentsCity?.isNotEmpty ?? false)
          "documents_city": state.documentsCity,
        if (state.documentsHomeBill != null)
          "documents_home_bill": state.documentsHomeBill,
        if (state.documentsShopVideo != null)
          "documents_shop_video": state.documentsShopVideo,
        // ---------- BANK INFO ----------
        "bank_status": "pending",
        if (event.accountType.isNotEmpty)
          "bank_account_type": event.accountType,
        if (event.bankName.isNotEmpty) "bank_bank_name": event.bankName,
        if (event.branchCode.isNotEmpty) "bank_branch_code": event.branchCode,
        if (event.branchName.isNotEmpty) "bank_branch_name": event.branchName,
        if (event.branchPhone.isNotEmpty)
          "bank_branch_phone": event.branchPhone,
        if (event.accountTitle.isNotEmpty)
          "bank_account_title": event.accountTitle,
        if (event.accountNo.isNotEmpty) "bank_account_no": event.accountNo,
        if (event.ibanNo.isNotEmpty) "bank_iban_no": event.ibanNo,
        if (event.canceledCheque != null)
          "bank_canceled_cheque": event.canceledCheque,
        if (event.verificationLetter != null)
          "bank_verification_letter": event.verificationLetter,
        // ---------- BUSINESS INFO ----------
        "business_status": "pending",
        if (state.businessOwnerName?.isNotEmpty ?? false)
          "business_owner_name": state.businessOwnerName,
        if (state.businessName?.isNotEmpty ?? false)
          "business_business_name": state.businessName,
        if (state.businessPhoneNo?.isNotEmpty ?? false)
          "business_phone_no": state.businessPhoneNo,
        if (state.businessRegNo?.isNotEmpty ?? false)
          "business_reg_no": state.businessRegNo,
        if (state.businessTaxNo?.isNotEmpty ?? false)
          "business_tax_no": state.businessTaxNo,
        if (state.businessAddress?.isNotEmpty ?? false)
          "business_address": state.businessAddress,
        if (state.businessPinLocation?.isNotEmpty ?? false)
          "business_pin_location": state.businessPinLocation,
        if (state.businessPersonalProfile != null)
          "business_personal_profile": state.businessPersonalProfile,
        if (state.businessLetterHead != null)
          "business_letter_head": state.businessLetterHead,
        if (state.businessStamp != null) "business_stamp": state.businessStamp,
      };

      // final Map<String, dynamic> formData = {
      //   // ---------- PERSONAL INFO ----------
      //   "personal_status": "pending",
      //   "personal_full_name": "asad",
      //   "personal_address": "abc",
      //   "personal_phone_no": "03061212445",
      //   "personal_email": "abc@gmail.com",
      //   "personal_cnic": "3310015144215",
      //   "personal_profile_picture": state.personalProfilePicture,
      //   "personal_front_image": state.personalFrontImage,
      //   "personal_back_image": state.personalBackImage,
      //   // ---------- STORE INFO ----------
      //   "store_status": "pending",
      //   "store_store_name": "abc",
      //   "store_type": "Retail",
      //   "store_phone_no": "03011010112",
      //   "store_email": "abc@gmail.com",
      //   "store_country": "Pakistan",
      //   "store_province": "Punjab",
      //   "store_city": "faisalabad",
      //   "store_zip_code": "380000",
      //   "store_address": "abc",
      //   "store_pin_location": "31.4201412,73.1177326",
      //   "store_profile_picture_store": state.storeProfilePicture,
      //   // ---------- DOCUMENTS INFO ----------
      //   "documents_status": "pending",
      //   "documents_country": "Pakistan",
      //   "documents_province": 'pubjab',
      //   "documents_city": "faisalabad",
      //   "documents_home_bill": state.documentsHomeBill,

      //   // "documents_shop_video": state.documentsShopVideo,
      //   "documents_shop_video": null,

      //   // ---------- BANK INFO ----------
      //   "bank_status": "pending",
      //   "bank_account_type": "savings",
      //   "bank_bank_name": "abv",
      //   "bank_branch_code": "1122",
      //   "bank_branch_name": "abc",

      //   "bank_branch_phone": "03062525123",

      //   "bank_account_title": "abc",
      //   "bank_account_no": "0100236547896325",
      //   "bank_iban_no": "pk12354789651212",
      //   "bank_canceled_cheque": event.canceledCheque,
      //   "bank_verification_letter": event.verificationLetter,
      //   // ---------- BUSINESS INFO ----------
      //   "business_status": "pending",
      //   "business_owner_name": "abc",
      //   "business_business_name": "avbc",
      //   "business_phone_no": "03062525123",
      //   "business_reg_no": '1236547',
      //   "business_tax_no": "123456",
      //   "business_address": "abc",
      //   "business_pin_location": "31.4201412,73.1177326",
      //   "business_personal_profile": state.businessPersonalProfile,
      //   "business_letter_head": state.businessLetterHead,
      //   "business_stamp": state.businessStamp,
      // };

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

  // ------------------ LOAD KYC DATA TO AUTH STATE (FOR EDITING) ------------------
  void _loadKycDataToAuthState(
    LoadKycDataToAuthStateEvent event,
    Emitter<AuthState> emit,
  ) {
    log("📥 Loading KYC data to AuthState for editing");

    final seller = event.kycResponse.seller;
    if (seller == null) {
      log("⚠️ No seller data in KYC response");
      return;
    }

    // Extract all the data from the KYC response
    final personalInfo = seller.personalInfo;
    final storeInfo = seller.storeInfo;
    final documentsInfo = seller.documentsInfo;
    final bankInfo = seller.bankInfo;
    final businessInfo = seller.businessInfo;

    emit(
      state.copyWith(
        // ✅ Set edit mode flag to true
        isEditMode: true,

        // Personal Info - Text Fields
        personalFullName: personalInfo?.fullName,
        personalAddress: personalInfo?.address,
        personalPhoneNo: personalInfo?.phoneNo,
        personalEmail: personalInfo?.email,
        personalCnic: personalInfo?.cnic,

        // Personal Info - Network Image URLs
        personalProfilePictureUrl: personalInfo?.profilePicture,
        personalFrontImageUrl: personalInfo?.frontImage,
        personalBackImageUrl: personalInfo?.backImage,

        // Store Info - Text Fields
        storeName: storeInfo?.storeName,
        storeType: storeInfo?.type,
        storePhoneNo: storeInfo?.phoneNo,
        storeEmail: storeInfo?.email,
        storeCountry: storeInfo?.country,
        storeProvince: storeInfo?.province,
        storeCity: storeInfo?.city,
        storeZipCode: storeInfo?.zipCode,
        storeAddress: storeInfo?.address,
        storePinLocation: storeInfo?.pinLocation,

        // Store Info - Network Image URL
        storeProfilePictureUrl: storeInfo?.profilePictureStore,

        // Documents Info - Text Fields
        documentsCountry: documentsInfo?.country,
        documentsProvince: documentsInfo?.province,
        documentsCity: documentsInfo?.city,

        // Documents Info - Network URLs
        documentsHomeBillUrl: documentsInfo?.homeBill,
        documentsShopVideoUrl: documentsInfo?.shopVideo,

        // Bank Info - Text Fields
        bankAccountType: bankInfo?.accountType,
        bankBankName: bankInfo?.bankName,
        bankBranchCode: bankInfo?.branchCode,
        bankBranchName: bankInfo?.branchName,
        bankBranchPhone: bankInfo?.branchPhone,
        bankAccountTitle: bankInfo?.accountTitle,
        bankAccountNo: bankInfo?.accountNo,
        bankIbanNo: bankInfo?.ibanNo,

        // Bank Info - Network Image URLs
        bankCanceledChequeUrl: bankInfo?.canceledCheque,
        bankVerificationLetterUrl: bankInfo?.verificationLetter,

        // Business Info - Text Fields
        businessName: businessInfo?.businessName,
        businessOwnerName: businessInfo?.ownerName,
        businessPhoneNo: businessInfo?.phoneNo,
        businessRegNo: businessInfo?.regNo,
        businessTaxNo: businessInfo?.taxNo,
        businessAddress: businessInfo?.address,
        businessPinLocation: businessInfo?.pinLocation,

        // Business Info - Network Image URLs
        businessPersonalProfileUrl: businessInfo?.personalProfile,
        businessLetterHeadUrl: businessInfo?.letterHead,
        businessStampUrl: businessInfo?.stamp,
      ),
    );

    log("✅ KYC data loaded to AuthState successfully");
    log("📸 Personal Profile URL: ${personalInfo?.profilePicture}");
    log("📸 Store Profile URL: ${storeInfo?.profilePictureStore}");
    log("📸 Documents Home Bill URL: ${documentsInfo?.homeBill}");
    log("🎥 Documents Shop Video URL: ${documentsInfo?.shopVideo}");
  }
}
