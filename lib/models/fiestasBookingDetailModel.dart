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
    this.fiestaDetail,
  });

  int? id;
  int? fiestaId;
  String? totalPrice;
  String? bookingStatus;
  FiestaDetail? fiestaDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fiestaId: json["fiesta_id"],
        totalPrice: json["total_price"],
        bookingStatus: json["booking_status"],
        fiestaDetail: FiestaDetail.fromJson(json["fiesta_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fiesta_id": fiestaId,
        "total_price": totalPrice,
        "booking_status": bookingStatus,
        "fiesta_detail": fiestaDetail?.toJson(),
      };
}

class FiestaDetail {
  FiestaDetail({
    this.id,
    this.name,
    this.clubId,
    this.timestamp,
    this.ticketPrice,
    this.ticketPriceStandard,
    this.ticketPriceVip,
    this.totalMembers,
    this.dressCode,
    this.partyMusic,
    this.distanceKm,
    this.distanceMiles,
    this.isFavourite,
    this.leftStandardTicket,
    this.leftVipTicket,
    this.leftNormalTicket,
    this.clubRating,
    this.clubDetail,
  });

  int? id;
  String? name;
  int? clubId;
  DateTime? timestamp;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  String? distanceKm;
  String? distanceMiles;
  bool? isFavourite;
  var leftStandardTicket;
  var leftVipTicket;
  var leftNormalTicket;
  dynamic clubRating;
  ClubDetail? clubDetail;

  factory FiestaDetail.fromJson(Map<String, dynamic> json) => FiestaDetail(
        id: json["id"],
        name: json["name"],
        clubId: json["club_id"],
        timestamp: DateTime.parse(json["timestamp"]),
        ticketPrice: json["ticket_price"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        dressCode: json["dress_code"],
        partyMusic: json["party_music"],
        distanceKm: json["distance_km"],
        distanceMiles: json["distance_miles"],
        isFavourite: json["is_favourite"],
        leftStandardTicket: json["left_standard_ticket"],
        leftVipTicket: json["left_vip_ticket"],
        leftNormalTicket: json["left_normal_ticket"],
        clubRating: json["club_rating"],
        clubDetail: ClubDetail.fromJson(json["club_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "club_id": clubId,
        "timestamp": timestamp?.toIso8601String(),
        "ticket_price": ticketPrice,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "dress_code": dressCode,
        "party_music": partyMusic,
        "distance_km": distanceKm,
        "distance_miles": distanceMiles,
        "is_favourite": isFavourite,
        "left_standard_ticket": leftStandardTicket,
        "left_vip_ticket": leftVipTicket,
        "left_normal_ticket": leftNormalTicket,
        "club_rating": clubRating,
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
  dynamic latitude;
  dynamic longitude;

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
