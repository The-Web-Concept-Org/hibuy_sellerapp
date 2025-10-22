class AddProduct {
  String? productEditId;
  List<String>? productImages;
  String? title;
  String? company;
  String? categoryId;
  String? subcategoryId;
  String? subSubcategoryId;
  String? categoryLevel3;
  String? categoryLevel4;
  String? categoryLevel5;
  String? purchasePrice;
  String? productPrice;
  String? discount;
  String? discountedPrice;
  String? description;
  String? weight;
  String? length;
  String? width;
  String? height;
  String? vehicleType;
  List<Variants>? variants;
  List<String>? imagesToDelete;

  AddProduct({
    this.productEditId,
    this.productImages,
    this.title,
    this.company,
    this.categoryId,
    this.subcategoryId,
    this.subSubcategoryId,
    this.categoryLevel3,
    this.categoryLevel4,
    this.categoryLevel5,
    this.purchasePrice,
    this.productPrice,
    this.discount,
    this.discountedPrice,
    this.description,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.vehicleType,
    this.variants,
    this.imagesToDelete,
  });

  AddProduct.fromJson(Map<String, dynamic> json) {
    productEditId = json['product_edit_id']?.toString();
    productImages = json['product_images'] != null
        ? List<String>.from(json['product_images'])
        : [];
    title = json['title'] ?? '';
    company = json['company'] ?? '';
    categoryId = json['category_id']?.toString();
    subcategoryId = json['subcategory_id']?.toString();
    subSubcategoryId = json['sub_subcategory_id']?.toString();
    categoryLevel3 = json['category_level_3']?.toString();
    categoryLevel4 = json['category_level_4']?.toString();
    categoryLevel5 = json['category_level_5']?.toString();
    purchasePrice = json['purchase_price']?.toString();
    productPrice = json['product_price']?.toString();
    discount = json['discount']?.toString();
    discountedPrice = json['discounted_price']?.toString();
    description = json['description'] ?? '';
    weight = json['weight']?.toString();
    length = json['length']?.toString();
    width = json['width']?.toString();
    height = json['height']?.toString();
    vehicleType = json['vehicleType']?.toString();

    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }

    imagesToDelete = json['images_to_delete'] != null
        ? List<String>.from(json['images_to_delete'])
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product_edit_id'] = productEditId;
    data['product_images'] = productImages;
    data['title'] = title;
    data['company'] = company;
    data['category_id'] = categoryId;
    data['subcategory_id'] = subcategoryId;
    data['sub_subcategory_id'] = subSubcategoryId;
    data['category_level_3'] = categoryLevel3;
    data['category_level_4'] = categoryLevel4;
    data['category_level_5'] = categoryLevel5;
    data['purchase_price'] = purchasePrice;
    data['product_price'] = productPrice;
    data['discount'] = discount;
    data['discounted_price'] = discountedPrice;
    data['description'] = description;
    data['weight'] = weight;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['vehicleType'] = vehicleType;
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    data['images_to_delete'] = imagesToDelete;
    return data;
  }
}

class Variants {
  String? parentName;
  String? parentOptionName;
  String? parentPrice;
  String? parentStock;
  String? parentImage;
  List<Children>? children;

  Variants({
    this.parentName,
    this.parentOptionName,
    this.parentPrice,
    this.parentStock,
    this.parentImage,
    this.children,
  });

  Variants.fromJson(Map<String, dynamic> json) {
    parentName = json['parentname'];
    parentOptionName = json['parent_option_name'];
    parentPrice = json['parentprice'];
    parentStock = json['parentstock'];
    parentImage = json['parentimage'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['parentname'] = parentName;
    data['parent_option_name'] = parentOptionName;
    data['parentprice'] = parentPrice;
    data['parentstock'] = parentStock;
    data['parentimage'] = parentImage;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? name;
  String? childOptionName;
  String? price;
  String? stock;
  String? image;

  Children({
    this.name,
    this.childOptionName,
    this.price,
    this.stock,
    this.image,
  });

  Children.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    childOptionName = json['child_option_name'];
    price = json['price']?.toString();
    stock = json['stock']?.toString();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['child_option_name'] = childOptionName;
    data['price'] = price;
    data['stock'] = stock;
    data['image'] = image;
    return data;
  }
}
