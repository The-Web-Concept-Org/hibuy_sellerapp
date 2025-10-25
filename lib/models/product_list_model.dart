class ProductListModel {
  final bool? success;
  final String? message;
  final List<Product>? products;
  final dynamic packageStatus;
  final dynamic packageEndDate;
  final int? storeId;

  ProductListModel({
    this.success,
    this.message,
    this.products,
    this.packageStatus,
    this.packageEndDate,
    this.storeId,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      success: json['success'],
      message: json['message'],
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e))
          .toList(),
      packageStatus: json['package_status'],
      packageEndDate: json['package_end_date'],
      storeId: json['store_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'products': products?.map((e) => e.toJson()).toList(),
      'package_status': packageStatus,
      'package_end_date': packageEndDate,
      'store_id': storeId,
    };
  }
}

class Product {
  final int? productId;
  final int? userId;
  final String? productName;
  final String? productCategory;
  final num? productDiscountedPrice;
  final int? productStatus;
  final int? isBoosted;
  final String? createdAt;
  final String? updatedAt;
  final String? userName;
  final String? firstImage;

  Product({
    this.productId,
    this.userId,
    this.productName,
    this.productCategory,
    this.productDiscountedPrice,
    this.productStatus,
    this.isBoosted,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.firstImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      userId: json['user_id'],
      productName: json['product_name'],
      productCategory: json['product_category'],
      productDiscountedPrice: json['product_discounted_price'],
      productStatus: json['product_status'],
      isBoosted: json['is_boosted'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userName: json['user_name'],
      firstImage: json['first_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'user_id': userId,
      'product_name': productName,
      'product_category': productCategory,
      'product_discounted_price': productDiscountedPrice,
      'product_status': productStatus,
      'is_boosted': isBoosted,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_name': userName,
      'first_image': firstImage,
    };
  }
}
