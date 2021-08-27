// To parse this JSON data, do
//
//     final addressListModel = addressListModelFromJson(jsonString);

import 'dart:convert';

AddressListModel addressListModelFromJson(String str) =>
    AddressListModel.fromJson(json.decode(str));

String addressListModelToJson(AddressListModel data) =>
    json.encode(data.toJson());

class AddressListModel {
  AddressListModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  List<Addressdata>? data;

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
        status: json["status"],
        code: json["code"],
        data: List<Addressdata>.from(
            json["data"].map((x) => Addressdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Addressdata {
  Addressdata({
    this.id,
    this.userId,
    this.name,
    this.streetAddress,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.latitude,
    this.longitude,
    this.datumDefault,
  });

  int? id;
  int? userId;
  String? name;
  String? streetAddress;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? latitude;
  String? longitude;
  String? datumDefault;

  factory Addressdata.fromJson(Map<String, dynamic> json) => Addressdata(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        streetAddress: json["street_address"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        datumDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "street_address": streetAddress,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "default": datumDefault,
      };
}
