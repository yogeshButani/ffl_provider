class GetProfileResponse {
  bool? status;
  UserData? data;
  String? message;

  GetProfileResponse({this.status, this.data, this.message});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
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

class UserData {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? countryCode;
  String? mobile;
  String? mobileVerify;
  String? emailVerify;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserData(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.countryCode,
      this.mobile,
      this.mobileVerify,
      this.emailVerify,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    mobileVerify = json['mobile_verify'];
    emailVerify = json['email_verify'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['mobile_verify'] = mobileVerify;
    data['email_verify'] = emailVerify;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
