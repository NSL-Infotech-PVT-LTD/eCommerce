// To parse this JSON data, do
//
//     final fliterListModel = fliterListModelFromJson(jsonString);

import 'dart:convert';

FliterListModel fliterListModelFromJson(String str) =>
    FliterListModel.fromJson(json.decode(str));

String fliterListModelToJson(FliterListModel data) =>
    json.encode(data.toJson());

class FliterListModel {
  FliterListModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory FliterListModel.fromJson(Map<String, dynamic> json) =>
      FliterListModel(
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
    this.local,
    this.environment,
    this.schedule,
    this.music,
    this.clothing,
    this.ageGroup,
  });

  List<Clothing>? local;
  List<Clothing>? environment;
  List<Clothing>? schedule;
  List<Clothing>? music;
  List<Clothing>? clothing;
  List<String>? ageGroup;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        local:
            List<Clothing>.from(json["local"].map((x) => Clothing.fromJson(x))),
        environment: List<Clothing>.from(
            json["environment"].map((x) => Clothing.fromJson(x))),
        schedule: List<Clothing>.from(
            json["schedule"].map((x) => Clothing.fromJson(x))),
        music:
            List<Clothing>.from(json["music"].map((x) => Clothing.fromJson(x))),
        clothing: List<Clothing>.from(
            json["clothing"].map((x) => Clothing.fromJson(x))),
        ageGroup: List<String>.from(json["ageGroup"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "local": List<dynamic>.from(local!.map((x) => x.toJson())),
        "environment": List<dynamic>.from(environment!.map((x) => x.toJson())),
        "schedule": List<dynamic>.from(schedule!.map((x) => x.toJson())),
        "music": List<dynamic>.from(music!.map((x) => x.toJson())),
        "clothing": List<dynamic>.from(clothing!.map((x) => x.toJson())),
        "ageGroup": List<dynamic>.from(ageGroup!.map((x) => x)),
      };
}

class Clothing {
  Clothing({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Clothing.fromJson(Map<String, dynamic> json) => Clothing(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
