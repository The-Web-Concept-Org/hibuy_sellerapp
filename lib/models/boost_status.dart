class BoostStatus {
  final int userId;
  final String? packageStatus;
  final PackageDetail? packageDetail;

  BoostStatus({required this.userId, this.packageStatus, this.packageDetail});

  factory BoostStatus.fromJson(Map<String, dynamic> json) {
    return BoostStatus(
      userId: json['user_id'] ?? 0,
      packageStatus: json['package_status'],
      packageDetail:
          json['package_detail'] != null && json['package_detail'] is Map
          ? PackageDetail.fromJson(json['package_detail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'package_status': packageStatus,
      'package_detail': packageDetail?.toJson(),
    };
  }
}

class PackageDetail {
  final String packageType;
  final String transactionImage;
  final String packageStatus;
  final String packageStartDate;
  final String packageEndDate;

  PackageDetail({
    required this.packageType,
    required this.transactionImage,
    required this.packageStatus,
    required this.packageStartDate,
    required this.packageEndDate,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) {
    return PackageDetail(
      packageType: json['package_type'] ?? '',
      transactionImage: json['transaction_image'] ?? '',
      packageStatus: json['package_status'] ?? '',
      packageStartDate: json['package_start_date'] ?? '',
      packageEndDate: json['package_end_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'package_type': packageType,
      'transaction_image': transactionImage,
      'package_status': packageStatus,
      'package_start_date': packageStartDate,
      'package_end_date': packageEndDate,
    };
  }
}
