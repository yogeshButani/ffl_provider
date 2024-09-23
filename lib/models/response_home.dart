class HomeResponse {
  bool? status;
  Data? data;
  String? message;

  HomeResponse({this.status, this.data, this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<Mobilebanner>? mobilebanner;
  List<Category>? category;
  List<Flashsale>? flashsale;

  Data({this.mobilebanner, this.category, this.flashsale});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['mobilebanner'] != null) {
      mobilebanner = <Mobilebanner>[];
      json['mobilebanner'].forEach((v) {
        mobilebanner!.add(Mobilebanner.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['flashsale'] != null) {
      flashsale = <Flashsale>[];
      json['flashsale'].forEach((v) {
        flashsale!.add(Flashsale.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mobilebanner != null) {
      data['mobilebanner'] = mobilebanner!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (flashsale != null) {
      data['flashsale'] = flashsale!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mobilebanner {
  String? id;
  String? image;
  String? url;
  String? createdAt;
  String? updatedAt;

  Mobilebanner({this.id, this.image, this.url, this.createdAt, this.updatedAt});

  Mobilebanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? image;
  String? isDelete;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.name,
        this.image,
        this.isDelete,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isDelete = json['is_delete'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['is_delete'] = isDelete;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Flashsale {
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
  String? isFavourite;
  String? avgRating;
  List<Images>? images;

  Flashsale(
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
        this.isFavourite,
        this.avgRating,
        this.images});

  Flashsale.fromJson(Map<String, dynamic> json) {
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
    isFavourite = json['is_favourite'];
    avgRating = json['avgRating'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
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
    data['is_favourite'] = isFavourite;
    data['avgRating'] = avgRating;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
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