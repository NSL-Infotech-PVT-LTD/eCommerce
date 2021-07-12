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
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.gender,
    this.dob,
    this.status,
    this.image,
    this.isNotify,
    this.stripeAccountId,
    this.isAvailable,
    this.location,
    this.latitude,
    this.longitude,
    this.radius,
  });

  int? id;
  String? name;
  String? email;
  dynamic mobile;
  String? gender;
  DateTime? dob;
  String? status;
  String? image;
  String? isNotify;
  dynamic stripeAccountId;
  String? isAvailable;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic radius;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        status: json["status"],
        image: json["image"],
        isNotify: json["is_notify"],
        stripeAccountId: json["stripe_account_id"],
        isAvailable: json["is_available"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "gender": gender,
        "dob":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "status": status,
        "image": image,
        "is_notify": isNotify,
        "stripe_account_id": stripeAccountId,
        "is_available": isAvailable,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
      };
}
