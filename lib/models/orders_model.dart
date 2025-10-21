class OrdersResponse {
  final bool success;
  final String message;
  final List<OrderData> data;

  OrdersResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => OrderData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderData {
  final int orderId;
  final int userId;
  final String trackingId;
  final double total;
  final double deliveryFee;
  final String customerName;
  final int phone;
  final String address;
  final String status;
  final String orderStatus;
  final int paid;
  final int? riderId;
  final String? trackingNumber;
  final String orderDate;
  final double orderTotal;
  final double grandTotal;
  final double grandDiscount;
  final double netTotal;
  final dynamic rider;

  OrderData({
    required this.orderId,
    required this.userId,
    required this.trackingId,
    required this.total,
    required this.deliveryFee,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.status,
    required this.orderStatus,
    required this.paid,
    this.riderId,
    this.trackingNumber,
    required this.orderDate,
    required this.orderTotal,
    required this.grandTotal,
    required this.grandDiscount,
    required this.netTotal,
    this.rider,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['order_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      trackingId: json['tracking_id'] ?? '',
      total: (json['total'] ?? 0).toDouble(),
      deliveryFee: (json['delivery_fee'] ?? 0).toDouble(),
      customerName: json['customer_name'] ?? '',
      phone: json['phone'] ?? 0,
      address: json['address'] ?? '',
      status: json['status'] ?? '',
      orderStatus: json['order_status'] ?? '',
      paid: json['paid'] ?? 0,
      riderId: json['rider_id'],
      trackingNumber: json['tracking_number'],
      orderDate: json['order_date'] ?? '',
      orderTotal: (json['order_total'] ?? 0).toDouble(),
      grandTotal: (json['grand_total'] ?? 0).toDouble(),
      grandDiscount: (json['grand_discount'] ?? 0).toDouble(),
      netTotal: (json['net_total'] ?? 0).toDouble(),
      rider: json['rider'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'tracking_id': trackingId,
      'total': total,
      'delivery_fee': deliveryFee,
      'customer_name': customerName,
      'phone': phone,
      'address': address,
      'status': status,
      'order_status': orderStatus,
      'paid': paid,
      'rider_id': riderId,
      'tracking_number': trackingNumber,
      'order_date': orderDate,
      'order_total': orderTotal,
      'grand_total': grandTotal,
      'grand_discount': grandDiscount,
      'net_total': netTotal,
      'rider': rider,
    };
  }
}
