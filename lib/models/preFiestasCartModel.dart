// To parse this JSON data, do
//
//     final prefiestasCartModel = prefiestasCartModelFromJson(jsonString);

import 'dart:convert';

PrefiestasCartModel prefiestasCartModelFromJson(String str) =>
    PrefiestasCartModel.fromJson(json.decode(str));

String prefiestasCartModelToJson(PrefiestasCartModel data) =>
    json.encode(data.toJson());

class PrefiestasCartModel {
  PrefiestasCartModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PrefiestasCartModel.fromJson(Map<String, dynamic> json) =>
      PrefiestasCartModel(
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
    this.id,
    this.userId,
    this.totalPrice,
    this.cartItems,
  });

  int? id;
  int? userId;
  String? totalPrice;
  List<CartItem>? cartItems;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        totalPrice: json["total_price"],
        cartItems: List<CartItem>.from(
            json["cart_items"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "total_price": totalPrice,
        "cart_items": List<dynamic>.from(cartItems!.map((x) => x.toJson())),
      };
}

class CartItem {
  CartItem({
    this.id,
    this.cartId,
    this.preFiestaId,
    this.quantity,
    this.price,
    this.preFiesta,
  });

  int? id;
  int? cartId;
  int? preFiestaId;
  int? quantity;
  int? price;
  PreFiesta? preFiesta;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        cartId: json["cart_id"],
        preFiestaId: json["pre_fiesta_id"],
        quantity: json["quantity"],
        price: json["price"],
        preFiesta: PreFiesta.fromJson(json["pre_fiesta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "pre_fiesta_id": preFiestaId,
        "quantity": quantity,
        "price": price,
        "pre_fiesta": preFiesta?.toJson(),
      };
}

class PreFiesta {
  PreFiesta({
    this.id,
    this.name,
    this.image,
    this.price,
    this.categories,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
  });

  int? id;
  String? name;
  String? image;
  String? price;
  String? categories;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;

  factory PreFiesta.fromJson(Map<String, dynamic> json) => PreFiesta(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        categories: json["categories"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "categories": categories,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
      };
}
