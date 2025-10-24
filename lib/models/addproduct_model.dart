
// ============================================
// 1. FIXED AddProduct Model - toJson() Method
// ============================================

class AddProduct {
  final String? productEditId;
  final List<String>? productImages;
  final String? title;
  final String? company;
  final String? categoryId;
  final String? subcategoryId;
  final String? subSubcategoryId;
  final String? categoryLevel3;
  final String? categoryLevel4;
  final String? categoryLevel5;
  final String? purchasePrice;
  final String? productPrice;
  final String? discount;
  final String? discountedPrice;
  final String? description;
  final String? weight;
  final String? length;
  final String? width;
  final String? height;
  final String? vehicleType;
  final List<Variants>? variants;

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
  });

  // ✅ FIXED: Return Map for multipart form data
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    // Basic fields
    if (productEditId != null && productEditId!.isNotEmpty) {
      data['product_edit_id'] = productEditId!;
    }
    if (title != null) data['title'] = title!;
    if (company != null) data['company'] = company!;
    if (categoryId != null) data['category_id'] = categoryId!;
    if (subcategoryId != null) data['subcategory_id'] = subcategoryId!;
    if (subSubcategoryId != null) data['sub_subcategory_id'] = subSubcategoryId!;
    if (categoryLevel3 != null && categoryLevel3!.isNotEmpty) {
      data['category_level_3'] = categoryLevel3!;
    }
    if (categoryLevel4 != null && categoryLevel4!.isNotEmpty) {
      data['category_level_4'] = categoryLevel4!;
    }
    if (categoryLevel5 != null && categoryLevel5!.isNotEmpty) {
      data['category_level_5'] = categoryLevel5!;
    }
    if (purchasePrice != null) data['purchase_price'] = purchasePrice!;
    if (productPrice != null) data['product_price'] = productPrice!;
    if (discount != null) data['discount'] = discount!;
    if (discountedPrice != null) data['discounted_price'] = discountedPrice!;
    if (description != null) data['description'] = description!;
    if (weight != null) data['weight'] = weight!;
    if (length != null) data['length'] = length!;
    if (width != null) data['width'] = width!;
    if (height != null) data['height'] = height!;
    if (vehicleType != null) data['vehicleType'] = vehicleType!;

    // ✅ CRITICAL FIX: Product images as indexed array (NOT list)
    if (productImages != null && productImages!.isNotEmpty) {
      for (int i = 0; i < productImages!.length; i++) {
        data['product_images[$i]'] = productImages![i];
      }
    }

    // ✅ CRITICAL FIX: Variants as nested map structure (NOT JSON string)
    if (variants != null && variants!.isNotEmpty) {
      for (int i = 0; i < variants!.length; i++) {
        final variant = variants![i];
        
        // Parent data
        data['variants[$i][parentname]'] = variant.parentName ?? '';
        data['variants[$i][parent_option_name]'] = variant.parentOptionName ?? '';
        data['variants[$i][parentprice]'] = variant.parentPrice ?? '';
        data['variants[$i][parentstock]'] = variant.parentStock ?? '';
        
        // Parent image (file path - will be converted to file)
        if (variant.parentImage != null && variant.parentImage!.isNotEmpty) {
          data['variants[$i][parentimage]'] = variant.parentImage!;
        }

        // Children data
        if (variant.children != null && variant.children!.isNotEmpty) {
          for (int j = 0; j < variant.children!.length; j++) {
            final child = variant.children![j];
            
            data['variants[$i][children][$j][name]'] = child.name ?? '';
            data['variants[$i][children][$j][child_option_name]'] = child.childOptionName ?? '';
            data['variants[$i][children][$j][price]'] = child.price ?? '';
            data['variants[$i][children][$j][stock]'] = child.stock ?? '';
            
            // Child image (file path)
            if (child.image != null && child.image!.isNotEmpty) {
              data['variants[$i][children][$j][image]'] = child.image!;
            }
          }
        }
      }
    }

    return data;
  }
}

// ============================================
// 2. Variants Model
// ============================================

class Variants {
  final String? parentName;
  final String? parentOptionName;
  final String? parentPrice;
  final String? parentStock;
  final String? parentImage;
  final List<Children>? children;

  Variants({
    this.parentName,
    this.parentOptionName,
    this.parentPrice,
    this.parentStock,
    this.parentImage,
    this.children,
  });
}

class Children {
  final String? name;
  final String? childOptionName;
  final String? price;
  final String? stock;
  final String? image;

  Children({
    this.name,
    this.childOptionName,
    this.price,
    this.stock,
    this.image,
  });
}