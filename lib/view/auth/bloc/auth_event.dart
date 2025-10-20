import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hibuy/models/kyc_response_model.dart';

abstract class AuthEvent extends Equatable {}

// ✅ Login Event
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// ✅ Signup Event
class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role; // freelancer or seller

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [name, email, password, role];
}

// ✅ Personal Info Event
class SavePersonalInfoEvent extends AuthEvent {
  final String fullName;
  final String address;
  final String phoneNo;
  final String email;
  final String cnic;
  final File? profilePicture;
  final File? frontImage;
  final File? backImage;

  SavePersonalInfoEvent({
    required this.fullName,
    required this.address,
    required this.phoneNo,
    required this.email,
    required this.cnic,
    this.profilePicture,
    this.frontImage,
    this.backImage,
  });

  @override
  List<Object?> get props => [
    fullName,
    address,
    phoneNo,
    email,
    cnic,
    profilePicture,
    frontImage,
    backImage,
  ];
}

// ✅ Store Info Event
class SaveStoreInfoEvent extends AuthEvent {
  final String storeName;
  final String type;
  final String phoneNo;
  final String email;
  final String country;
  final String province;
  final String city;
  final String zipCode;
  final String address;
  final String pinLocation;
  final File? profilePicture;

  SaveStoreInfoEvent({
    required this.storeName,
    required this.type,
    required this.phoneNo,
    required this.email,
    required this.country,
    required this.province,
    required this.city,
    required this.zipCode,
    required this.address,
    required this.pinLocation,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
    storeName,
    type,
    phoneNo,
    email,
    country,
    province,
    city,
    zipCode,
    address,
    pinLocation,
    profilePicture,
  ];
}

// ✅ Documents Info Event
class SaveDocumentsInfoEvent extends AuthEvent {
  final String country;
  final String province;
  final String city;
  final File? homeBill;
  final File? shopVideo;

  SaveDocumentsInfoEvent({
    required this.country,
    required this.province,
    required this.city,
    this.homeBill,
    this.shopVideo,
  });

  @override
  List<Object?> get props => [country, province, city, homeBill, shopVideo];
}

// ✅ Bank Info Event
class SaveBankInfoEvent extends AuthEvent {
  final String accountType;
  final String bankName;
  final String branchCode;
  final String branchName;
  final String branchPhone;
  final String accountTitle;
  final String accountNo;
  final String ibanNo;
  final File? canceledCheque;
  final File? verificationLetter;

  SaveBankInfoEvent({
    required this.accountType,
    required this.bankName,
    required this.branchCode,
    required this.branchName,
    required this.branchPhone,
    required this.accountTitle,
    required this.accountNo,
    required this.ibanNo,
    this.canceledCheque,
    this.verificationLetter,
  });

  @override
  List<Object?> get props => [
    accountType,
    bankName,
    branchCode,
    branchName,
    branchPhone,
    accountTitle,
    accountNo,
    ibanNo,
    canceledCheque,
    verificationLetter,
  ];
}

// ✅ Business Info Event
class SaveBusinessInfoEvent extends AuthEvent {
  final String businessName;
  final String ownerName;
  final String phoneNo;
  final String regNo;
  final String taxNo;
  final String address;
  final String pinLocation;
  final File? businessPersonalProfile;
  final File? letterHead;
  final File? stamp;

  SaveBusinessInfoEvent({
    required this.businessName,
    required this.ownerName,
    required this.phoneNo,
    required this.regNo,
    required this.taxNo,
    required this.address,
    required this.pinLocation,
    this.letterHead,
    this.stamp,
    this.businessPersonalProfile,
  });

  @override
  List<Object?> get props => [
    businessName,
    ownerName,
    phoneNo,
    regNo,
    taxNo,
    address,
    businessPersonalProfile,
    pinLocation,
    letterHead,
    stamp,
  ];
}

// ✅ Submit All Forms Event (Final API Call)
class SubmitAllFormsEvent extends AuthEvent {
  final String accountType;
  final String bankName;
  final String branchCode;
  final String branchName;
  final String branchPhone;
  final String accountTitle;
  final String accountNo;
  final String ibanNo;
  final File? canceledCheque;
  final File? verificationLetter;
  final File? businessPersonalProfile;
  final File? letterHead;
  final File? stamp;
  final File? profilePicture;
  final File? frontImage;
  final File? backImage;
  final File? homeBill;
  final File? shopVideo;
  final File? BusinessImage;

  SubmitAllFormsEvent({
    required this.accountType,
    required this.bankName,
    required this.branchCode,
    required this.branchName,
    required this.branchPhone,
    required this.accountTitle,
    required this.accountNo,
    required this.ibanNo,
    this.canceledCheque,
    this.verificationLetter,
    this.businessPersonalProfile,
    this.letterHead,
    this.stamp,
    this.profilePicture,
    this.frontImage,
    this.backImage,
    this.homeBill,
    this.shopVideo,
    this.BusinessImage,
  });
  @override
  List<Object?> get props => [
    accountType,
    bankName,
    branchCode,
    branchName,
    branchPhone,
    accountTitle,
    accountNo,
    ibanNo,
    canceledCheque,
    verificationLetter,
    businessPersonalProfile,
    letterHead,
    BusinessImage,
    stamp,
    profilePicture,
    frontImage,
    backImage,
    homeBill,
    shopVideo,
  ];
}

// ✅ Load KYC Data to Auth State Event (for editing)
class LoadKycDataToAuthStateEvent extends AuthEvent {
  final KycResponse kycResponse;

  LoadKycDataToAuthStateEvent({required this.kycResponse});

  @override
  List<Object?> get props => [kycResponse];
}

// ✅ Logout Event
class LogoutEvent extends AuthEvent {
  LogoutEvent();

  @override
  List<Object?> get props => [];
}
