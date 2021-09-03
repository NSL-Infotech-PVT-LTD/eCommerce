// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) =>
    NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) =>
    json.encode(data.toJson());

class NotificationListModel {
  NotificationListModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      NotificationListModel(
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
    this.isNotify,
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

  String? isNotify;
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
        isNotify: json["is_notify"],
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
        "is_notify": isNotify,
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
    this.title,
    this.body,
    this.message,
    this.createdBy,
    this.createdAt,
    this.targetId,
    this.isRead,
    this.bookingDetail,
    this.createdByDetail,
    this.targetByDetail,
  });

  int? id;
  Title? title;
  Body? body;
  String? message;
  int? createdBy;
  DateTime? createdAt;
  int? targetId;
  String? isRead;
  BookingDetail? bookingDetail;
  ByDetail? createdByDetail;
  ByDetail? targetByDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: titleValues.map[json["title"]],
        body: bodyValues.map[json["body"]],
        message: json["message"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        targetId: json["target_id"],
        isRead: json["is_read"],
        bookingDetail: BookingDetail.fromJson(json["booking_detail"]),
        createdByDetail: json["created_by_detail"] == null
            ? null
            : ByDetail.fromJson(json["created_by_detail"]),
        targetByDetail: ByDetail.fromJson(json["target_by_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "body": bodyValues.reverse[body],
        "message": message,
        "created_by": createdBy == null ? null : createdBy,
        "created_at": createdAt?.toIso8601String(),
        "target_id": targetId,
        "is_read": isRead,
        "booking_detail": bookingDetail?.toJson(),
        "created_by_detail":
            createdByDetail == null ? null : createdByDetail?.toJson(),
        "target_by_detail": targetByDetail?.toJson(),
      };
}

enum Body {
  YOUR_ORDER_HAS_BEEN_PLACED_SUCCESSFULLY_TAP_TO_VIEW_DETAIL,
  TAP_TO_VIEW_DETAILS,
  YOUR_TICKET_HAS_BEEN_BOOKED_SUCCESSFULLY_TAP_TO_VIEW_DETAIL
}

final bodyValues = EnumValues({
  "Tap to view details.": Body.TAP_TO_VIEW_DETAILS,
  "Your Order has been placed successfully, tap to view Detail.":
      Body.YOUR_ORDER_HAS_BEEN_PLACED_SUCCESSFULLY_TAP_TO_VIEW_DETAIL,
  "Your ticket has been booked successfully, tap to view Detail.":
      Body.YOUR_TICKET_HAS_BEEN_BOOKED_SUCCESSFULLY_TAP_TO_VIEW_DETAIL
});

class BookingDetail {
  BookingDetail({
    this.targetId,
    this.targetModel,
    this.dataType,
  });

  dynamic targetId;
  TargetModel? targetModel;
  DataType? dataType;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        targetId: json["target_id"],
        targetModel: targetModelValues.map[json["target_model"]],
        dataType: dataTypeValues.map[json["data_type"]],
      );

  Map<String, dynamic> toJson() => {
        "target_id": targetId,
        "target_model": targetModelValues.reverse[targetModel],
        "data_type": dataTypeValues.reverse[dataType],
      };
}

enum DataType { ORDER, DATA_TYPE_ORDER, BOOKING }

final dataTypeValues = EnumValues({
  "Booking": DataType.BOOKING,
  "Order": DataType.DATA_TYPE_ORDER,
  "order": DataType.ORDER
});

enum TargetModel { PRE_FIESTA_ORDER, ORDER, FIESTA_BOOKING }

final targetModelValues = EnumValues({
  "FiestaBooking": TargetModel.FIESTA_BOOKING,
  "Order": TargetModel.ORDER,
  "Pre-Fiesta Order": TargetModel.PRE_FIESTA_ORDER
});

class ByDetail {
  ByDetail({
    this.id,
    this.name,
    this.image,
    this.role,
  });

  int? id;
  TargetByDetailName? name;
  dynamic image;
  Role? role;

  factory ByDetail.fromJson(Map<String, dynamic> json) => ByDetail(
        id: json["id"],
        name: targetByDetailNameValues.map[json["name"]],
        image: json["image"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": targetByDetailNameValues.reverse[name],
        "image": image,
        "role": role?.toJson(),
      };
}

enum TargetByDetailName { ZEEM }

final targetByDetailNameValues = EnumValues({"zeem": TargetByDetailName.ZEEM});

class Role {
  Role({
    this.name,
    this.id,
    this.permission,
  });

  RoleName? name;
  int? id;
  List<dynamic>? permission;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: roleNameValues.map[json["name"]],
        id: json["id"],
        permission: List<dynamic>.from(json["permission"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": roleNameValues.reverse[name],
        "id": id,
        "permission": List<dynamic>.from(permission!.map((x) => x)),
      };
}

enum RoleName { CUSTOMER }

final roleNameValues = EnumValues({"customer": RoleName.CUSTOMER});

enum Title { ORDER_PLACED, ORDER_ACCEPTED, TICKETS_BOOKED }

final titleValues = EnumValues({
  "Order accepted": Title.ORDER_ACCEPTED,
  "Order Placed": Title.ORDER_PLACED,
  "Tickets Booked": Title.TICKETS_BOOKED
});

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
