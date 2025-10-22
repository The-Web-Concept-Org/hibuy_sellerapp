// class OrdersResponse {
//   final bool success;
//   final String message;
//   final List<OrderData> data;

//   OrdersResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory OrdersResponse.fromJson(Map<String, dynamic> json) {
//     return OrdersResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data:
//           (json['data'] as List<dynamic>?)
//               ?.map((e) => OrderData.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'message': message,
//       'data': data.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class OrderData {
//   final int orderId;
//   final int userId;
//   final String trackingId;
//   final double total;
//   final double deliveryFee;
//   final String customerName;
//   final int phone;
//   final String address;
//   final String status;
//   final String orderStatus;
//   final int paid;
//   final int? riderId;
//   final String? trackingNumber;
//   final String orderDate;
//   final double orderTotal;
//   final double grandTotal;
//   final double grandDiscount;
//   final double netTotal;
//   final Rider? rider;

//   OrderData({
//     required this.orderId,
//     required this.userId,
//     required this.trackingId,
//     required this.total,
//     required this.deliveryFee,
//     required this.customerName,
//     required this.phone,
//     required this.address,
//     required this.status,
//     required this.orderStatus,
//     required this.paid,
//     this.riderId,
//     this.trackingNumber,
//     required this.orderDate,
//     required this.orderTotal,
//     required this.grandTotal,
//     required this.grandDiscount,
//     required this.netTotal,
//     this.rider,
//   });

//   // factory OrderData.fromJson(Map<String, dynamic> json) {
//   //   return OrderData(
//   //     orderId: json['order_id'] ?? 0,
//   //     userId: json['user_id'] ?? 0,
//   //     trackingId: json['tracking_id'] ?? '',
//   //     total: (json['total'] ?? 0).toDouble(),
//   //     deliveryFee: (json['delivery_fee'] ?? 0).toDouble(),
//   //     customerName: json['customer_name'] ?? '',
//   //     phone: json['phone'] ?? 0,
//   //     address: json['address'] ?? '',
//   //     status: json['status'] ?? '',
//   //     orderStatus: json['order_status'] ?? '',
//   //     paid: json['paid'] ?? 0,
//   //     riderId: json['rider_id'],
//   //     trackingNumber: json['tracking_number'],
//   //     orderDate: json['order_date'] ?? '',
//   //     orderTotal: (json['order_total'] ?? 0).toDouble(),
//   //     grandTotal: (json['grand_total'] ?? 0).toDouble(),
//   //     grandDiscount: (json['grand_discount'] ?? 0).toDouble(),
//   //     netTotal: (json['net_total'] ?? 0).toDouble(),
//   //     rider: json['rider'] != null ? Rider.fromJson(json['rider']) : null,
//   //   );
//   // }
//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       orderId: json['order_id'] ?? 0,
//       userId: json['user_id'] ?? 0,
//       trackingId: json['tracking_id'] ?? '',
//       total: (json['total'] ?? 0).toDouble(),
//       deliveryFee: (json['delivery_fee'] ?? 0).toDouble(),
//       customerName: json['customer_name'] ?? '',
//       phone: json['phone'] ?? 0,
//       address: json['address'] ?? '',
//       status: json['status'] ?? '',
//       orderStatus: json['order_status'] ?? '',
//       paid: json['paid'] ?? 0,
//       riderId: json['rider_id'],
//       trackingNumber: json['tracking_number'] != null
//           ? json['tracking_number'].toString()
//           : null,
//       orderDate: json['order_date'] ?? '',
//       orderTotal: (json['order_total'] ?? 0).toDouble(),
//       grandTotal: (json['grand_total'] ?? 0).toDouble(),
//       grandDiscount: (json['grand_discount'] ?? 0).toDouble(),
//       netTotal: (json['net_total'] ?? 0).toDouble(),
//       rider: json['rider'] != null ? Rider.fromJson(json['rider']) : null,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'order_id': orderId,
//       'user_id': userId,
//       'tracking_id': trackingId,
//       'total': total,
//       'delivery_fee': deliveryFee,
//       'customer_name': customerName,
//       'phone': phone,
//       'address': address,
//       'status': status,
//       'order_status': orderStatus,
//       'paid': paid,
//       'rider_id': riderId,
//       'tracking_number': trackingNumber,
//       'order_date': orderDate,
//       'order_total': orderTotal,
//       'grand_total': grandTotal,
//       'grand_discount': grandDiscount,
//       'net_total': netTotal,
//       'rider': rider?.toJson(),
//     };
//   }
// }

// class Rider {
//   final int id;
//   final String riderName;
//   final String vehicleType;
//   final String riderEmail;
//   final int phone;

//   Rider({
//     required this.id,
//     required this.riderName,
//     required this.vehicleType,
//     required this.riderEmail,
//     required this.phone,
//   });

