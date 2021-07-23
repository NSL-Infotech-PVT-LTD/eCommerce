// To parse this JSON data, do
//
//     final createPrefiestasCartModel = createPrefiestasCartModelFromJson(jsonString);

import 'dart:convert';

CreatePrefiestasCartModel createPrefiestasCartModelFromJson(String str) =>
    CreatePrefiestasCartModel.fromJson(json.decode(str));

String createPrefiestasCartModelToJson(CreatePrefiestasCartModel data) =>
    json.encode(data.toJson());

class CreatePrefiestasCartModel {
  CreatePrefiestasCartModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory CreatePrefiestasCartModel.fromJson(Map<String, dynamic> json) =>
      CreatePrefiestasCartModel(
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
    this.cart,
  });

  String? message;
  Cart? cart;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        cart: Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "cart": cart?.toJson(),
      };
}

class Cart {
  Cart({
    this.id,
    this.userId,
    this.totalPrice,
    this.cartItems,
  });

  int? id;
  int? userId;
  String? totalPrice;
  List<CartItem>? cartItems;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
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
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
  });

  int? id;
  String? name;
  String? image;
  String? price;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;

  factory PreFiesta.fromJson(Map<String, dynamic> json) => PreFiesta(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
      };
}
