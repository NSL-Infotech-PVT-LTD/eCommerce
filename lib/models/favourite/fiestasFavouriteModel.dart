// To parse this JSON data, do
//
//     final fiestasFavouriteModel = fiestasFavouriteModelFromJson(jsonString);

import 'dart:convert';

FiestasFavouriteModel fiestasFavouriteModelFromJson(String str) =>
    FiestasFavouriteModel.fromJson(json.decode(str));

String fiestasFavouriteModelToJson(FiestasFavouriteModel data) =>
    json.encode(data.toJson());

class FiestasFavouriteModel {
  FiestasFavouriteModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory FiestasFavouriteModel.fromJson(Map<String, dynamic> json) =>
      FiestasFavouriteModel(
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
    this.type,
    this.clubId,
    this.name,
    this.timestamp,
    this.image,
    this.description,
    this.ticketPrice,
    this.ticketPriceStandard,
    this.ticketPriceVip,
    this.totalMembers,
    this.dressCode,
    this.partyMusic,
    this.params,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.distanceKm,
    this.distanceMiles,
    this.isFavourite,
  });

  int? id;
  String? type;
  int? clubId;
  String? name;
  String? timestamp;
  String? image;
  String? description;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  dynamic params;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? distanceKm;
  String? distanceMiles;
  bool? isFavourite;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        clubId: json["club_id"],
        name: json["name"],
        timestamp: json["timestamp"],
        image: json["image"],
        description: json["description"],
        ticketPrice: json["ticket_price"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        dressCode: json["dress_code"],
        partyMusic: json["party_music"],
        params: json["params"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        distanceKm: json["distance_km"],
        distanceMiles: json["distance_miles"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "club_id": clubId,
        "name": name,
        "timestamp": timestamp,
        "image": image,
        "description": description,
        "ticket_price": ticketPrice,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "dress_code": dressCode,
        "party_music": partyMusic,
        "params": params,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "distance_km": distanceKm,
        "distance_miles": distanceMiles,
        "is_favourite": isFavourite,
      };
}
