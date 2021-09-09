// To parse this JSON data, do
//
//     final fiestasBookingDetailModel = fiestasBookingDetailModelFromJson(jsonString);

import 'dart:convert';

FiestasBookingDetailModel fiestasBookingDetailModelFromJson(String str) =>
    FiestasBookingDetailModel.fromJson(json.decode(str));

String fiestasBookingDetailModelToJson(FiestasBookingDetailModel data) =>
    json.encode(data.toJson());

class FiestasBookingDetailModel {
  FiestasBookingDetailModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  List<Datum>? data;

  factory FiestasBookingDetailModel.fromJson(Map<String, dynamic> json) =>
      FiestasBookingDetailModel(
        status: json["status"],
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.fiestaId,
    this.totalPrice,
    this.bookingStatus,
    this.totalTickets,
    this.grandTotal,
    this.readyForReview,
    this.fiestaDetail,
  });

  int? id;
  int? fiestaId;
  String? totalPrice;
  String? bookingStatus;
  int? totalTickets;
  int? grandTotal;
  bool? readyForReview;
  FiestaDetail? fiestaDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fiestaId: json["fiesta_id"],
        totalPrice: json["total_price"],
        bookingStatus: json["booking_status"],
        totalTickets: json["total_tickets"],
        grandTotal: json["grand_total"],
        readyForReview: json["ready_for_review"],
        fiestaDetail: FiestaDetail.fromJson(json["fiesta_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fiesta_id": fiestaId,
        "total_price": totalPrice,
        "booking_status": bookingStatus,
        "total_tickets": totalTickets,
        "grand_total": grandTotal,
        "ready_for_review": readyForReview,
        "fiesta_detail": fiestaDetail?.toJson(),
      };
}

class FiestaDetail {
  FiestaDetail({
    this.id,
    this.name,
    this.clubId,
    this.timestamp,
    this.ticketPriceNormal,
    this.ticketPriceStandard,
    this.ticketPriceVip,
    this.totalMembers,
    this.filterLocalId,
    this.clubRating,
    this.leftNormalTicket,
    this.leftStandardTicket,
    this.leftVipTicket,
    this.isFavourite,
    this.distanceMiles,
    this.filterLocal,
    this.filterEnvironment,
    this.filterMusic,
    this.filterClothing,
    this.filterSchedule,
    this.clubDetail,
  });

  int? id;
  String? name;
  int? clubId;
  DateTime? timestamp;
  String? ticketPriceNormal;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  int? filterLocalId;
  dynamic clubRating;
  var leftNormalTicket;
  var leftStandardTicket;
  var leftVipTicket;
  bool? isFavourite;
  String? distanceMiles;
  Filter? filterLocal;
  Filter? filterEnvironment;
  Filter? filterMusic;
  Filter? filterClothing;
  Filter? filterSchedule;
  ClubDetail? clubDetail;

  factory FiestaDetail.fromJson(Map<String, dynamic> json) => FiestaDetail(
        id: json["id"],
        name: json["name"],
        clubId: json["club_id"],
        timestamp: DateTime.parse(json["timestamp"]),
        ticketPriceNormal: json["ticket_price_normal"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        filterLocalId: json["filter_local_id"],
        clubRating: json["club_rating"],
        leftNormalTicket: json["left_normal_ticket"],
        leftStandardTicket: json["left_standard_ticket"],
        leftVipTicket: json["left_vip_ticket"],
        isFavourite: json["is_favourite"],
        distanceMiles: json["distance_miles"],
        filterLocal: Filter.fromJson(json["filter_local"]),
        filterEnvironment: Filter.fromJson(json["filter_environment"]),
        filterMusic: Filter.fromJson(json["filter_music"]),
        filterClothing: Filter.fromJson(json["filter_clothing"]),
        filterSchedule: Filter.fromJson(json["filter_schedule"]),
        clubDetail: ClubDetail.fromJson(json["club_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "club_id": clubId,
        "timestamp": timestamp?.toIso8601String(),
        "ticket_price_normal": ticketPriceNormal,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "filter_local_id": filterLocalId,
        "club_rating": clubRating,
        "left_normal_ticket": leftNormalTicket,
        "left_standard_ticket": leftStandardTicket,
        "left_vip_ticket": leftVipTicket,
        "is_favourite": isFavourite,
        "distance_miles": distanceMiles,
        "filter_local": filterLocal?.toJson(),
        "filter_environment": filterEnvironment?.toJson(),
        "filter_music": filterMusic?.toJson(),
        "filter_clothing": filterClothing?.toJson(),
        "filter_schedule": filterSchedule?.toJson(),
        "club_detail": clubDetail?.toJson(),
      };
}

class ClubDetail {
  ClubDetail({
    this.id,
    this.name,
    this.image,
    this.capacity,
    this.description,
    this.location,
    this.latitude,
    this.longitude,
  });

  int? id;
  String? name;
  String? image;
  String? capacity;
  String? description;
  String? location;
  String? latitude;
  String? longitude;

  factory ClubDetail.fromJson(Map<String, dynamic> json) => ClubDetail(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        capacity: json["capacity"],
        description: json["description"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "capacity": capacity,
        "description": description,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Filter {
  Filter({
    this.name,
    this.nameEs,
  });

  String? name;
  String? nameEs;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        name: json["name"],
        nameEs: json["name_es"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "name_es": nameEs,
      };
}
