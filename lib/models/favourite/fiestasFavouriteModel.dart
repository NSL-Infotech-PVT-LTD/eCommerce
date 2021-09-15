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
  var perPage;
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
    this.description,
    this.ticketPriceNormal,
    this.ticketPriceStandard,
    this.ticketPriceVip,
    this.totalMembers,
    this.filterClothingId,
    this.filterMusicId,
    this.filterLocalId,
    this.filterEnvironmentId,
    this.filterScheduleId,
    this.totalNormalTickets,
    this.totalStandardTickets,
    this.totalVipTickets,
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
  });

  int? id;
  String? name;
  int? clubId;
  DateTime? timestamp;
  String? description;
  String? ticketPriceNormal;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  int? filterClothingId;
  int? filterMusicId;
  int? filterLocalId;
  int? filterEnvironmentId;
  int? filterScheduleId;
  String? totalNormalTickets;
  String? totalStandardTickets;
  String? totalVipTickets;
  double? clubRating;
  var leftStandardTicket;
  var leftVipTicket;
  var leftNormalTicket;
  bool? isFavourite;
  String? distanceMiles;
  Filter? filterLocal;
  Filter? filterEnvironment;
  Filter? filterMusic;
  Filter? filterClothing;
  Filter? filterSchedule;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        clubId: json["club_id"],
        timestamp: DateTime.parse(json["timestamp"]),
        description: json["description"],
        ticketPriceNormal: json["ticket_price_normal"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        filterClothingId: json["filter_clothing_id"],
        filterMusicId: json["filter_music_id"],
        filterLocalId: json["filter_local_id"],
        filterEnvironmentId: json["filter_environment_id"],
        filterScheduleId: json["filter_schedule_id"],
        totalNormalTickets: json["total_normal_tickets"],
        totalStandardTickets: json["total_standard_tickets"],
        totalVipTickets: json["total_vip_tickets"],
        clubRating:
            json["club_rating"] == null ? null : json["club_rating"].toDouble(),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "club_id": clubId,
        "timestamp": timestamp?.toIso8601String(),
        "description": description,
        "ticket_price_normal": ticketPriceNormal,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "filter_clothing_id": filterClothingId,
        "filter_music_id": filterMusicId,
        "filter_local_id": filterLocalId,
        "filter_environment_id": filterEnvironmentId,
        "filter_schedule_id": filterScheduleId,
        "total_normal_tickets": totalNormalTickets,
        "total_standard_tickets": totalStandardTickets,
        "total_vip_tickets": totalVipTickets,
        "club_rating": clubRating == null ? null : clubRating,
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
