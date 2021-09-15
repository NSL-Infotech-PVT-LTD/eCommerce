// To parse this JSON data, do
//
//     final prefiestasFavouriteModel = prefiestasFavouriteModelFromJson(jsonString);

import 'dart:convert';

PrefiestasFavouriteModel prefiestasFavouriteModelFromJson(String str) =>
    PrefiestasFavouriteModel.fromJson(json.decode(str));

String prefiestasFavouriteModelToJson(PrefiestasFavouriteModel data) =>
    json.encode(data.toJson());

class PrefiestasFavouriteModel {
  PrefiestasFavouriteModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PrefiestasFavouriteModel.fromJson(Map<String, dynamic> json) =>
      PrefiestasFavouriteModel(
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
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  String? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.id,
    this.preFiestaId,
    this.userId,
    this.preFiestaDetail,
  });

  int? id;
  int? preFiestaId;
  int? userId;
  PreFiestaDetail? preFiestaDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        preFiestaId: json["pre_fiesta_id"],
        userId: json["user_id"],
        preFiestaDetail: PreFiestaDetail.fromJson(json["pre_fiesta_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pre_fiesta_id": preFiestaId,
        "user_id": userId,
        "pre_fiesta_detail": preFiestaDetail?.toJson(),
      };
}

class PreFiestaDetail {
  PreFiestaDetail({
    this.id,
    this.name,
    this.description,
    this.parentId,
    this.categories,
    this.image,
    this.price,
    this.quantity,
    this.status,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.quantityInCl,
    this.quantityInCart,
  });

  int? id;
  String? name;
  String? description;
  int? parentId;
  dynamic categories;
  String? image;
  String? price;
  dynamic quantity;
  String? status;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  dynamic quantityInCl;
  int? quantityInCart;

  factory PreFiestaDetail.fromJson(Map<String, dynamic> json) =>
      PreFiestaDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        parentId: json["parent_id"],
        categories: json["categories"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        status: json["status"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        quantityInCl: json["quantity_in_cl"],
        quantityInCart: json["quantity_in_cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "parent_id": parentId,
        "categories": categories,
        "image": image,
        "price": price,
        "quantity": quantity,
        "status": status,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "quantity_in_cl": quantityInCl,
        "quantity_in_cart": quantityInCart,
      };
}
