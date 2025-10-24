import 'dart:convert';

/// Root model
class DashboardResponse {
  final bool success;
  final String role;
  final String filter;
  final String profilePicture;
  final DashboardData data;
  final List<TopProduct> topProducts;
  final List<LatestOrder> latestOrders;

  DashboardResponse({
    required this.success,
    required this.role,
    required this.filter,
    required this.profilePicture,
    required this.data,
    required this.topProducts,
    required this.latestOrders,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'] ?? false,
      role: json['role'] ?? '',
      filter: json['filter'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      data: DashboardData.fromJson(json['data'] ?? {}),
      topProducts: (json['topProducts'] is List)
          ? (json['topProducts'] as List)
              .map((e) => TopProduct.fromJson(e ?? {}))
              .toList()
          : [],
      latestOrders: (json['latestOrders'] is List)
          ? (json['latestOrders'] as List)
              .map((e) => LatestOrder.fromJson(e ?? {}))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'role': role,
        'filter': filter,
        'profilePicture': profilePicture,
        'data': data.toJson(),
        'topProducts': topProducts.map((e) => e.toJson()).toList(),
        'latestOrders': latestOrders.map((e) => e.toJson()).toList(),
      };

  static DashboardResponse fromRawJson(String str) =>
      DashboardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

/// Data Section
class DashboardData {
  final int totalProducts;
  final int totalOrders;
  final int returnedOrders;
  final int totalPendingOrders;
  final int pendingAmount;
  final int revenue;
  final int totalProfit;
  final int totalExpense;
  final int totalReviews;

  DashboardData({
    required this.totalProducts,
    required this.totalOrders,
    required this.returnedOrders,
    required this.totalPendingOrders,
    required this.pendingAmount,
    required this.revenue,
    required this.totalProfit,
    required this.totalExpense,
    required this.totalReviews,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalProducts: json['totalProducts'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
      returnedOrders: json['returnedOrders'] ?? 0,
      totalPendingOrders: json['totalPendingOrders'] ?? 0,
      pendingAmount: json['pendingAmount'] ?? 0,
      revenue: json['revenue'] ?? 0,
      totalProfit: json['totalProfit'] ?? 0,
      totalExpense: json['totalExpense'] ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalProducts': totalProducts,
        'totalOrders': totalOrders,
        'returnedOrders': returnedOrders,
        'totalPendingOrders': totalPendingOrders,
        'pendingAmount': pendingAmount,
        'revenue': revenue,
        'totalProfit': totalProfit,
        'totalExpense': totalExpense,
        'totalReviews': totalReviews,
      };
}

/// Top Product
class TopProduct {
  final int productId;
  final String productName;
  final String image;
  final int totalSold;
  final int totalEarning;

  TopProduct({
    required this.productId,
    required this.productName,
    required this.image,
    required this.totalSold,
    required this.totalEarning,
  });

  factory TopProduct.fromJson(Map<String, dynamic> json) {
    return TopProduct(
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      image: json['image'] ?? '',
      totalSold: json['total_sold'] ?? 0,
      totalEarning: json['total_earning'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'image': image,
        'total_sold': totalSold,
        'total_earning': totalEarning,
      };
}

/// Latest Order
class LatestOrder {
  final String date;
  final String customerName;
  final String status;
  final int total;
  final int phone;

  LatestOrder({
    required this.date,
    required this.customerName,
    required this.status,
    required this.total,
    required this.phone,
  });

  factory LatestOrder.fromJson(Map<String, dynamic> json) {
    return LatestOrder(
      date: json['date'] ?? '',
      customerName: json['customer_name'] ?? '',
      status: json['status'] ?? '',
      total: json['total'] ?? 0,
      phone: json['phone'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'customer_name': customerName,
        'status': status,
        'total': total,
        'phone': phone,
      };
}
