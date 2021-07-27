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
    this.description,
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
    this.isFavourite,
    this.clubDetail,
  });

  int? id;
  String? name;
  int? clubId;
  String? description;
  String? timestamp;
  String? image;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  String? distanceKm;
  String? distanceMiles;
  bool? isFavourite;
  ClubDetail? clubDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        clubId: json["club_id"],
        description: json["description"],
        timestamp: json["timestamp"],
        image: json["image"],
        ticketPrice: json["ticket_price"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        dressCode: json["dress_code"],
        partyMusic: json["party_music"],
        distanceKm: json["distance_km"],
        distanceMiles: json["distance_miles"],
        isFavourite: json["is_favourite"],
        clubDetail: ClubDetail.fromJson(json["club_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "club_id": clubId,
        "description": description,
        "timestamp": timestamp,
        "image": image,
        "ticket_price": ticketPrice,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "dress_code": dressCode,
        "party_music": partyMusic,
        "distance_km": distanceKm,
        "distance_miles": distanceMiles,
        "is_favourite": isFavourite,
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