//   factory Rider.fromJson(Map<String, dynamic> json) {
//     return Rider(
//       id: json['id'] ?? 0,
//       riderName: json['rider_name'] ?? '',
//       vehicleType: json['vehicle_type'] ?? '',
//       riderEmail: json['rider_email'] ?? '',
//       phone: json['phone'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'rider_name': riderName,
//       'vehicle_type': vehicleType,
//       'rider_email': riderEmail,
//       'phone': phone,
//     };
//   }
// }
class OrdersResponse {
  List<OrderData> data;

  OrdersResponse({required this.data});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
    data: json['data'] != null
        ? List<OrderData>.from(json['data'].map((x) => OrderData.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderData {
  int? orderId;
  int? userId;
  String? trackingId;
  List<OrderItem> orderItems;
  double? total;
  double? deliveryFee;
  String? customerName;
  int? phone;
  String? address;
  String? status;
  String? orderStatus;
  int? paid;
  int? riderId;
  int? trackingNumber;
  String? orderDate;
  double? orderTotal;
  double? grandTotal;
  double? grandDiscount;
  double? netTotal;
  Rider? rider;

  OrderData({
    this.orderId,
    this.userId,
    this.trackingId,
    this.orderItems = const [],
    this.total,
    this.deliveryFee,
    this.customerName,
    this.phone,
    this.address,
    this.status,
    this.orderStatus,
    this.paid,
    this.riderId,
    this.trackingNumber,
    this.orderDate,
    this.orderTotal,
    this.grandTotal,
    this.grandDiscount,
    this.netTotal,
    this.rider,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderId: json['order_id'],
    userId: json['user_id'],
    trackingId: json['tracking_id'],
    orderItems: json['order_items'] != null
        ? List<OrderItem>.from(
            json['order_items'].map((x) => OrderItem.fromJson(x)),
          )
        : [],
    total: (json['total'] ?? 0).toDouble(),
    deliveryFee: (json['delivery_fee'] ?? 0).toDouble(),
    customerName: json['customer_name'] ?? '',
    phone: json['phone'],
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
    rider: json['rider'] != null ? Rider.fromJson(json['rider']) : null,
  );

  Map<String, dynamic> toJson() => {
    'order_id': orderId,
    'user_id': userId,
    'tracking_id': trackingId,
    'order_items': List<dynamic>.from(orderItems.map((x) => x.toJson())),
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
    'rider': rider?.toJson(),
  };
}

class OrderItem {
  int? productId;
  int? quantity;
  double? price;
  String? productName;
  double? deliveryCharges;
  String? deliveryType;
  String? image;
  ParentOption? parentOption;
  ChildOption? childOption;
  String? deliveryStatus;
  String? statusVideo;
  double? orderWeight;
  double? orderSize;

  OrderItem({
    this.productId,
    this.quantity,
    this.price,
    this.productName,
    this.deliveryCharges,
    this.deliveryType,
    this.image,
    this.parentOption,
    this.childOption,
    this.deliveryStatus,
    this.statusVideo,
    this.orderWeight,
    this.orderSize,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    productId: json['product_id'],
    quantity: json['quantity'],
    price: (json['price'] ?? 0).toDouble(),
    productName: json['product_name'] ?? '',
    deliveryCharges: (json['deliveryCharges'] ?? 0).toDouble(),
    deliveryType: json['deliveryType'] ?? '',
    image: json['image'] ?? '',
    parentOption: json['parent_option'] != null
        ? ParentOption.fromJson(json['parent_option'])
        : null,
    childOption: json['child_option'] != null
        ? ChildOption.fromJson(json['child_option'])
        : null,
    deliveryStatus: json['delivery_status'] ?? '',
    statusVideo: json['status_video'] ?? '',
    orderWeight: (json['order_weight'] ?? 0).toDouble(),
    orderSize: (json['order_size'] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
    'price': price,
    'product_name': productName,
    'deliveryCharges': deliveryCharges,
    'deliveryType': deliveryType,
    'image': image,
    'parent_option': parentOption?.toJson(),
    'child_option': childOption?.toJson(),
    'delivery_status': deliveryStatus,
    'status_video': statusVideo,
    'order_weight': orderWeight,
    'order_size': orderSize,
  };
}

class ParentOption {
  String? name;
  dynamic value;

  ParentOption({this.name, this.value});

  factory ParentOption.fromJson(Map<String, dynamic> json) =>
      ParentOption(name: json['name'] ?? '', value: json['value']);

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}

class ChildOption {
  String? name;
  dynamic value;

  ChildOption({this.name, this.value});

  factory ChildOption.fromJson(Map<String, dynamic> json) =>
      ChildOption(name: json['name'] ?? '', value: json['value']);

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}

class Rider {
  int? id;
  String? riderName;
  String? vehicleType;
  String? riderEmail;
  int? phone;

  Rider({
    this.id,
    this.riderName,
    this.vehicleType,
    this.riderEmail,
    this.phone,
  });

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
    id: json['id'],
    riderName: json['rider_name'] ?? '',
    vehicleType: json['vehicle_type'] ?? '',
    riderEmail: json['rider_email'] ?? '',
    phone: json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'rider_name': riderName,
    'vehicle_type': vehicleType,
    'rider_email': riderEmail,
    'phone': phone,
  };
}
