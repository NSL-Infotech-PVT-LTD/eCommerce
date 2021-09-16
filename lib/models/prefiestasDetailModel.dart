// To parse this JSON data, do
//
//     final prefiestasDetailModel = prefiestasDetailModelFromJson(jsonString);

import 'dart:convert';

PrefiestasDetailModel prefiestasDetailModelFromJson(String str) =>
    PrefiestasDetailModel.fromJson(json.decode(str));

String prefiestasDetailModelToJson(PrefiestasDetailModel data) =>
    json.encode(data.toJson());

class PrefiestasDetailModel {
  PrefiestasDetailModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PrefiestasDetailModel.fromJson(Map<String, dynamic> json) =>
      PrefiestasDetailModel(
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
    this.parentData,
    this.childData,
  });

  ParentData? parentData;
  ChildData? childData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        parentData: ParentData.fromJson(json["parentData"]),
        childData: ChildData.fromJson(json["childData"]),
      );

  Map<String, dynamic> toJson() => {
        "parentData": parentData?.toJson(),
        "childData": childData?.toJson(),
      };
}

class ChildData {
  ChildData({
    this.alcohol,
    this.mix,
    this.extras,
  });

  List<ParentData>? alcohol;
  List<ParentData>? mix;
  List<ParentData>? extras;

  factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        alcohol: List<ParentData>.from(
            json["alcohol"].map((x) => ParentData.fromJson(x))),
        mix: List<ParentData>.from(
            json["mix"].map((x) => ParentData.fromJson(x))),
        extras: List<ParentData>.from(
            json["extras"].map((x) => ParentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "alcohol": List<dynamic>.from(alcohol!.map((x) => x.toJson())),
        "mix": List<dynamic>.from(mix!.map((x) => x.toJson())),
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
      };
}

class ParentData {
  ParentData({
    this.id,
    this.name,
    this.parentId,
    this.categories,
    this.description,
    this.image,
    this.price,
    this.quantity,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.quantityInCl,
    this.quantityInCart,
    this.videoUrl,
    this.status,
  });

  int? id;
  String? name;
  int? parentId;
  var categories;
  String? description;
  String? image;
  String? price;
  int? quantity;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  var quantityInCl;
  int? quantityInCart;
  String? videoUrl;
  String? status;

  factory ParentData.fromJson(Map<String, dynamic> json) => ParentData(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        categories: json["categories"] == null ? null : json["categories"],
        description: json["description"],
        image: json["image"],
        price: json["price"] == null ? null : json["price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        quantityInCl:
            json["quantity_in_cl"] == null ? null : json["quantity_in_cl"],
        quantityInCart: json["quantity_in_cart"],
        videoUrl: json["video_url"] == null ? null : json["video_url"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId == null ? null : parentId,
        "categories": categories == null ? null : categories,
        "description": description,
        "image": image,
        "price": price == null ? null : price,
        "quantity": quantity == null ? null : quantity,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "quantity_in_cl": quantityInCl == null ? null : quantityInCl,
        "quantity_in_cart": quantityInCart,
        "video_url": videoUrl == null ? null : videoUrl,
        "status": status == null ? null : status,
      };
}
