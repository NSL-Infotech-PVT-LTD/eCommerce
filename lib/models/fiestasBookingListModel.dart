// To parse this JSON data, do
//
//     final fiestasBookingList = fiestasBookingListFromJson(jsonString);

import 'dart:convert';

FiestasBookingList fiestasBookingListFromJson(String str) =>
    FiestasBookingList.fromJson(json.decode(str));

String fiestasBookingListToJson(FiestasBookingList data) =>
    json.encode(data.toJson());

class FiestasBookingList {
  FiestasBookingList({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory FiestasBookingList.fromJson(Map<String, dynamic> json) =>
      FiestasBookingList(
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
  List<DataListFiesta>? data;
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
        data: List<DataListFiesta>.from(
            json["data"].map((x) => DataListFiesta.fromJson(x))),
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

class DataListFiesta {
  DataListFiesta({
    this.id,
    this.userId,
    this.fiestaId,
    this.totalPrice,
    this.paymentParams,
    this.paymentMode,
    this.bookingStatus,
    this.params,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.fiestaDetail,
  });

  int? id;
  int? userId;
  int? fiestaId;
  String? totalPrice;
  PaymentParams? paymentParams;
  String? paymentMode;
  BookingStatus? bookingStatus;
  dynamic params;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  FiestaDetail? fiestaDetail;

  factory DataListFiesta.fromJson(Map<String, dynamic> json) => DataListFiesta(
        id: json["id"],
        userId: json["user_id"],
        fiestaId: json["fiesta_id"],
        totalPrice: json["total_price"],
        paymentParams: json["payment_params"] == null
            ? null
            : PaymentParams.fromJson(json["payment_params"]),
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        bookingStatus: bookingStatusValues.map[json["booking_status"]],
        params: json["params"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        fiestaDetail: FiestaDetail.fromJson(json["fiesta_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "fiesta_id": fiestaId,
        "total_price": totalPrice,
        "payment_params":
            paymentParams == null ? null : paymentParams?.toJson(),
        "payment_mode": paymentMode == null ? null : paymentMode,
        "booking_status": bookingStatusValues.reverse[bookingStatus],
        "params": params,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "fiesta_detail": fiestaDetail?.toJson(),
      };
}

enum BookingStatus { PENDING, BOOKED }

final bookingStatusValues = EnumValues(
    {"booked": BookingStatus.BOOKED, "pending": BookingStatus.PENDING});

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
  FiestaDetailName? name;
  int? clubId;
  DateTime? timestamp;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  PartyMusic? partyMusic;
  DistanceKm? distanceKm;
  DistanceMiles? distanceMiles;
  bool? isFavourite;
  int? leftStandardTicket;
  dynamic leftVipTicket;
  int? leftNormalTicket;
  dynamic clubRating;
  ClubDetail? clubDetail;

  factory FiestaDetail.fromJson(Map<String, dynamic> json) => FiestaDetail(
        id: json["id"],
        name: fiestaDetailNameValues.map[json["name"]],
        clubId: json["club_id"],
        timestamp: DateTime.parse(json["timestamp"]),
        ticketPrice: json["ticket_price"],
        ticketPriceStandard: json["ticket_price_standard"],
        ticketPriceVip: json["ticket_price_vip"],
        totalMembers: json["total_members"],
        dressCode: json["dress_code"],
        partyMusic: partyMusicValues.map[json["party_music"]],
        distanceKm: distanceKmValues.map[json["distance_km"]],
        distanceMiles: distanceMilesValues.map[json["distance_miles"]],
        isFavourite: json["is_favourite"],
        leftStandardTicket: json["left_standard_ticket"],
        leftVipTicket: json["left_vip_ticket"],
        leftNormalTicket: json["left_normal_ticket"],
        clubRating: json["club_rating"],
        clubDetail: ClubDetail.fromJson(json["club_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": fiestaDetailNameValues.reverse[name],
        "club_id": clubId,
        "timestamp": timestamp?.toIso8601String(),
        "ticket_price": ticketPrice,
        "ticket_price_standard": ticketPriceStandard,
        "ticket_price_vip": ticketPriceVip,
        "total_members": totalMembers,
        "dress_code": dressCode,
        "party_music": partyMusicValues.reverse[partyMusic],
        "distance_km": distanceKmValues.reverse[distanceKm],
        "distance_miles": distanceMilesValues.reverse[distanceMiles],
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
  ClubDetailName? name;
  String? image;
  String? capacity;
  Description? description;
  Location? location;
  dynamic latitude;
  dynamic longitude;

  factory ClubDetail.fromJson(Map<String, dynamic> json) => ClubDetail(
        id: json["id"],
        name: clubDetailNameValues.map[json["name"]],
        image: json["image"],
        capacity: json["capacity"],
        description: descriptionValues.map[json["description"]],
        location: locationValues.map[json["location"]],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": clubDetailNameValues.reverse[name],
        "image": image,
        "capacity": capacity,
        "description": descriptionValues.reverse[description],
        "location": locationValues.reverse[location],
        "latitude": latitude,
        "longitude": longitude,
      };
}

enum Description {
  OFFICIIS_FACERE_NOSTRUM_NIHIL_MINIMA_IURE_APERIAM_IURE_QUO,
  TEST
}

final descriptionValues = EnumValues({
  "Officiis facere nostrum nihil minima iure aperiam iure quo.":
      Description.OFFICIIS_FACERE_NOSTRUM_NIHIL_MINIMA_IURE_APERIAM_IURE_QUO,
  "test": Description.TEST
});

enum Location { PERFERENDIS_SAPIENTE_CORPORIS_MOLESTIAS_ENIM_IPSA, TEST }

final locationValues = EnumValues({
  "Perferendis sapiente corporis molestias enim ipsa.":
      Location.PERFERENDIS_SAPIENTE_CORPORIS_MOLESTIAS_ENIM_IPSA,
  "test": Location.TEST
});

enum ClubDetailName { ALIZE_EBERT, TEST }

final clubDetailNameValues = EnumValues(
    {"Alize Ebert": ClubDetailName.ALIZE_EBERT, "test": ClubDetailName.TEST});

enum DistanceKm { THE_01_KM }

final distanceKmValues = EnumValues({"0.1 km": DistanceKm.THE_01_KM});

enum DistanceMiles { THE_01_MILES }

final distanceMilesValues =
    EnumValues({"0.1 miles": DistanceMiles.THE_01_MILES});

enum FiestaDetailName { OPEN_FIESTAS, FIESTA_AWESOME, OPEN_2, ZEEM_OPEN }

final fiestaDetailNameValues = EnumValues({
  "Fiesta Awesome": FiestaDetailName.FIESTA_AWESOME,
  "Open 2": FiestaDetailName.OPEN_2,
  "open fiestas": FiestaDetailName.OPEN_FIESTAS,
  "Zeem Open": FiestaDetailName.ZEEM_OPEN
});

enum PartyMusic { MUSIC, POP }

final partyMusicValues =
    EnumValues({"Music": PartyMusic.MUSIC, "pop": PartyMusic.POP});

class PaymentParams {
  PaymentParams({
    this.id,
    this.object,
    this.amount,
    this.amountCaptured,
    this.amountRefunded,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    this.balanceTransaction,
    this.billingDetails,
    this.calculatedStatementDescriptor,
    this.captured,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.destination,
    this.dispute,
    this.disputed,
    this.failureCode,
    this.failureMessage,
    this.fraudDetails,
    this.invoice,
    this.livemode,
    this.metadata,
    this.onBehalfOf,
    this.order,
    this.outcome,
    this.paid,
    this.paymentIntent,
    this.paymentMethod,
    this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    this.receiptUrl,
    this.refunded,
    this.refunds,
    this.review,
    this.shipping,
    this.source,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  String? id;
  String? object;
  int? amount;
  int? amountCaptured;
  int? amountRefunded;
  dynamic application;
  dynamic applicationFee;
  dynamic applicationFeeAmount;
  String? balanceTransaction;
  BillingDetails? billingDetails;
  String? calculatedStatementDescriptor;
  bool? captured;
  int? created;
  String? currency;
  String? customer;
  dynamic description;
  dynamic destination;
  dynamic dispute;
  bool? disputed;
  dynamic failureCode;
  dynamic failureMessage;
  List<dynamic>? fraudDetails;
  dynamic invoice;
  bool? livemode;
  List<dynamic>? metadata;
  dynamic onBehalfOf;
  dynamic order;
  Outcome? outcome;
  bool? paid;
  dynamic paymentIntent;
  String? paymentMethod;
  PaymentMethodDetails? paymentMethodDetails;
  dynamic receiptEmail;
  dynamic receiptNumber;
  String? receiptUrl;
  bool? refunded;
  Refunds? refunds;
  dynamic review;
  dynamic shipping;
  Source? source;
  dynamic sourceTransfer;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String? status;
  dynamic transferData;
  dynamic transferGroup;

  factory PaymentParams.fromJson(Map<String, dynamic> json) => PaymentParams(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCaptured: json["amount_captured"],
        amountRefunded: json["amount_refunded"],
        application: json["application"],
        applicationFee: json["application_fee"],
        applicationFeeAmount: json["application_fee_amount"],
        balanceTransaction: json["balance_transaction"],
        billingDetails: BillingDetails.fromJson(json["billing_details"]),
        calculatedStatementDescriptor: json["calculated_statement_descriptor"],
        captured: json["captured"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        destination: json["destination"],
        dispute: json["dispute"],
        disputed: json["disputed"],
        failureCode: json["failure_code"],
        failureMessage: json["failure_message"],
        fraudDetails: List<dynamic>.from(json["fraud_details"].map((x) => x)),
        invoice: json["invoice"],
        livemode: json["livemode"],
        metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
        onBehalfOf: json["on_behalf_of"],
        order: json["order"],
        outcome: Outcome.fromJson(json["outcome"]),
        paid: json["paid"],
        paymentIntent: json["payment_intent"],
        paymentMethod: json["payment_method"],
        paymentMethodDetails:
            PaymentMethodDetails.fromJson(json["payment_method_details"]),
        receiptEmail: json["receipt_email"],
        receiptNumber: json["receipt_number"],
        receiptUrl: json["receipt_url"],
        refunded: json["refunded"],
        refunds: Refunds.fromJson(json["refunds"]),
        review: json["review"],
        shipping: json["shipping"],
        source: Source.fromJson(json["source"]),
        sourceTransfer: json["source_transfer"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_captured": amountCaptured,
        "amount_refunded": amountRefunded,
        "application": application,
        "application_fee": applicationFee,
        "application_fee_amount": applicationFeeAmount,
        "balance_transaction": balanceTransaction,
        "billing_details": billingDetails?.toJson(),
        "calculated_statement_descriptor": calculatedStatementDescriptor,
        "captured": captured,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "destination": destination,
        "dispute": dispute,
        "disputed": disputed,
        "failure_code": failureCode,
        "failure_message": failureMessage,
        "fraud_details": List<dynamic>.from(fraudDetails!.map((x) => x)),
        "invoice": invoice,
        "livemode": livemode,
        "metadata": List<dynamic>.from(metadata!.map((x) => x)),
        "on_behalf_of": onBehalfOf,
        "order": order,
        "outcome": outcome?.toJson(),
        "paid": paid,
        "payment_intent": paymentIntent,
        "payment_method": paymentMethod,
        "payment_method_details": paymentMethodDetails!.toJson(),
        "receipt_email": receiptEmail,
        "receipt_number": receiptNumber,
        "receipt_url": receiptUrl,
        "refunded": refunded,
        "refunds": refunds?.toJson(),
        "review": review,
        "shipping": shipping,
        "source": source?.toJson(),
        "source_transfer": sourceTransfer,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
      };
}

class BillingDetails {
  BillingDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
  });

  Address? address;
  dynamic email;
  dynamic name;
  dynamic phone;

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
        address: Address.fromJson(json["address"]),
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "email": email,
        "name": name,
        "phone": phone,
      };
}

class Address {
  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  dynamic city;
  dynamic country;
  dynamic line1;
  dynamic line2;
  dynamic postalCode;
  dynamic state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        line1: json["line1"],
        line2: json["line2"],
        postalCode: json["postal_code"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "line1": line1,
        "line2": line2,
        "postal_code": postalCode,
        "state": state,
      };
}

class Outcome {
  Outcome({
    this.networkStatus,
    this.reason,
    this.riskLevel,
    this.riskScore,
    this.sellerMessage,
    this.type,
  });

  String? networkStatus;
  dynamic reason;
  String? riskLevel;
  int? riskScore;
  String? sellerMessage;
  String? type;

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        networkStatus: json["network_status"],
        reason: json["reason"],
        riskLevel: json["risk_level"],
        riskScore: json["risk_score"],
        sellerMessage: json["seller_message"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "network_status": networkStatus,
        "reason": reason,
        "risk_level": riskLevel,
        "risk_score": riskScore,
        "seller_message": sellerMessage,
        "type": type,
      };
}

class PaymentMethodDetails {
  PaymentMethodDetails({
    this.card,
    this.type,
  });

  Card? card;
  String? type;

  factory PaymentMethodDetails.fromJson(Map<String, dynamic> json) =>
      PaymentMethodDetails(
        card: Card.fromJson(json["card"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "card": card?.toJson(),
        "type": type,
      };
}

class Card {
  Card({
    this.brand,
    this.checks,
    this.country,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.installments,
    this.last4,
    this.network,
    this.threeDSecure,
    this.wallet,
  });

  String? brand;
  Checks? checks;
  String? country;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  dynamic installments;
  String? last4;
  String? network;
  dynamic threeDSecure;
  dynamic wallet;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        brand: json["brand"],
        checks: Checks.fromJson(json["checks"]),
        country: json["country"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        funding: json["funding"],
        installments: json["installments"],
        last4: json["last4"],
        network: json["network"],
        threeDSecure: json["three_d_secure"],
        wallet: json["wallet"],
      );

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "checks": checks?.toJson(),
        "country": country,
        "exp_month": expMonth,
        "exp_year": expYear,
        "fingerprint": fingerprint,
        "funding": funding,
        "installments": installments,
        "last4": last4,
        "network": network,
        "three_d_secure": threeDSecure,
        "wallet": wallet,
      };
}

class Checks {
  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck,
  });

  dynamic addressLine1Check;
  dynamic addressPostalCodeCheck;
  dynamic cvcCheck;

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
        addressLine1Check: json["address_line1_check"],
        addressPostalCodeCheck: json["address_postal_code_check"],
        cvcCheck: json["cvc_check"],
      );

  Map<String, dynamic> toJson() => {
        "address_line1_check": addressLine1Check,
        "address_postal_code_check": addressPostalCodeCheck,
        "cvc_check": cvcCheck,
      };
}

class Refunds {
  Refunds({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  String? object;
  List<dynamic>? data;
  bool? hasMore;
  int? totalCount;
  String? url;

  factory Refunds.fromJson(Map<String, dynamic> json) => Refunds(
        object: json["object"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
      };
}

class Source {
  Source({
    this.id,
    this.object,
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine1Check,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.addressZipCheck,
    this.brand,
    this.country,
    this.customer,
    this.cvcCheck,
    this.dynamicLast4,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.last4,
    this.metadata,
    this.name,
    this.tokenizationMethod,
  });

  String? id;
  String? object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  String? brand;
  String? country;
  String? customer;
  dynamic cvcCheck;
  dynamic dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  List<dynamic>? metadata;
  dynamic name;
  dynamic tokenizationMethod;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        object: json["object"],
        addressCity: json["address_city"],
        addressCountry: json["address_country"],
        addressLine1: json["address_line1"],
        addressLine1Check: json["address_line1_check"],
        addressLine2: json["address_line2"],
        addressState: json["address_state"],
        addressZip: json["address_zip"],
        addressZipCheck: json["address_zip_check"],
        brand: json["brand"],
        country: json["country"],
        customer: json["customer"],
        cvcCheck: json["cvc_check"],
        dynamicLast4: json["dynamic_last4"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        funding: json["funding"],
        last4: json["last4"],
        metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
        name: json["name"],
        tokenizationMethod: json["tokenization_method"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "address_city": addressCity,
        "address_country": addressCountry,
        "address_line1": addressLine1,
        "address_line1_check": addressLine1Check,
        "address_line2": addressLine2,
        "address_state": addressState,
        "address_zip": addressZip,
        "address_zip_check": addressZipCheck,
        "brand": brand,
        "country": country,
        "customer": customer,
        "cvc_check": cvcCheck,
        "dynamic_last4": dynamicLast4,
        "exp_month": expMonth,
        "exp_year": expYear,
        "fingerprint": fingerprint,
        "funding": funding,
        "last4": last4,
        "metadata": List<dynamic>.from(metadata!.map((x) => x)),
        "name": name,
        "tokenization_method": tokenizationMethod,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
