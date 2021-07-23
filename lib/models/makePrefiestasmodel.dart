// To parse this JSON data, do
//
//     final makeprefiestasOrderModel = makeprefiestasOrderModelFromJson(jsonString);

import 'dart:convert';

MakeprefiestasOrderModel makeprefiestasOrderModelFromJson(String str) =>
    MakeprefiestasOrderModel.fromJson(json.decode(str));

String makeprefiestasOrderModelToJson(MakeprefiestasOrderModel data) =>
    json.encode(data.toJson());

class MakeprefiestasOrderModel {
  MakeprefiestasOrderModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory MakeprefiestasOrderModel.fromJson(Map<String, dynamic> json) =>
      MakeprefiestasOrderModel(
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
    this.order,
  });

  String? message;
  Order? order;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        order: Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "order": order?.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.date,
    this.time,
    this.orderBy,
    this.totalPrice,
    this.address,
    this.orderStatus,
    this.paymentParams,
    this.paymentMode,
    this.params,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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
  dynamic params;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        orderBy: json["order_by"],
        totalPrice: json["total_price"],
        address: json["address"],
        orderStatus: json["order_status"],
        paymentParams: json["payment_params"],
        paymentMode: json["payment_mode"],
        params: json["params"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time": time,
        "order_by": orderBy,
        "total_price": totalPrice,
        "address": address,
        "order_status": orderStatus,
        "payment_params": paymentParams,
        "payment_mode": paymentMode,
        "params": params,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
