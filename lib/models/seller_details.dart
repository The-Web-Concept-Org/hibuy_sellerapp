// class SellerDetails {
//   final String name;
//   final String email;
//   final int phone;
//   final String address;
//   final String profilePicture;

//   SellerDetails({
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.profilePicture,

//   });

//   // From JSON
//   factory SellerDetails.fromJson(Map<String, dynamic> json) {
//     return SellerDetails(
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       phone: json['phone'] ?? 0,
//       address: json['address'] ?? '',
//       profilePicture: json['profile_picture'] ?? '',

//     );
//   }

//   // To JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'address': address,
//       'profile_picture': profilePicture,

//     };
//   }
// }
import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'seller_details.g.dart'; // required for Hive code generation

@HiveType(typeId: 0)
class SellerDetails extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final int phone;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String? profilePicture;

  @HiveField(5)
  final String referralLink;

  @HiveField(6)
  final String encodedUserId;
  @HiveField(7)
  final Uint8List? profileImageFile;

  SellerDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.profilePicture,
    required this.referralLink,
    required this.encodedUserId,
    this.profileImageFile,
  });

  // From JSON
  factory SellerDetails.fromJson(Map<String, dynamic> json) {
    return SellerDetails(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? 0,
      address: json['address'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      referralLink: json['referralLink'] ?? '',
      encodedUserId: json['encodedUserId'] ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profile_picture': profilePicture,
      'referralLink': referralLink,
      'encodedUserId': encodedUserId,
    };
  }
}
