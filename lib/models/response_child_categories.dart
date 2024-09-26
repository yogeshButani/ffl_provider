class ChildCategoryResponse {
  bool? status;
  List<ChildCategoryList>? data;
  String? message;

  ChildCategoryResponse({this.status, this.data, this.message});

  ChildCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ChildCategoryList>[];
      json['data'].forEach((v) {
        data!.add(ChildCategoryList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ChildCategoryList {
  String? id;
  String? catId;
  String? subcategoriesId;
  String? name;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  bool? selected;
  List<ChildProductsList>? product;

  ChildCategoryList(
      {this.id,
        this.catId,
        this.subcategoriesId,
        this.name,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.selected,
        this.product});

  ChildCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    subcategoriesId = json['subcategories_id'];
    name = json['name'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    selected = json['selected'];
    if (json['product'] != null) {
      product = <ChildProductsList>[];
      json['product'].forEach((v) {
        product!.add(ChildProductsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_id'] = catId;
    data['subcategories_id'] = subcategoriesId;
    data['name'] = name;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['selected'] = selected;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ChildProductsList {
  String? id;
  String? parentId;
  String? vendorId;
  String? name;
  String? slug;
  String? featuredImage;
  String? galleryImages;
  String? category;
  String? subcategory;
  String? childcategory;
  String? brand;
  String? sellingPrice;
  String? costPrice;
  String? videoLink;
  String? quantity;
  String? productWeight;
  String? productDimension;
  String? size;
  String? color;
  String? specificationName;
  String? specificationDescription;
  String? metaKeywords;
  String? metaDescription;
  String? shortDescription;
  String? description;
  String? status;
  String? isDelete;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? deliveryType;
  String? avgRating;
  String? isFavourite;
  List<Images>? images;
  Sizes? sizes;
  AllColors? colors;

  ChildProductsList(
      {this.id,
        this.parentId,
        this.vendorId,
        this.name,
        this.slug,
        this.featuredImage,
        this.galleryImages,
        this.category,
        this.subcategory,
        this.childcategory,
        this.brand,
        this.sellingPrice,
        this.costPrice,
        this.videoLink,
        this.quantity,
        this.productWeight,
        this.productDimension,
        this.size,
        this.color,
        this.specificationName,
        this.specificationDescription,
        this.metaKeywords,
        this.metaDescription,
        this.shortDescription,
        this.description,
        this.status,
        this.isDelete,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.deliveryType,
        this.avgRating,
        this.isFavourite,
        this.images,
        this.sizes,
        this.colors});

  ChildProductsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    slug = json['slug'];
    featuredImage = json['featured_image'];
    galleryImages = json['gallery_images'];
    category = json['category'];
    subcategory = json['subcategory'];
    childcategory = json['childcategory'];
    brand = json['brand'];
    sellingPrice = json['selling_price'];
    costPrice = json['cost_price'];
    videoLink = json['video_link'];
    quantity = json['quantity'];
    productWeight = json['product_weight'];
    productDimension = json['product_dimension'];
    size = json['size'];
    color = json['color'];
    specificationName = json['specification_name'];
    specificationDescription = json['specification_description'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    shortDescription = json['short_description'];
    description = json['description'];
    status = json['status'];
    isDelete = json['is_delete'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryType = json['delivery_type'];
    avgRating = json['avgRating'];
    isFavourite = json['is_favourite'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    sizes = json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null;
    colors =
    json['colors'] != null ? AllColors.fromJson(json['colors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['vendor_id'] = vendorId;
    data['name'] = name;
    data['slug'] = slug;
    data['featured_image'] = featuredImage;
    data['gallery_images'] = galleryImages;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['childcategory'] = childcategory;
    data['brand'] = brand;
    data['selling_price'] = sellingPrice;
    data['cost_price'] = costPrice;
    data['video_link'] = videoLink;
    data['quantity'] = quantity;
    data['product_weight'] = productWeight;
    data['product_dimension'] = productDimension;
    data['size'] = size;
    data['color'] = color;
    data['specification_name'] = specificationName;
    data['specification_description'] = specificationDescription;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['status'] = status;
    data['is_delete'] = isDelete;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['delivery_type'] = deliveryType;
    data['avgRating'] = avgRating;
    data['is_favourite'] = isFavourite;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      data['sizes'] = sizes!.toJson();
    }
    if (colors != null) {
      data['colors'] = colors!.toJson();
    }
    return data;
  }
}

class Images {
  int? id;
  String? productId;
  String? productVariationId;
  String? image;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
        this.productId,
        this.productVariationId,
        this.image,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productVariationId = json['product_variation_id'];
    image = json['image'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_variation_id'] = productVariationId;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Sizes {
  String? id;
  String? name;

  Sizes({this.id, this.name});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class AllColors {
  String? id;
  String? name;
  String? colorCode;

  AllColors({this.id, this.name, this.colorCode});

  AllColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color_code'] = colorCode;
    return data;
  }
}