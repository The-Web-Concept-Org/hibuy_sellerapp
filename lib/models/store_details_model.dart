class StoreDetailsModel {
  final bool? success;
  final StoreData? storeData;

  StoreDetailsModel({
    this.success,
    this.storeData,
  });

  factory StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    return StoreDetailsModel(
      success: json['success'] ?? false,
      storeData: json['store_data'] != null
          ? StoreData.fromJson(json['store_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        if (storeData != null) 'store_data': storeData!.toJson(),
      };
}

class StoreData {
  final String? storeName;
  final String? storeImage;
  final List<String>? storeTags;
  final List<StoreBanners>? storeBanners;
  final List<StorePosts>? storePosts;
  final int? storeId;
  final int? userId;
  final int? productCount;

  StoreData({
    this.storeName,
    this.storeImage,
    this.storeTags,
    this.storeBanners,
    this.storePosts,
    this.storeId,
    this.userId,
    this.productCount,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) {
    return StoreData(
      storeName: json['store_name'] ?? '',
      storeImage: json['store_image'] ?? '',
      storeTags: (json['store_tags'] as List?)
              ?.map((tag) => tag.toString())
              .toList() ??
          [],
      storeBanners: (json['store_banners'] as List?)
              ?.map((v) => StoreBanners.fromJson(v))
              .toList() ??
          [],
      storePosts: (json['store_posts'] as List?)
              ?.map((v) => StorePosts.fromJson(v))
              .toList() ??
          [],
      storeId: json['store_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      productCount: json['product_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'store_name': storeName,
        'store_image': storeImage,
        'store_tags': storeTags ?? [],
        'store_banners': storeBanners?.map((v) => v.toJson()).toList() ?? [],
        'store_posts': storePosts?.map((v) => v.toJson()).toList() ?? [],
        'store_id': storeId,
        'user_id': userId,
        'product_count': productCount,
      };
}

class StoreBanners {
  final int? id;
  final String? image;

  StoreBanners({this.id, this.image});

  factory StoreBanners.fromJson(Map<String, dynamic> json) {
    return StoreBanners(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
      };
}

class StorePosts {
  final String? image;

  StorePosts({this.image});

  factory StorePosts.fromJson(Map<String, dynamic> json) {
    return StorePosts(
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
      };
}
