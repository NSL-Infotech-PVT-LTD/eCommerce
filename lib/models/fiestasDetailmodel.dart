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
    this.distanceMiles,
    this.filterLocal,
    this.filterEnvironment,
    this.filterMusic,
    this.filterClothing,
    this.filterSchedule,
    this.clubDetail,
    this.fiestaImages,
  });

  int? id;
  var clubId;
  String? name;
  var timestamp;
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
  var clubRating;
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
  List<FiestaImage>? fiestaImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
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
        distanceMiles: json["distance_miles"],
        filterLocal: Filter.fromJson(json["filter_local"]),
        filterEnvironment: Filter.fromJson(json["filter_environment"]),
        filterMusic: Filter.fromJson(json["filter_music"]),
        filterClothing: Filter.fromJson(json["filter_clothing"]),
        filterSchedule: Filter.fromJson(json["filter_schedule"]),
        clubDetail: ClubDetail.fromJson(json["club_detail"]),
        fiestaImages: List<FiestaImage>.from(
            json["fiesta_images"].map((x) => FiestaImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "distance_miles": distanceMiles,
        "filter_local": filterLocal?.toJson(),
        "filter_environment": filterEnvironment?.toJson(),
        "filter_music": filterMusic?.toJson(),
        "filter_clothing": filterClothing?.toJson(),
        "filter_schedule": filterSchedule?.toJson(),
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
