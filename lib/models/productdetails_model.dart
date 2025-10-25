class ProductDetails {
  bool? success;
  String? message;
  Product? product;

  ProductDetails({this.success, this.message, this.product});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? '';
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (product != null) data['product'] = product!.toJson();
    return data;
  }
}

class Product {
  int? productId;
  int? userId;
  String? productName;
  String? productDescription;
  int? productPrice;
  String? productBrand;
  int? productDiscount;
  int? productDiscountedPrice;
  List<String>? productImages;
  List<ProductVariation>? productVariation;
  int? productStatus;
  int? categoryId;
  String? categoryName;

  Product({
    this.productId,
    this.userId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productBrand,
    this.productDiscount,
    this.productDiscountedPrice,
    this.productImages,
    this.productVariation,
    this.productStatus,
    this.categoryId,
    this.categoryName,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    userId = json['user_id'];
    productName = json['product_name'] ?? '';
    productDescription = json['product_description'] ?? '';
    productPrice = json['product_price'] ?? 0;
    productBrand = json['product_brand'] ?? '';
    productDiscount = json['product_discount'] ?? 0;
    productDiscountedPrice = json['product_discounted_price'] ?? 0;
    productImages = (json['product_images'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    if (json['product_variation'] != null) {
      productVariation = (json['product_variation'] as List)
          .map((v) => ProductVariation.fromJson(v))
          .toList();
    } else {
      productVariation = [];
    }

    productStatus = json['product_status'] ?? 0;
    categoryId = json['category_id'] ?? 0;
    categoryName = json['category_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data['product_price'] = productPrice;
    data['product_brand'] = productBrand;
    data['product_discount'] = productDiscount;
    data['product_discounted_price'] = productDiscountedPrice;
    data['product_images'] = productImages;
    data['product_variation'] =
        productVariation?.map((v) => v.toJson()).toList() ?? [];
    data['product_status'] = productStatus;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}

class ProductVariation {
  String? parentName;
  String? parentOptionName;
  int? parentPrice;
  int? parentStock;
  int? parentTotalStock;
  String? parentImage;

  ProductVariation({
    this.parentName,
    this.parentOptionName,
    this.parentPrice,
    this.parentStock,
    this.parentTotalStock,
    this.parentImage,
  });

  ProductVariation.fromJson(Map<String, dynamic> json) {
    parentName = json['parentname'] ?? '';
    parentOptionName = json['parent_option_name'] ?? '';
    parentPrice = json['parentprice'] ?? 0;
    parentStock = json['parentstock'] ?? 0;
    parentTotalStock = json['parenttotalstock'] ?? 0;
    parentImage = json['parentimage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['parentname'] = parentName;
    data['parent_option_name'] = parentOptionName;
    data['parentprice'] = parentPrice;
    data['parentstock'] = parentStock;
    data['parenttotalstock'] = parentTotalStock;
    data['parentimage'] = parentImage;
    return data;
  }
}
