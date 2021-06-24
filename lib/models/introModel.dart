// To parse this JSON data, do
//
//     final introModel = introModelFromJson(jsonString);

import 'dart:convert';

IntroModel introModelFromJson(String str) =>
    IntroModel.fromJson(json.decode(str));

String introModelToJson(IntroModel data) => json.encode(data.toJson());

class IntroModel {
  IntroModel({
    this.id,
    this.title,
    this.image,
    this.description,
  });

  int? id;
  String? title;
  String? image;
  String? description;

  factory IntroModel.fromJson(Map<String, dynamic> json) => IntroModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
      };
}
