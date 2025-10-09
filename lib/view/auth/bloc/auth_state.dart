import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hibuy/models/kyc_response_model.dart';
import '../../../models/user_model.dart';

// Enums
enum AuthStatus { initial, loading, success, error }
enum PersonalStatus { initial, loading, success, error }
enum StoreStatus { initial, loading, success, error }
enum DocumentsStatus { initial, loading, success, error }
enum BankStatus { initial, loading, success, error }
enum BusinessStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String? errorMessage;
  final UserModel? userModel;

  // Personal
  final PersonalStatus personalStatus;
  final String? personalFullName;
  final String? personalAddress;
  final String? personalPhoneNo;
  final String? personalEmail;
  final String? personalCnic;
  final File? personalProfilePicture;
  final File? personalFrontImage;
  final File? personalBackImage;

  // Store
  final StoreStatus storeStatus;
  final String? storeName;
  final String? storeType;
  final String? storePhoneNo;
  final String? storeEmail;
  final String? storeCountry;
  final String? storeProvince;
  final String? storeCity;
  final String? storeZipCode;
  final String? storeAddress;
  final String? storePinLocation;
  final File? storeProfilePicture;

  // Documents
  final DocumentsStatus documentsStatus;
  final String? documentsCountry;
  final String? documentsProvince;
  final String? documentsCity;
  final File? documentsHomeBill;
  final File? documentsShopVideo;

  // Bank
  final BankStatus bankStatus;
  final String? bankAccountType;
  final String? bankBankName;
  final String? bankBranchCode;
  final String? bankBranchName;
  final String? bankBranchPhone;
  final String? bankAccountTitle;
  final String? bankAccountNo;
  final String? bankIbanNo;
  final File? bankCanceledCheque;
  final File? bankVerificationLetter;

  // Business
  final BusinessStatus businessStatus;
  final String? businessName;
  final String? businessOwnerName;
  final String? businessPhoneNo;
  final String? businessRegNo;
  final String? businessTaxNo;
  final String? businessAddress;
  final String? businessPinLocation;
  final File? businessPersonalProfile;
  final File? businessLetterHead;
  final File? businessStamp;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.errorMessage = '',
    this.userModel,

    // Personal
    this.personalStatus = PersonalStatus.initial,
    this.personalFullName,
    this.personalAddress,
    this.personalPhoneNo,
    this.personalEmail,
    this.personalCnic,
    this.personalProfilePicture,
    this.personalFrontImage,
    this.personalBackImage,

    // Store
    this.storeStatus = StoreStatus.initial,
    this.storeName,
    this.storeType,
    this.storePhoneNo,
    this.storeEmail,
    this.storeCountry,
    this.storeProvince,
    this.storeCity,
    this.storeZipCode,
    this.storeAddress,
    this.storePinLocation,
    this.storeProfilePicture,

    // Documents
    this.documentsStatus = DocumentsStatus.initial,
    this.documentsCountry,
    this.documentsProvince,
    this.documentsCity,
    this.documentsHomeBill,
    this.documentsShopVideo,

    // Bank
    this.bankStatus = BankStatus.initial,
    this.bankAccountType,
    this.bankBankName,
    this.bankBranchCode,
    this.bankBranchName,
    this.bankBranchPhone,
    this.bankAccountTitle,
    this.bankAccountNo,
    this.bankIbanNo,
    this.bankCanceledCheque,
    this.bankVerificationLetter,

    // Business
    this.businessStatus = BusinessStatus.initial,
    this.businessName,
    this.businessOwnerName,
    this.businessPhoneNo,
    this.businessRegNo,
    this.businessTaxNo,
    this.businessAddress,
    this.businessPinLocation,
    this.businessPersonalProfile,
    this.businessLetterHead,
    this.businessStamp,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    String? errorMessage,
    UserModel? userModel,

    // Personal
    PersonalStatus? personalStatus,
    String? personalFullName,
    String? personalAddress,
    String? personalPhoneNo,
    String? personalEmail,
    String? personalCnic,
    File? personalProfilePicture,
    File? personalFrontImage,
    File? personalBackImage,

    // Store
    StoreStatus? storeStatus,
    String? storeName,
    String? storeType,
    String? storePhoneNo,
    String? storeEmail,
    String? storeCountry,
    String? storeProvince,
    String? storeCity,
    String? storeZipCode,
    String? storeAddress,
    String? storePinLocation,
    File? storeProfilePicture,

    // Documents
    DocumentsStatus? documentsStatus,
    String? documentsCountry,
    String? documentsProvince,
    String? documentsCity,
    File? documentsHomeBill,
    File? documentsShopVideo,

    // Bank
    BankStatus? bankStatus,
    String? bankAccountType,
    String? bankBankName,
    String? bankBranchCode,
    String? bankBranchName,
    String? bankBranchPhone,
    String? bankAccountTitle,
    String? bankAccountNo,
    String? bankIbanNo,
    File? bankCanceledCheque,
    File? bankVerificationLetter,

    // Business
    BusinessStatus? businessStatus,
    String? businessName,
    String? businessOwnerName,
    String? businessPhoneNo,
    String? businessRegNo,
    String? businessTaxNo,
    String? businessAddress,
    String? businessPinLocation,
    File? businessPersonalProfile,
    File? businessLetterHead,
    File? businessStamp,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,

      // Personal
      personalStatus: personalStatus ?? this.personalStatus,
      personalFullName: personalFullName ?? this.personalFullName,
      personalAddress: personalAddress ?? this.personalAddress,
      personalPhoneNo: personalPhoneNo ?? this.personalPhoneNo,
      personalEmail: personalEmail ?? this.personalEmail,
      personalCnic: personalCnic ?? this.personalCnic,
      personalProfilePicture: personalProfilePicture ?? this.personalProfilePicture,
      personalFrontImage: personalFrontImage ?? this.personalFrontImage,
      personalBackImage: personalBackImage ?? this.personalBackImage,

      // Store
      storeStatus: storeStatus ?? this.storeStatus,
      storeName: storeName ?? this.storeName,
      storeType: storeType ?? this.storeType,
      storePhoneNo: storePhoneNo ?? this.storePhoneNo,
      storeEmail: storeEmail ?? this.storeEmail,
      storeCountry: storeCountry ?? this.storeCountry,
      storeProvince: storeProvince ?? this.storeProvince,
      storeCity: storeCity ?? this.storeCity,
      storeZipCode: storeZipCode ?? this.storeZipCode,
      storeAddress: storeAddress ?? this.storeAddress,
      storePinLocation: storePinLocation ?? this.storePinLocation,
      storeProfilePicture: storeProfilePicture ?? this.storeProfilePicture,

      // Documents
      documentsStatus: documentsStatus ?? this.documentsStatus,
      documentsCountry: documentsCountry ?? this.documentsCountry,
      documentsProvince: documentsProvince ?? this.documentsProvince,
      documentsCity: documentsCity ?? this.documentsCity,
      documentsHomeBill: documentsHomeBill ?? this.documentsHomeBill,
      documentsShopVideo: documentsShopVideo ?? this.documentsShopVideo,

      // Bank
      bankStatus: bankStatus ?? this.bankStatus,
      bankAccountType: bankAccountType ?? this.bankAccountType,
      bankBankName: bankBankName ?? this.bankBankName,
      bankBranchCode: bankBranchCode ?? this.bankBranchCode,
      bankBranchName: bankBranchName ?? this.bankBranchName,
      bankBranchPhone: bankBranchPhone ?? this.bankBranchPhone,
      bankAccountTitle: bankAccountTitle ?? this.bankAccountTitle,
      bankAccountNo: bankAccountNo ?? this.bankAccountNo,
      bankIbanNo: bankIbanNo ?? this.bankIbanNo,
      bankCanceledCheque: bankCanceledCheque ?? this.bankCanceledCheque,
      bankVerificationLetter: bankVerificationLetter ?? this.bankVerificationLetter,

      // Business
      businessStatus: businessStatus ?? this.businessStatus,
      businessName: businessName ?? this.businessName,
      businessOwnerName: businessOwnerName ?? this.businessOwnerName,
      businessPhoneNo: businessPhoneNo ?? this.businessPhoneNo,
      businessRegNo: businessRegNo ?? this.businessRegNo,
      businessTaxNo: businessTaxNo ?? this.businessTaxNo,
      businessAddress: businessAddress ?? this.businessAddress,
      businessPinLocation: businessPinLocation ?? this.businessPinLocation,
      businessPersonalProfile: businessPersonalProfile ?? this.businessPersonalProfile,
      businessLetterHead: businessLetterHead ?? this.businessLetterHead,
      businessStamp: businessStamp ?? this.businessStamp,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        errorMessage,
        userModel,

        // Personal
        personalStatus,
        personalFullName,
        personalAddress,
        personalPhoneNo,
        personalEmail,
        personalCnic,
        personalProfilePicture,
        personalFrontImage,
        personalBackImage,

        // Store
        storeStatus,
        storeName,
        storeType,
        storePhoneNo,
        storeEmail,
        storeCountry,
        storeProvince,
        storeCity,
        storeZipCode,
        storeAddress,
        storePinLocation,
        storeProfilePicture,

        // Documents
        documentsStatus,
        documentsCountry,
        documentsProvince,
        documentsCity,
        documentsHomeBill,
        documentsShopVideo,

        // Bank
        bankStatus,
        bankAccountType,
        bankBankName,
        bankBranchCode,
        bankBranchName,
        bankBranchPhone,
        bankAccountTitle,
        bankAccountNo,
        bankIbanNo,
        bankCanceledCheque,
        bankVerificationLetter,

        // Business
        businessStatus,
        businessName,
        businessOwnerName,
        businessPhoneNo,
        businessRegNo,
        businessTaxNo,
        businessAddress,
        businessPinLocation,
        businessPersonalProfile,
        businessLetterHead,
        businessStamp,
      ];
      
}
