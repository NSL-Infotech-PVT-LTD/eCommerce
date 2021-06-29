import 'package:flutter/cupertino.dart';

class class1 {
  String? name;
  String? email;
  String? dob;
  String? gender;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? distanceKm;
  String? distanceMiles;
  Role? role;

  class1(
      {this.name,
      this.email,
      this.dob,
      this.gender,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.distanceKm,
      this.distanceMiles,
      this.role});

  class1.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    distanceKm = json['distance_km'];
    distanceMiles = json['distance_miles'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['distance_km'] = this.distanceKm;
    data['distance_miles'] = this.distanceMiles;
    if (this.role != null) {
      data['role'] = this.role?.toJson();
    }
    return data;
  }
}

class Role {
  String? name;
  int? id;
  List<dynamic>? permission;

  Role({@required this.name, this.id, this.permission});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['permission'] != null) {
      permission = [];
      json['permission'].forEach((v) {
        permission!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.permission != null) {
      data['permission'] = this.permission?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
