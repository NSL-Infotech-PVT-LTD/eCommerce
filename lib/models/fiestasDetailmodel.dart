// To parse this JSON data, do
//
//     final fiestasDetailModel = fiestasDetailModelFromJson(jsonString);

import 'dart:convert';

FiestasDetailModel fiestasDetailModelFromJson(String str) =>
    FiestasDetailModel.fromJson(json.decode(str));

String fiestasDetailModelToJson(FiestasDetailModel data) =>
    json.encode(data.toJson());

class FiestasDetailModel {
  FiestasDetailModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory FiestasDetailModel.fromJson(Map<String, dynamic> json) =>
      FiestasDetailModel(
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
    this.name,
    this.type,
    this.clubId,
    this.description,
    this.timestamp,
    this.ticketPrice,
    this.ticketPriceStandard,
    this.ticketPriceVip,
    this.totalMembers,
    this.dressCode,
    this.partyMusic,
    this.totalNormalTickets,
    this.totalStandardTickets,
    this.totalVipTickets,
    this.distanceKm,
    this.distanceMiles,
    this.isFavourite,
    this.leftStandardTicket,
    this.leftVipTicket,
    this.leftNormalTicket,
    this.clubDetail,
    this.fiestaImages,
  });

  int? id;
  String? name;
  String? type;
  int? clubId;
  String? description;
  DateTime? timestamp;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  String? totalNormalTickets;
  String? totalStandardTickets;
  String? totalVipTickets;
  String? distanceKm;
  String? distanceMiles;
  bool? isFavourite;
  String? leftStandardTicket;
  String? leftVipTicket;
  String? leftNormalTicket;
  ClubDetail? clubDetail;
  List<FiestaImage>? fiestaImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        clubId: json["club_id"],
        description: json["description"],
        timestamp: DateTime.parse(json["timestamp"]),
        ticketPrice: json["ticket_price"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        dressCode: json["dress_code"],
        partyMusic: json["party_music"],
        totalNormalTickets: json["total_normal_tickets"],
        totalStandardTickets: json["total_standard_tickets"],
        totalVipTickets: json["total_vip_tickets"],
        distanceKm: json["distance_km"],
        distanceMiles: json["distance_miles"],
        isFavourite: json["is_favourite"],
        leftStandardTicket: json["left_standard_ticket"],
        leftVipTicket: json["left_vip_ticket"],
        leftNormalTicket: json["left_normal_ticket"],
        clubDetail: ClubDetail.fromJson(json["club_detail"]),
        fiestaImages: List<FiestaImage>.from(
            json["fiesta_images"].map((x) => FiestaImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "club_id": clubId,
        "description": description,
        "timestamp": timestamp?.toIso8601String(),
        "ticket_price": ticketPrice,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "dress_code": dressCode,
        "party_music": partyMusic,
        "total_normal_tickets": totalNormalTickets,
        "total_standard_tickets": totalStandardTickets,
        "total_vip_tickets": totalVipTickets,
        "distance_km": distanceKm,
        "distance_miles": distanceMiles,
        "is_favourite": isFavourite,
        "left_standard_ticket": leftStandardTicket,
        "left_vip_ticket": leftVipTicket,
        "left_normal_ticket": leftNormalTicket,
        "club_detail": clubDetail?.toJson(),
        "fiesta_images":
            List<dynamic>.from(fiestaImages!.map((x) => x.toJson())),
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

class FiestaImage {
  FiestaImage({
    this.id,
    this.image,
    this.fiestaId,
  });

  int? id;
  String? image;
  int? fiestaId;

  factory FiestaImage.fromJson(Map<String, dynamic> json) => FiestaImage(
        id: json["id"],
        image: json["image"],
        fiestaId: json["fiesta_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "fiesta_id": fiestaId,
      };
}
