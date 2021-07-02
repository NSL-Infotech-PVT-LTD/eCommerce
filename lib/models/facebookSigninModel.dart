// To parse this JSON data, do
//
//     final facebookSigninModel = facebookSigninModelFromJson(jsonString);

import 'dart:convert';

FacebookSigninModel facebookSigninModelFromJson(String str) =>
    FacebookSigninModel.fromJson(json.decode(str));

String facebookSigninModelToJson(FacebookSigninModel data) =>
    json.encode(data.toJson());

class FacebookSigninModel {
  FacebookSigninModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory FacebookSigninModel.fromJson(Map<String, dynamic> json) =>
      FacebookSigninModel(
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
    this.token,
    this.user,
  });

  String? message;
  String? token;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.name,
    this.email,
    this.fbId,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? name;
  String? email;
  String? fbId;
  String? image;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        fbId: json["fb_id"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "fb_id": fbId,
        "image": image,
        "updated_at": updatedAt.toString(),
        "created_at": createdAt.toString(),
        "id": id,
      };
}
