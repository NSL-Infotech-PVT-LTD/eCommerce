// To parse this JSON data, do
//
//     final updateProfileDataModel = updateProfileDataModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileDataModel updateProfileDataModelFromJson(String str) =>
    UpdateProfileDataModel.fromJson(json.decode(str));

String updateProfileDataModelToJson(UpdateProfileDataModel data) =>
    json.encode(data.toJson());

class UpdateProfileDataModel {
  UpdateProfileDataModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory UpdateProfileDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileDataModel(
        status: json["status"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.message,
    this.user,
  });

  String? message;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.name,
    this.email,
    this.status,
    this.image,
    this.mobile,
    this.gender,
    this.socialLogin,
  });

  String? name;
  String? email;
  String? status;
  String? image;
  String? mobile;
  String? gender;
  bool? socialLogin;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        status: json["status"],
        image: json["image"],
        mobile: json["mobile"],
        gender: json["gender"],
        socialLogin: json["social_login"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "status": status,
        "image": image,
        "mobile": mobile,
        "gender": gender,
        "social_login": socialLogin,
      };
}
