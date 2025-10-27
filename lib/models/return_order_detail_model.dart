import 'package:equatable/equatable.dart';

class ReturnOrderDetailModel extends Equatable {
  final int returnId;
  final int orderId;
  final int userId;
  final List<ReturnItem> returnItems;
  final double returnTotal;
  final double returnDeliveryFee;
  final double returnGrandTotal;
  final String returnStatus;
  final String returnReason;
  final String returnRecieveOption;
  final String? returnAddress;
  final String returnCourier;
  final String? returnNote;
  final List<String> returnImages;
  final String createdAt;
  final String updatedAt;
  final int? riderId;
  final RiderDetails? riderDetails;
  final OrderDetails order;

  const ReturnOrderDetailModel({
    required this.returnId,
    required this.orderId,
    required this.userId,
    required this.returnItems,
    required this.returnTotal,
    required this.returnDeliveryFee,
    required this.returnGrandTotal,
    required this.returnStatus,
    required this.returnReason,
    required this.returnRecieveOption,
    this.returnAddress,
    required this.returnCourier,
    this.returnNote,
    required this.returnImages,
    required this.createdAt,
    required this.updatedAt,
    this.riderId,
    this.riderDetails,
    required this.order,
  });

  factory ReturnOrderDetailModel.fromJson(Map<String, dynamic> json) {
    return ReturnOrderDetailModel(
      returnId: json['return_id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      returnItems:
          (json['return_items'] as List<dynamic>?)
              ?.map((item) => ReturnItem.fromJson(item))
              .toList() ??
          [],
      returnTotal: (json['return_total'] ?? 0).toDouble(),
      returnDeliveryFee: (json['return_delivery_fee'] ?? 0).toDouble(),
      returnGrandTotal: (json['return_grand_total'] ?? 0).toDouble(),
      returnStatus: json['return_status'] ?? '',
      returnReason: json['return_reason'] ?? '',
      returnRecieveOption: json['return_recieve_option'] ?? '',
      returnAddress: json['return_address'],
      returnCourier: json['return_courier'] ?? '',
      returnNote: json['return_note'],
      returnImages:
          (json['return_images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      riderId: json['rider_id'],
      riderDetails:
          json['rider_details'] != null && json['rider_details'] is Map
          ? RiderDetails.fromJson(json['rider_details'])
          : null,
      order: json['order'] != null && json['order'] is Map
          ? OrderDetails.fromJson(json['order'])
          : OrderDetails(
              orderId: 0,
              trackingId: '',
              customerName: '',
              phone: 0,
              address: '',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'return_id': returnId,
      'order_id': orderId,
      'user_id': userId,
      'return_items': returnItems.map((item) => item.toJson()).toList(),
      'return_total': returnTotal,
      'return_delivery_fee': returnDeliveryFee,
      'return_grand_total': returnGrandTotal,
      'return_status': returnStatus,
      'return_reason': returnReason,
      'return_recieve_option': returnRecieveOption,
      'return_address': returnAddress,
      'return_courier': returnCourier,
      'return_note': returnNote,
      'return_images': returnImages,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'rider_id': riderId,
      'rider_details': riderDetails?.toJson(),
      'order': order.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    returnId,
    orderId,
    userId,
    returnItems,
    returnTotal,
    returnDeliveryFee,
    returnGrandTotal,
    returnStatus,
    returnReason,
    returnRecieveOption,
    returnAddress,
    returnCourier,
    returnNote,
    returnImages,
    createdAt,
    updatedAt,
    riderId,
    riderDetails,
    order,
  ];
}

class ReturnItem extends Equatable {
  final String image;
  final double price;
  final int quantity;
  final int productId;
  final String productName;
  final String? statusVideo;
  final ParentOption? parentOption;
  final String deliveryStatus;

  const ReturnItem({
    required this.image,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.productName,
    this.statusVideo,
    this.parentOption,
    required this.deliveryStatus,
  });

  factory ReturnItem.fromJson(Map<String, dynamic> json) {
    return ReturnItem(
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      productId: json['product_id'] ?? 0,

      productName: json['product_name'] ?? '',
      statusVideo: json['status_video'],
      parentOption:
          json['parent_option'] != null && json['parent_option'] is Map
          ? ParentOption.fromJson(json['parent_option'])
          : null,
      deliveryStatus: json['delivery_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'price': price,
      'quantity': quantity,
      'product_id': productId,
      'product_name': productName,
      'status_video': statusVideo,
      'parent_option': parentOption?.toJson(),
      'delivery_status': deliveryStatus,
    };
  }

  @override
  List<Object?> get props => [
    image,
    price,
    quantity,
    productId,
    productName,
    statusVideo,
    parentOption,
    deliveryStatus,
  ];
}

class ParentOption extends Equatable {
  final String? name;
  final String? value;

  const ParentOption({this.name, this.value});

  factory ParentOption.fromJson(Map<String, dynamic> json) {
    return ParentOption(
      name: json['name'],
      value: json['value'] != null ? json['value'].toString() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
  }

  @override
  List<Object?> get props => [name, value];
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
