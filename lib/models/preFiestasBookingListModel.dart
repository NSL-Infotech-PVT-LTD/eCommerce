// To parse this JSON data, do
//
//     final preFiestasBookingListModel = preFiestasBookingListModelFromJson(jsonString);

import 'dart:convert';

PreFiestasBookingListModel preFiestasBookingListModelFromJson(String str) =>
    PreFiestasBookingListModel.fromJson(json.decode(str));

String preFiestasBookingListModelToJson(PreFiestasBookingListModel data) =>
    json.encode(data.toJson());

class PreFiestasBookingListModel {
  PreFiestasBookingListModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PreFiestasBookingListModel.fromJson(Map<String, dynamic> json) =>
      PreFiestasBookingListModel(
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
  int? perPage;
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
    this.date,
    this.time,
    this.parentId,
    this.orderBy,
    this.totalPrice,
    this.address,
    this.orderStatus,
    this.paymentMode,
    this.categoryDetail,
    this.orderItem,
  });

  int? id;
  DateTime? date;
  String? time;
  int? parentId;
  int? orderBy;
  int? totalPrice;
  String? address;
  String? orderStatus;
  String? paymentMode;
  CategoryDetail? categoryDetail;
  List<OrderItem>? orderItem;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        parentId: json["parent_id"],
        orderBy: json["order_by"],
        totalPrice: json["total_price"],
        address: json["address"],
        orderStatus: json["order_status"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        categoryDetail: CategoryDetail.fromJson(json["category_detail"]),
        orderItem: List<OrderItem>.from(
            json["order_item"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "parent_id": parentId,
        "order_by": orderBy,
        "total_price": totalPrice,
        "address": address,
        "order_status": orderStatus,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "category_detail": categoryDetail?.toJson(),
        "order_item": List<dynamic>.from(orderItem!.map((x) => x.toJson())),
      };
}

class CategoryDetail {
  CategoryDetail({
    this.name,
    this.parentId,
    this.image,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.id,
    this.price,
  });

  String? name;
  int? parentId;
  String? image;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  int? id;
  String? price;

  factory CategoryDetail.fromJson(Map<String, dynamic> json) => CategoryDetail(
        name: json["name"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        image: json["image"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        id: json["id"] == null ? null : json["id"],
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "parent_id": parentId == null ? null : parentId,
        "image": image,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "id": id == null ? null : id,
        "price": price == null ? null : price,
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
  CategoryDetail? preFiesta;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orderId: json["order_id"],
        preFiestaId: json["pre_fiesta_id"],
        quantity: json["quantity"],
        price: json["price"],
        preFiesta: CategoryDetail.fromJson(json["pre_fiesta"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "pre_fiesta_id": preFiestaId,
        "quantity": quantity,
        "price": price,
        "pre_fiesta": preFiesta?.toJson(),
      };
}
