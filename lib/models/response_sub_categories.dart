class SubCategoryResponse {
  bool? status;
  List<SubCategoryList>? data;
  String? message;

  SubCategoryResponse({this.status, this.data, this.message});

  SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SubCategoryList>[];
      json['data'].forEach((v) {
        data!.add(SubCategoryList.fromJson(v));
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

class SubCategoryList {
  String? id;
  String? catId;
  String? name;
  String? image;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  SubCategoryList(
      {this.id,
      this.catId,
      this.name,
      this.status,
      this.image,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    name = json['name'];
    status = json['status'];
    image = json['image'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_id'] = catId;
    data['name'] = name;
    data['status'] = status;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
