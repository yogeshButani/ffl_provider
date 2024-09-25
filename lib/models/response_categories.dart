class CategoryResponse {
  bool? status;
  List<CategoryList>? data;
  String? message;

  CategoryResponse({this.status, this.data, this.message});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CategoryList>[];
      json['data'].forEach((v) {
        data!.add(CategoryList.fromJson(v));
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

class CategoryList {
  String? id;
  String? name;
  String? image;
  String? isDelete;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  CategoryList(
      {this.id,
        this.name,
        this.image,
        this.isDelete,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  CategoryList.fromJson(Map<String, dynamic> json) {
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