// To parse this JSON data, do
//
//     final facebookSigninModel = facebookSigninModelFromJson(jsonString);

import 'dart:convert';

FacebookSigninModel facebookSigninModelFromJson(String str) =>
    FacebookSigninModel.fromJson(json.decode(str));

String facebookSigninModelToJson(FacebookSigninModel data) =>
    json.encode(data.toJson());

class FacebookSigninModel {
  FacebookSigninModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory FacebookSigninModel.fromJson(Map<String, dynamic> json) =>
      FacebookSigninModel(
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
    this.message,
    this.token,
    this.user,
  });

  String? message;
  String? token;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.isClubAdmin,
    this.mobile,
    this.email,
    this.gender,
    this.image,
    this.dob,
    this.radius,
    this.isAvailable,
    this.appleId,
    this.fbId,
    this.googleId,
    this.isNotify,
    this.stripeAccountId,
    this.params,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.stripeId,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.role,
  });

  int? id;
  String? name;
  String? isClubAdmin;
  String? mobile;
  String? email;
  String? gender;
  String? image;
  String? dob;
  dynamic radius;
  String? isAvailable;
  dynamic appleId;
  String? fbId;
  dynamic googleId;
  String? isNotify;
  dynamic stripeAccountId;
  dynamic params;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  List<dynamic>? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        isClubAdmin: json["is_clubAdmin"],
        mobile: json["mobile"],
        email: json["email"],
        gender: json["gender"],
        image: json["image"],
        dob: json["dob"],
        radius: json["radius"],
        isAvailable: json["is_available"],
        appleId: json["apple_id"],
        fbId: json["fb_id"],
        googleId: json["google_id"],
        isNotify: json["is_notify"],
        stripeAccountId: json["stripe_account_id"],
        params: json["params"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        stripeId: json["stripe_id"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        trialEndsAt: json["trial_ends_at"],
        role: List<dynamic>.from(json["role"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_clubAdmin": isClubAdmin,
        "mobile": mobile,
        "email": email,
        "gender": gender,
        "image": image,
        "dob": dob,
        "radius": radius,
        "is_available": isAvailable,
        "apple_id": appleId,
        "fb_id": fbId,
        "google_id": googleId,
        "is_notify": isNotify,
        "stripe_account_id": stripeAccountId,
        "params": params,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "stripe_id": stripeId,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "role": List<dynamic>.from(role!.map((x) => x)),
      };
}
