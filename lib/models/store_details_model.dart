class StoreDetailsModel {
  bool? success;
  StoreData? storeData;

  StoreDetailsModel({this.success, this.storeData});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    storeData =
        json['store_data'] != null ? StoreData.fromJson(json['store_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (storeData != null) {
      data['store_data'] = storeData!.toJson();
    }
    return data;
  }
}

class StoreData {
  String? storeName;
  String? storeImage;
  int? sellerId;
  int? userId;
  int? productCount;

  StoreData({
    this.storeName,
    this.storeImage,
    this.sellerId,
    this.userId,
    this.productCount,
  });

  StoreData.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'];
    storeImage = json['store_image'];
    sellerId = json['seller_id'];
    userId = json['user_id'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['store_name'] = storeName;
    data['store_image'] = storeImage;
    data['seller_id'] = sellerId;
    data['user_id'] = userId;
    data['product_count'] = productCount;
    return data;
  }
}
