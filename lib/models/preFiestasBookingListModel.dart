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
    this.orderBy,
    this.transferCharge,
    this.totalPrice,
    this.address,
    this.orderStatus,
    this.paymentMode,
    this.categoryDetail,
    this.grandTotal,
    this.orderItem,
  });

  int? id;
  DateTime? date;
  String? time;
  int? orderBy;
  String? transferCharge;
  int? totalPrice;
  String? address;
  OrderStatus? orderStatus;
  PaymentMode? paymentMode;
  CategoryDetail? categoryDetail;
  double? grandTotal;
  List<OrderItem>? orderItem;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        orderBy: json["order_by"],
        transferCharge: json["transfer_charge"],
        totalPrice: json["total_price"],
        address: json["address"],
        orderStatus: orderStatusValues.map[json["order_status"]],
        paymentMode: paymentModeValues.map[json["payment_mode"]],
        categoryDetail: CategoryDetail.fromJson(json["category_detail"]),
        grandTotal: json["grand_total"].toDouble(),
        orderItem: List<OrderItem>.from(
            json["order_item"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time": time,
        "order_by": orderBy,
        "transfer_charge": transferCharge,
        "total_price": totalPrice,
        "address": address,
        "order_status": orderStatusValues.reverse[orderStatus],
        "payment_mode": paymentModeValues.reverse[paymentMode],
        "category_detail": categoryDetail?.toJson(),
        "grand_total": grandTotal,
        "order_item": List<dynamic>.from(orderItem!.map((x) => x.toJson())),
      };
}

class CategoryDetail {
  CategoryDetail({
    this.id,
    this.name,
    this.parentId,
    this.image,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.quantityInCl,
  });

  int? id;
  CategoryDetailName? name;
  int? parentId;
  String? image;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  dynamic quantityInCl;

  factory CategoryDetail.fromJson(Map<String, dynamic> json) => CategoryDetail(
        id: json["id"],
        name: categoryDetailNameValues.map[json["name"]],
        parentId: json["parent_id"],
        image: json["image"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        quantityInCl: json["quantity_in_cl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": categoryDetailNameValues.reverse[name],
        "parent_id": parentId,
        "image": image,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "quantity_in_cl": quantityInCl,
      };
}

enum CategoryDetailName { WHITE_KNIGHT, BEER_PONG_ANIMALS }

final categoryDetailNameValues = EnumValues({
  "Beer Pong Animals": CategoryDetailName.BEER_PONG_ANIMALS,
  "White knight": CategoryDetailName.WHITE_KNIGHT
});

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
  var price;
  PreFiesta? preFiesta;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orderId: json["order_id"],
        preFiestaId: json["pre_fiesta_id"],
        quantity: json["quantity"],
        price: json["price"],
        preFiesta: PreFiesta.fromJson(json["pre_fiesta"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
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
    this.quantity,
    this.categories,
    this.image,
    this.price,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.quantityInCl,
  });

  int? id;
  PreFiestaName? name;
  int? quantity;
  Categories? categories;
  String? image;
  String? price;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  dynamic quantityInCl;

  factory PreFiesta.fromJson(Map<String, dynamic> json) => PreFiesta(
        id: json["id"],
        name: preFiestaNameValues.map[json["name"]],
        quantity: json["quantity"],
        categories: categoriesValues.map[json["categories"]],
        image: json["image"],
        price: json["price"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        quantityInCl: json["quantity_in_cl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": preFiestaNameValues.reverse[name],
        "quantity": quantity,
        "categories": categoriesValues.reverse[categories],
        "image": image,
        "price": price,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "quantity_in_cl": quantityInCl,
      };
}

enum Categories { ALCOHOL, MIX, EXTRAS }

final categoriesValues = EnumValues({
  "alcohol": Categories.ALCOHOL,
  "extras": Categories.EXTRAS,
  "mix": Categories.MIX
});

enum PreFiestaName { DEMO, HASSAN_BERNIER, DELPHIA_QUIGLEY, TESTING }

final preFiestaNameValues = EnumValues({
  "Delphia Quigley": PreFiestaName.DELPHIA_QUIGLEY,
  "demo": PreFiestaName.DEMO,
  "Hassan Bernier": PreFiestaName.HASSAN_BERNIER,
  "testing": PreFiestaName.TESTING
});

enum OrderStatus { PAID, ACCEPTED }

final orderStatusValues =
    EnumValues({"accepted": OrderStatus.ACCEPTED, "paid": OrderStatus.PAID});

enum PaymentMode { CARD }

final paymentModeValues = EnumValues({"card": PaymentMode.CARD});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
