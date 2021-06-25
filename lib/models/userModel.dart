// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.dob,
    this.gender,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.distanceKm,
    this.distanceMiles,
    this.role,
  });

  String? name;
  String? email;
  DateTime? dob;
  String? gender;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? distanceKm;
  String? distanceMiles;
  Role? role;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        distanceKm: json["distance_km"],
        distanceMiles: json["distance_miles"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "dob":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "distance_km": distanceKm,
        "distance_miles": distanceMiles,
        "role": role?.toJson(),
      };
}

class Role {
  Role({
    this.name,
    this.id,
    required this.permission,
  });

  String? name;
  int? id;
  List<dynamic> permission;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
        id: json["id"],
        permission: List<dynamic>.from(json["permission"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "permission": List<dynamic>.from(permission.map((x) => x)),
      };
}
