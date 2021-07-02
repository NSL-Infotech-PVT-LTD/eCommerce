// To parse this JSON data, do
//
//     final fiestasModel = fiestasModelFromJson(jsonString);

import 'dart:convert';

FiestasModel fiestasModelFromJson(String str) =>
    FiestasModel.fromJson(json.decode(str));

String fiestasModelToJson(FiestasModel data) => json.encode(data.toJson());

class FiestasModel {
  FiestasModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory FiestasModel.fromJson(Map<String, dynamic> json) => FiestasModel(
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
    this.name,
    this.clubId,
    this.timestamp,
    this.image,
    this.ticketPrice,
    this.ticketPriceStandard,
    this.ticketPriceVip,
    this.totalMembers,
    this.dressCode,
    this.partyMusic,
    this.distanceKm,
    this.distanceMiles,
  });

  int? id;
  String? name;
  int? clubId;
  DateTime? timestamp;
  String? image;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  String? distanceKm;
  String? distanceMiles;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        clubId: json["club_id"],
        timestamp: DateTime.parse(json["timestamp"]),
        image: json["image"],
        ticketPrice: json["ticket_price"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        dressCode: json["dress_code"],
        partyMusic: json["party_music"],
        distanceKm: json["distance_km"],
        distanceMiles: json["distance_miles"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "club_id": clubId,
        "timestamp": timestamp.toString(),
        "image": image,
        "ticket_price": ticketPrice,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "dress_code": dressCode,
        "party_music": partyMusic,
        "distance_km": distanceKm,
        "distance_miles": distanceMiles,
      };
}
