// To parse this JSON data, do
//
//     final prefiestasOrderDetailModel = prefiestasOrderDetailModelFromJson(jsonString);

import 'dart:convert';

PrefiestasOrderDetailModel prefiestasOrderDetailModelFromJson(String str) =>
    PrefiestasOrderDetailModel.fromJson(json.decode(str));

String prefiestasOrderDetailModelToJson(PrefiestasOrderDetailModel data) =>
    json.encode(data.toJson());

class PrefiestasOrderDetailModel {
  PrefiestasOrderDetailModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PrefiestasOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      PrefiestasOrderDetailModel(
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
    this.orderDetail,
  });

  ParentDetail? parentDetail;
  List<OrderDetail>? orderDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        parentDetail: ParentDetail.fromJson(json["parentDetail"]),
        orderDetail: List<OrderDetail>.from(
            json["orderDetail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parentDetail": parentDetail?.toJson(),
        "orderDetail": List<dynamic>.from(orderDetail!.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.date,
    this.time,
    this.orderBy,
    this.totalPrice,
    this.address,
    this.orderStatus,
    this.paymentParams,
    this.paymentMode,
    this.orderItem,
  });

  int? id;
  DateTime? date;
  String? time;
  int? orderBy;
  int? totalPrice;
  String? address;
  String? orderStatus;
  dynamic paymentParams;
  dynamic paymentMode;
  List<OrderItem>? orderItem;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        orderBy: json["order_by"],
        totalPrice: json["total_price"],
        address: json["address"],
        orderStatus: json["order_status"],
        paymentParams: json["payment_params"],
        paymentMode: json["payment_mode"],
        orderItem: List<OrderItem>.from(
            json["order_item"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "order_by": orderBy,
        "total_price": totalPrice,
        "address": address,
        "order_status": orderStatus,
        "payment_params": paymentParams,
        "payment_mode": paymentMode,
        "order_item": List<dynamic>.from(orderItem!.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem({
    this.orderId,
    this.preFiestaId,
    this.quantity,
    this.price,
    this.preFiesta,
  });

  int? orderId;
  int? preFiestaId;
  int? quantity;
  int? price;
  ParentDetail? preFiesta;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orderId: json["order_id"],
        preFiestaId: json["pre_fiesta_id"],
        quantity: json["quantity"],
        price: json["price"],
        preFiesta: ParentDetail.fromJson(json["pre_fiesta"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
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
    this.image,
    this.price,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.status,
  });

  int? id;
  String? name;
  String? image;
  String? price;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  String? status;

  factory ParentDetail.fromJson(Map<String, dynamic> json) => ParentDetail(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"] == null ? null : json["price"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price == null ? null : price,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "status": status == null ? null : status,
      };
}
