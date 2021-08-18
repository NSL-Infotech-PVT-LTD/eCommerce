// To parse this JSON data, do
//
//     final userRegisterModel = userRegisterModelFromJson(jsonString);

import 'dart:convert';

UserRegisterModel userRegisterModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));

String userRegisterModelToJson(UserRegisterModel data) =>
    json.encode(data.toJson());

class UserRegisterModel {
  UserRegisterModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
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
    this.dob,
    this.gender,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.role,
  });

  String? name;
  String? email;
  DateTime? dob;
  String? gender;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  Role? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "dob":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "role": role?.toJson(),
      };
}

class Role {
  Role({
    this.name,
    this.id,
    this.permission,
  });

  String? name;
  int? id;
  List<dynamic>? permission;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
        id: json["id"],
        permission: List<dynamic>.from(json["permission"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "permission": List<dynamic>.from(permission!.map((x) => x)),
      };
}
