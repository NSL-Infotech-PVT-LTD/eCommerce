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
    this.parentDetail,
    this.cart,
  });

  ParentDetail? parentDetail;
  Cart? cart;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        parentDetail: ParentDetail.fromJson(json["parentDetail"]),
        cart: Cart.fromJson(json["Cart"]),
      );

  Map<String, dynamic> toJson() => {
        "parentDetail": parentDetail?.toJson(),
        "Cart": cart?.toJson(),
      };
}

class Cart {
  Cart({
    this.id,
    this.userId,
    this.price,
    this.shippingCharge,
    this.transferCharge,
    this.totalPrice,
    this.quantityInCart,
    this.cartItems,
  });

  int? id;
  int? userId;
  String? price;
  String? shippingCharge;
  String? transferCharge;
  String? totalPrice;
  int? quantityInCart;
  List<CartItem>? cartItems;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["user_id"],
        price: json["price"],
        shippingCharge: json["shipping_charge"],
        transferCharge: json["transfer_charge"],
        totalPrice: json["total_price"],
        quantityInCart: json["quantity_in_cart"],
        cartItems: List<CartItem>.from(
            json["cart_items"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "price": price,
        "shipping_charge": shippingCharge,
        "transfer_charge": transferCharge,
        "total_price": totalPrice,
        "quantity_in_cart": quantityInCart,
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
  ParentDetail? preFiesta;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        cartId: json["cart_id"],
        preFiestaId: json["pre_fiesta_id"],
        quantity: json["quantity"],
        price: json["price"],
        preFiesta: ParentDetail.fromJson(json["pre_fiesta"]),
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

class ParentDetail {
  ParentDetail({
    this.id,
    this.name,
    this.parentId,
    this.image,
    this.price,
    this.categories,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.quantityInCl,
    this.quantityInCart,
    this.status,
  });

  int? id;
  String? name;
  int? parentId;
  String? image;
  String? price;
  String? categories;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  int? quantityInCl;
  int? quantityInCart;
  String? status;

  factory ParentDetail.fromJson(Map<String, dynamic> json) => ParentDetail(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        image: json["image"],
        price: json["price"],
        categories: json["categories"] == null ? null : json["categories"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        quantityInCl:
            json["quantity_in_cl"] == null ? null : json["quantity_in_cl"],
        quantityInCart: json["quantity_in_cart"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "image": image,
        "price": price,
        "categories": categories == null ? null : categories,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "quantity_in_cl": quantityInCl == null ? null : quantityInCl,
        "quantity_in_cart": quantityInCart,
        "status": status == null ? null : status,
      };
}
