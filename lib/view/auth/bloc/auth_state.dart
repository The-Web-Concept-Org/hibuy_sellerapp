import 'dart:io';

import 'package:equatable/equatable.dart';
import '../../../models/user_model.dart';

// Enums
enum AuthStatus { initial, loading, success, error }

enum LogoutStatus { initial, loading, success, error }

enum PersonalStatus { initial, loading, success, error }

enum StoreStatus { initial, loading, success, error }

enum DocumentsStatus { initial, loading, success, error }

enum BankStatus { initial, loading, success, error }

enum BusinessStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final LogoutStatus logoutStatus;
  final String? errorMessage;
  final UserModel? userModel;

  // ✅ Flag to indicate if data is loaded from KYC (for showing network images)
  final bool isEditMode;

  final String? personalInfoRejectReason;
  final String? storeInfoRejectReason;
  final String? documentInfoRejectReason;
  final String? bankInfoRejectReason;
  final String? businessInfoRejectReason;

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
  // Network URLs for personal images
  final String? personalProfilePictureUrl;
  final String? personalFrontImageUrl;
  final String? personalBackImageUrl;

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
  // Network URL for store image
  final String? storeProfilePictureUrl;

  // Documents
  final DocumentsStatus documentsStatus;
  final String? documentsCountry;
  final String? documentsProvince;
  final String? documentsCity;
  final File? documentsHomeBill;
  final File? documentsShopVideo;
  // Network URLs for document images/videos
  final String? documentsHomeBillUrl;
  final String? documentsShopVideoUrl;

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
  // Network URLs for bank images
  final String? bankCanceledChequeUrl;
  final String? bankVerificationLetterUrl;

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
  // Network URLs for business images
  final String? businessPersonalProfileUrl;
  final String? businessLetterHeadUrl;
  final String? businessStampUrl;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.logoutStatus = LogoutStatus.initial,
    this.errorMessage = '',
    this.userModel,
    this.isEditMode = false,
    this.personalInfoRejectReason,
    this.storeInfoRejectReason,
    this.documentInfoRejectReason,
    this.bankInfoRejectReason,
    this.businessInfoRejectReason,
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
    this.personalProfilePictureUrl,
    this.personalFrontImageUrl,
    this.personalBackImageUrl,

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
    this.storeProfilePictureUrl,

    // Documents
    this.documentsStatus = DocumentsStatus.initial,
    this.documentsCountry,
    this.documentsProvince,
    this.documentsCity,
    this.documentsHomeBill,
    this.documentsShopVideo,
    this.documentsHomeBillUrl,
    this.documentsShopVideoUrl,

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
    this.bankCanceledChequeUrl,
    this.bankVerificationLetterUrl,

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
    this.businessPersonalProfileUrl,
    this.businessLetterHeadUrl,
    this.businessStampUrl,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    LogoutStatus? logoutStatus,
    String? errorMessage,
    UserModel? userModel,
    bool? isEditMode,
    String? personalInfoRejectReason,
    String? storeInfoRejectReason,
    String? documentInfoRejectReason,
    String? bankInfoRejectReason,
    String? businessInfoRejectReason,
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
    String? personalProfilePictureUrl,
    String? personalFrontImageUrl,
    String? personalBackImageUrl,

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
    String? storeProfilePictureUrl,

    // Documents
    DocumentsStatus? documentsStatus,
    String? documentsCountry,
    String? documentsProvince,
    String? documentsCity,
    File? documentsHomeBill,
    File? documentsShopVideo,
    String? documentsHomeBillUrl,
    String? documentsShopVideoUrl,

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
    String? bankCanceledChequeUrl,
    String? bankVerificationLetterUrl,

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
    String? businessPersonalProfileUrl,
    String? businessLetterHeadUrl,
    String? businessStampUrl,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
      isEditMode: isEditMode ?? this.isEditMode,
      personalInfoRejectReason:
          personalInfoRejectReason ?? this.personalInfoRejectReason,
      storeInfoRejectReason:
          storeInfoRejectReason ?? this.storeInfoRejectReason,
      documentInfoRejectReason:
          documentInfoRejectReason ?? this.documentInfoRejectReason,
      bankInfoRejectReason: bankInfoRejectReason ?? this.bankInfoRejectReason,
      businessInfoRejectReason:
          businessInfoRejectReason ?? this.businessInfoRejectReason,

      // Personal
      personalStatus: personalStatus ?? this.personalStatus,
      personalFullName: personalFullName ?? this.personalFullName,
      personalAddress: personalAddress ?? this.personalAddress,
      personalPhoneNo: personalPhoneNo ?? this.personalPhoneNo,
      personalEmail: personalEmail ?? this.personalEmail,
      personalCnic: personalCnic ?? this.personalCnic,
      personalProfilePicture:
          personalProfilePicture ?? this.personalProfilePicture,
      personalFrontImage: personalFrontImage ?? this.personalFrontImage,
      personalBackImage: personalBackImage ?? this.personalBackImage,
      personalProfilePictureUrl:
          personalProfilePictureUrl ?? this.personalProfilePictureUrl,
      personalFrontImageUrl:
          personalFrontImageUrl ?? this.personalFrontImageUrl,
      personalBackImageUrl: personalBackImageUrl ?? this.personalBackImageUrl,

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
      storeProfilePictureUrl:
          storeProfilePictureUrl ?? this.storeProfilePictureUrl,

      // Documents
      documentsStatus: documentsStatus ?? this.documentsStatus,
      documentsCountry: documentsCountry ?? this.documentsCountry,
      documentsProvince: documentsProvince ?? this.documentsProvince,
      documentsCity: documentsCity ?? this.documentsCity,
      documentsHomeBill: documentsHomeBill ?? this.documentsHomeBill,
      documentsShopVideo: documentsShopVideo ?? this.documentsShopVideo,
      documentsHomeBillUrl: documentsHomeBillUrl ?? this.documentsHomeBillUrl,
      documentsShopVideoUrl:
          documentsShopVideoUrl ?? this.documentsShopVideoUrl,

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
      bankVerificationLetter:
          bankVerificationLetter ?? this.bankVerificationLetter,
      bankCanceledChequeUrl:
          bankCanceledChequeUrl ?? this.bankCanceledChequeUrl,
      bankVerificationLetterUrl:
          bankVerificationLetterUrl ?? this.bankVerificationLetterUrl,

      // Business
      businessStatus: businessStatus ?? this.businessStatus,
      businessName: businessName ?? this.businessName,
      businessOwnerName: businessOwnerName ?? this.businessOwnerName,
      businessPhoneNo: businessPhoneNo ?? this.businessPhoneNo,
      businessRegNo: businessRegNo ?? this.businessRegNo,
      businessTaxNo: businessTaxNo ?? this.businessTaxNo,
      businessAddress: businessAddress ?? this.businessAddress,
      businessPinLocation: businessPinLocation ?? this.businessPinLocation,
      businessPersonalProfile:
          businessPersonalProfile ?? this.businessPersonalProfile,
      businessLetterHead: businessLetterHead ?? this.businessLetterHead,
      businessStamp: businessStamp ?? this.businessStamp,
      businessPersonalProfileUrl:
          businessPersonalProfileUrl ?? this.businessPersonalProfileUrl,
      businessLetterHeadUrl:
          businessLetterHeadUrl ?? this.businessLetterHeadUrl,
      businessStampUrl: businessStampUrl ?? this.businessStampUrl,
    );
  }

  @override
  List<Object?> get props => [
    authStatus,
    logoutStatus,
    errorMessage,
    userModel,
    isEditMode,
    personalInfoRejectReason,
    storeInfoRejectReason,
    documentInfoRejectReason,
    bankInfoRejectReason,
    businessInfoRejectReason,

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
    personalProfilePictureUrl,
    personalFrontImageUrl,
    personalBackImageUrl,

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
    storeProfilePictureUrl,

    // Documents
    documentsStatus,
    documentsCountry,
    documentsProvince,
    documentsCity,
    documentsHomeBill,
    documentsShopVideo,
    documentsHomeBillUrl,
    documentsShopVideoUrl,

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
    bankCanceledChequeUrl,
    bankVerificationLetterUrl,

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
    businessPersonalProfileUrl,
    businessLetterHeadUrl,
    businessStampUrl,
  ];
}
