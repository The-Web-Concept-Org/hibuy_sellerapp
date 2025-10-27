import 'package:equatable/equatable.dart';

class ReturnOrderModel extends Equatable {
  final int returnId;
  final int orderId;
  final OrderDetails? order;
  final RiderDetails? riderDetails;
  final String returnReason;
  final String returnStatus;
  final double returnGrandTotal;
  final String createdAt;

  const ReturnOrderModel({
    required this.returnId,
    required this.orderId,
    this.order,
    this.riderDetails,
    required this.returnReason,
    required this.returnStatus,
    required this.returnGrandTotal,
    required this.createdAt,
  });

  factory ReturnOrderModel.fromJson(Map<String, dynamic> json) {
    return ReturnOrderModel(
      returnId: json['return_id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      order: json['order'] != null
          ? OrderDetails.fromJson(json['order'])
          : null,
      riderDetails: json['rider_details'] != null
          ? RiderDetails.fromJson(json['rider_details'])
          : null,
      returnReason: json['return_reason'] ?? '',
      returnStatus: json['return_status'] ?? '',
      returnGrandTotal: (json['return_grand_total'] ?? 0).toDouble(),
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'return_id': returnId,
      'order_id': orderId,
      'order': order?.toJson(),
      'rider_details': riderDetails?.toJson(),
      'return_reason': returnReason,
      'return_status': returnStatus,
      'return_grand_total': returnGrandTotal,
      'created_at': createdAt,
    };
  }

  @override
  List<Object?> get props => [
    returnId,
    orderId,
    order,
    riderDetails,
    returnReason,
    returnStatus,
    returnGrandTotal,
    createdAt,
  ];
}

class OrderDetails extends Equatable {
  final int orderId;
  final String trackingId;
  final String customerName;
  final int phone;
  final String address;

  const OrderDetails({
    required this.orderId,
    required this.trackingId,
    required this.customerName,
    required this.phone,
    required this.address,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      orderId: json['order_id'] ?? 0,
      trackingId: json['tracking_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      phone: json['phone'] ?? 0,
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'tracking_id': trackingId,
      'customer_name': customerName,
      'phone': phone,
      'address': address,
    };
  }

  @override
  List<Object?> get props => [
    orderId,
    trackingId,
    customerName,
    phone,
    address,
  ];
}

class RiderDetails extends Equatable {
  final int? riderId;
  final String? riderName;
  final String? phone;
  final String? email;

  const RiderDetails({this.riderId, this.riderName, this.phone, this.email});

  factory RiderDetails.fromJson(Map<String, dynamic> json) {
    return RiderDetails(
      riderId: json['rider_id'],
      riderName: json['rider_name'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rider_id': riderId,
      'rider_name': riderName,
      'phone': phone,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [riderId, riderName, phone, email];
}
