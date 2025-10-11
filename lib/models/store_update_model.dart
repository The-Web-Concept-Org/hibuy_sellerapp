class StoreUpdate {
  bool? success;
  String? message;
  bool? isNew;
  Data? data;

  StoreUpdate({this.success, this.message, this.isNew, this.data});

  StoreUpdate.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? '';
    isNew = json['is_new'] ?? false;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    map['is_new'] = isNew;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class Data {
  String? storeName;
  String? storeImage;
  List<String>? storeTags;
  List<StoreBanner>? storeBanners;
  List<StorePost>? storePosts;

  Data({
    this.storeName,
    this.storeImage,
    this.storeTags,
    this.storeBanners,
    this.storePosts,
  });

  Data.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'] ?? '';
    storeImage = json['store_image'] ?? '';

    // Safely handle null or wrong data types
    if (json['store_tags'] != null && json['store_tags'] is List) {
      storeTags = List<String>.from(json['store_tags']);
    } else {
      storeTags = [];
    }

    if (json['store_banners'] != null && json['store_banners'] is List) {
      storeBanners = (json['store_banners'] as List)
          .map((v) => StoreBanner.fromJson(v))
          .toList();
    } else {
      storeBanners = [];
    }

    if (json['store_posts'] != null && json['store_posts'] is List) {
      storePosts = (json['store_posts'] as List)
          .map((v) => StorePost.fromJson(v))
          .toList();
    } else {
      storePosts = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['store_name'] = storeName;
    map['store_image'] = storeImage;
    map['store_tags'] = storeTags;
    if (storeBanners != null) {
      map['store_banners'] = storeBanners!.map((v) => v.toJson()).toList();
    }
    if (storePosts != null) {
      map['store_posts'] = storePosts!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StoreBanner {
  int? id;
  String? image;

  StoreBanner({this.id, this.image});

  StoreBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['image'] = image;
    return map;
  }
}

class StorePost {
  String? image;

  StorePost({this.image});

  StorePost.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['image'] = image;
    return map;
  }
}
