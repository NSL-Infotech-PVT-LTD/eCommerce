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
    this.type,
    this.clubId,
    this.name,
    this.timestamp,
    this.image,
    this.description,
    this.ageGroup,
    this.filterLocalId,
    this.filterEnvironmentId,
    this.filterClothingId,
    this.filterMusicId,
    this.filterScheduleId,
    this.totalMembers,
    this.ticketPriceNormal,
    this.ticketPriceStandard,
    this.ticketPriceVip,
    this.totalVipTickets,
    this.totalStandardTickets,
    this.totalNormalTickets,
    this.clubRating,
    this.leftNormalTicket,
    this.leftStandardTicket,
    this.leftVipTicket,
    this.isFavourite,
    this.distanceKm,
    this.distanceMiles,
    this.clubDetail,
    this.fiestaImages,
  });

  int? id;
  String? type;
  int? clubId;
  String? name;
  DateTime? timestamp;
  dynamic image;
  String? description;
  String? ageGroup;
  int? filterLocalId;
  int? filterEnvironmentId;
  int? filterClothingId;
  int? filterMusicId;
  int? filterScheduleId;
  String? totalMembers;
  String? ticketPriceNormal;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalVipTickets;
  String? totalStandardTickets;
  String? totalNormalTickets;
  dynamic clubRating;
  String? leftNormalTicket;
  String? leftStandardTicket;
  String? leftVipTicket;
  bool? isFavourite;
  String? distanceKm;
  String? distanceMiles;
  ClubDetail? clubDetail;
  List<FiestaImage>? fiestaImages;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        clubId: json["club_id"],
        name: json["name"],
        timestamp: DateTime.parse(json["timestamp"]),
        image: json["image"],
        description: json["description"],
        ageGroup: json["age_group"],
        filterLocalId: json["filter_local_id"],
        filterEnvironmentId: json["filter_environment_id"],
        filterClothingId: json["filter_clothing_id"],
        filterMusicId: json["filter_music_id"],
        filterScheduleId: json["filter_schedule_id"],
        totalMembers: json["total_members"],
        ticketPriceNormal: json["ticket_price_normal"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalVipTickets: json["total_vip_tickets"],
        totalStandardTickets: json["total_standard_tickets"],
        totalNormalTickets: json["total_normal_tickets"],
        clubRating: json["club_rating"],
        leftNormalTicket: json["left_normal_ticket"],
        leftStandardTicket: json["left_standard_ticket"],
        leftVipTicket: json["left_vip_ticket"],
        isFavourite: json["is_favourite"],
        distanceKm: json["distance_km"],
        distanceMiles: json["distance_miles"],
        clubDetail: ClubDetail.fromJson(json["club_detail"]),
        fiestaImages: List<FiestaImage>.from(
            json["fiesta_images"].map((x) => FiestaImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "club_id": clubId,
        "name": name,
        "timestamp": timestamp?.toIso8601String(),
        "image": image,
        "description": description,
        "age_group": ageGroup,
        "filter_local_id": filterLocalId,
        "filter_environment_id": filterEnvironmentId,
        "filter_clothing_id": filterClothingId,
        "filter_music_id": filterMusicId,
        "filter_schedule_id": filterScheduleId,
        "total_members": totalMembers,
        "ticket_price_normal": ticketPriceNormal,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_vip_tickets": totalVipTickets,
        "total_standard_tickets": totalStandardTickets,
        "total_normal_tickets": totalNormalTickets,
        "club_rating": clubRating,
        "left_normal_ticket": leftNormalTicket,
        "left_standard_ticket": leftStandardTicket,
        "left_vip_ticket": leftVipTicket,
        "is_favourite": isFavourite,
        "distance_km": distanceKm,
        "distance_miles": distanceMiles,
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
