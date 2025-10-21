// Dart model classes for the provided KYC JSON response.
// Generated for use in a Flutter project. Copy this file into your `models/` folder.

import 'dart:convert';

class KycResponse {
  final bool success;
  final String message;
  final Seller? seller;

  KycResponse({required this.success, required this.message, this.seller});

  factory KycResponse.fromJson(Map<String, dynamic> json) => KycResponse(
    success: json['success'] == true || json['success'] == 'true',
    message: json['message'] ?? '',
    seller: json['seller'] != null ? Seller.fromJson(json['seller']) : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'seller': seller?.toJson(),
  };

  @override
  String toString() => jsonEncode(toJson());
}

class Seller {
  final int? sellerId;
  final int? userId;
  final String? sellerType;
  final PersonalInfo? personalInfo;
  final StoreInfo? storeInfo;
  final DocumentsInfo? documentsInfo;
  final BankInfo? bankInfo;
  final BusinessInfo? businessInfo;
  final String? token;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final StatusImages? statusImages;

  Seller({
    this.sellerId,
    this.userId,
    this.sellerType,
    this.personalInfo,
    this.storeInfo,
    this.documentsInfo,
    this.bankInfo,
    this.businessInfo,
    this.token,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.statusImages,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    sellerId: json['seller_id'] is int
        ? json['seller_id']
        : int.tryParse('${json['seller_id']}'),
    userId: json['user_id'] is int
        ? json['user_id']
        : int.tryParse('${json['user_id']}'),
    sellerType: json['seller_type']?.toString(),
    personalInfo: json['personal_info'] != null
        ? PersonalInfo.fromJson(json['personal_info'])
        : null,
    storeInfo: json['store_info'] != null
        ? StoreInfo.fromJson(json['store_info'])
        : null,
    documentsInfo: json['documents_info'] != null
        ? DocumentsInfo.fromJson(json['documents_info'])
        : null,
    bankInfo: json['bank_info'] != null
        ? BankInfo.fromJson(json['bank_info'])
        : null,
    businessInfo: json['business_info'] != null
        ? BusinessInfo.fromJson(json['business_info'])
        : null,
    token: json['_token']?.toString(),
    status: json['status']?.toString(),
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null,
    statusImages: json['statusImages'] != null
        ? StatusImages.fromJson(json['statusImages'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'seller_id': sellerId,
    'user_id': userId,
    'seller_type': sellerType,
    'personal_info': personalInfo?.toJson(),
    'store_info': storeInfo?.toJson(),
    'documents_info': documentsInfo?.toJson(),
    'bank_info': bankInfo?.toJson(),
    'business_info': businessInfo?.toJson(),
    '_token': token,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'statusImages': statusImages?.toJson(),
  };
}

class PersonalInfo {
  final int? step;
  final String? status;
  final String? fullName;
  final String? address;
  final String? phoneNo;
  final String? email;
  final String? cnic;
  final String? profilePicture;
  final String? frontImage;
  final String? backImage;
  final String? profilePicturePath;
  final String? frontImagePath;
  final String? backImagePath;
  final String? reason;

  PersonalInfo({
    this.step,
    this.status,
    this.fullName,
    this.reason,
    this.address,
    this.phoneNo,
    this.email,
    this.cnic,
    this.profilePicture,
    this.frontImage,
    this.backImage,
    this.profilePicturePath,
    this.frontImagePath,
    this.backImagePath,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    step: json['step'] is int ? json['step'] : int.tryParse('${json['step']}'),
    status: json['status']?.toString(),
    fullName: json['full_name']?.toString(),
    address: json['address']?.toString(),
    phoneNo: json['phone_no']?.toString(),
    email: json['email']?.toString(),
    cnic: json['cnic']?.toString(),
    profilePicture: json['profile_picture']?.toString(),
    frontImage: json['front_image']?.toString(),
    backImage: json['back_image']?.toString(),
    profilePicturePath: json['profile_picture_path']?.toString(),
    frontImagePath: json['front_image_path']?.toString(),
    backImagePath: json['back_image_path']?.toString(),
    reason: json['reason']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'step': step,
    'status': status,
    'full_name': fullName,
    'address': address,
    'phone_no': phoneNo,
    'email': email,
    'cnic': cnic,
    'profile_picture': profilePicture,
    'front_image': frontImage,
    'back_image': backImage,
    'profile_picture_path': profilePicturePath,
    'front_image_path': frontImagePath,
    'back_image_path': backImagePath,
  };
}

class StoreInfo {
  final int? step;
  final String? status;
  final String? storeName;
  final String? type;
  final String? phoneNo;
  final String? email;
  final String? country;
  final String? province;
  final String? city;
  final String? zipCode;
  final String? address;
  final String? pinLocation;
  final String? profilePictureStore;
  final String? reason;

  StoreInfo({
    this.step,
    this.status,
    this.storeName,
    this.type,
    this.phoneNo,
    this.email,
    this.country,
    this.province,
    this.city,
    this.zipCode,
    this.address,
    this.pinLocation,
    this.profilePictureStore,
    this.reason,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) => StoreInfo(
    step: json['step'] is int ? json['step'] : int.tryParse('${json['step']}'),
    status: json['status']?.toString(),
    storeName: json['store_name']?.toString(),
    type: json['type']?.toString(),
    phoneNo: json['phone_no']?.toString(),
    email: json['email']?.toString(),
    country: json['country']?.toString(),
    province: json['province']?.toString(),
    city: json['city']?.toString(),
    zipCode: json['zip_code']?.toString(),
    address: json['address']?.toString(),
    pinLocation: json['pin_location']?.toString(),
    profilePictureStore: json['profile_picture_store']?.toString(),
    reason: json['reason']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'step': step,
    'status': status,
    'store_name': storeName,
    'type': type,
    'phone_no': phoneNo,
    'email': email,
    'country': country,
    'province': province,
    'city': city,
    'zip_code': zipCode,
    'address': address,
    'pin_location': pinLocation,
    'profile_picture_store': profilePictureStore,
    'reason': reason,
  };
}

class DocumentsInfo {
  final int? step;
  final String? status;
  final String? country;
  final String? province;
  final String? city;
  final String? homeBill;
  final String? shopVideo;
  final String? reason;

  DocumentsInfo({
    this.step,
    this.status,
    this.country,
    this.province,
    this.city,
    this.homeBill,
    this.shopVideo,
    this.reason,
  });

  factory DocumentsInfo.fromJson(Map<String, dynamic> json) => DocumentsInfo(
    step: json['step'] is int ? json['step'] : int.tryParse('${json['step']}'),
    status: json['status']?.toString(),
    country: json['country']?.toString(),
    province: json['province']?.toString(),
    city: json['city']?.toString(),
    homeBill: json['home_bill']?.toString(),
    shopVideo: json['shop_video']?.toString(),
    reason: json['reason']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'step': step,
    'status': status,
    'country': country,
    'province': province,
    'city': city,
    'home_bill': homeBill,
    'shop_video': shopVideo,
  };
}

class BankInfo {
  final int? step;
  final String? status;
  final String? accountType;
  final String? bankName;
  final String? branchCode;
  final String? branchName;
  final String? branchPhone;
  final String? accountTitle;
  final String? accountNo;
  final String? ibanNo;
  final String? canceledCheque;
  final String? verificationLetter;
  final String? reason;

  BankInfo({
    this.step,
    this.status,
    this.accountType,
    this.bankName,
    this.branchCode,
    this.branchName,
    this.branchPhone,
    this.accountTitle,
    this.accountNo,
    this.ibanNo,
    this.canceledCheque,
    this.verificationLetter,
    this.reason,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
    step: json['step'] is int ? json['step'] : int.tryParse('${json['step']}'),
    status: json['status']?.toString(),
    accountType: json['account_type']?.toString(),
    bankName: json['bank_name']?.toString(),
    branchCode: json['branch_code']?.toString(),
    branchName: json['branch_name']?.toString(),
    branchPhone: json['branch_phone']?.toString(),
    accountTitle: json['account_title']?.toString(),
    accountNo: json['account_no']?.toString(),
    ibanNo: json['iban_no']?.toString(),
    canceledCheque: json['canceled_cheque']?.toString(),
    verificationLetter: json['verification_letter']?.toString(),
    reason: json['reason']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'step': step,
    'status': status,
    'account_type': accountType,
    'bank_name': bankName,
    'branch_code': branchCode,
    'branch_name': branchName,
    'branch_phone': branchPhone,
    'account_title': accountTitle,
    'account_no': accountNo,
    'iban_no': ibanNo,
    'canceled_cheque': canceledCheque,
    'verification_letter': verificationLetter,
  };
}

class BusinessInfo {
  final int? step;
  final String? status;
  final String? businessName;
  final String? ownerName;
  final String? phoneNo;
  final String? regNo;
  final String? taxNo;
  final String? address;
  final String? pinLocation;
  final String? personalProfile;
  final String? letterHead;
  final String? stamp;
  final String? token;
  final String? personalProfilePath;
  final String? letterHeadPath;
  final String? stampPath;
  final String? reason;

  BusinessInfo({
    this.step,
    this.status,
    this.businessName,
    this.ownerName,
    this.phoneNo,
    this.regNo,
    this.taxNo,
    this.address,
    this.pinLocation,
    this.personalProfile,
    this.letterHead,
    this.stamp,
    this.token,
    this.personalProfilePath,
    this.letterHeadPath,
    this.stampPath,
    this.reason,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
    step: json['step'] is int ? json['step'] : int.tryParse('${json['step']}'),
    status: json['status']?.toString(),
    businessName: json['business_name']?.toString(),
    ownerName: json['owner_name']?.toString(),
    phoneNo: json['phone_no']?.toString(),
    regNo: json['reg_no']?.toString(),
    taxNo: json['tax_no']?.toString(),
    address: json['address']?.toString(),
    pinLocation: json['pin_location']?.toString(),
    personalProfile: json['personal_profile']?.toString(),
    letterHead: json['letter_head']?.toString(),
    stamp: json['stamp']?.toString(),
    token: json['_token']?.toString(),
    personalProfilePath: json['personal_profile_path']?.toString(),
    letterHeadPath: json['letter_head_path']?.toString(),
    stampPath: json['stamp_path']?.toString(),
    reason: json['reason']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'step': step,
    'status': status,
    'business_name': businessName,
    'owner_name': ownerName,
    'phone_no': phoneNo,
    'reg_no': regNo,
    'tax_no': taxNo,
    'address': address,
    'pin_location': pinLocation,
    'personal_profile': personalProfile,
    'letter_head': letterHead,
    'stamp': stamp,
    '_token': token,
    'personal_profile_path': personalProfilePath,
    'letter_head_path': letterHeadPath,
    'stamp_path': stampPath,
  };
}

class StatusImages {
  final String? personalInfo;
  final String? storeInfo;
  final String? documentsInfo;
  final String? bankInfo;
  final String? businessInfo;

  StatusImages({
    this.personalInfo,
    this.storeInfo,
    this.documentsInfo,
    this.bankInfo,
    this.businessInfo,
  });

  factory StatusImages.fromJson(Map<String, dynamic> json) => StatusImages(
    personalInfo: json['personal_info']?.toString(),
    storeInfo: json['store_info']?.toString(),
    documentsInfo: json['documents_info']?.toString(),
    bankInfo: json['bank_info']?.toString(),
    businessInfo: json['business_info']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'personal_info': personalInfo,
    'store_info': storeInfo,
    'documents_info': documentsInfo,
    'bank_info': bankInfo,
    'business_info': businessInfo,
  };
}
