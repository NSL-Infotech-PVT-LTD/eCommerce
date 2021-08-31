// To parse this JSON data, do
//
//     final prefiestasModel = prefiestasModelFromJson(jsonString);

import 'dart:convert';

PrefiestasModel prefiestasModelFromJson(String str) =>
    PrefiestasModel.fromJson(json.decode(str));

String prefiestasModelToJson(PrefiestasModel data) =>
    json.encode(data.toJson());

class PrefiestasModel {
  PrefiestasModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PrefiestasModel.fromJson(Map<String, dynamic> json) =>
      PrefiestasModel(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<ProductInfo>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<ProductInfo>.from(
            json["data"].map((x) => ProductInfo.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ProductInfo {
  ProductInfo({
    this.id,
    this.name,
    this.parentId,
    this.image,
    this.description,
    this.price,
    this.videoUrl,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.quantityInCl,
  });

  int? id;
  String? name;
  int? parentId;
  String? image;
  String? description;
  String? price;
  String? videoUrl;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  dynamic quantityInCl;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
        videoUrl: json["video_url"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        quantityInCl: json["quantity_in_cl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "image": image,
        "description": description,
        "price": price,
        "video_url": videoUrl,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "quantity_in_cl": quantityInCl,
      };
}
