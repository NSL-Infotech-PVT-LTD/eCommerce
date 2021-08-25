// To parse this JSON data, do
//
//     final prefiestasOrderDetailModel = prefiestasOrderDetailModelFromJson(jsonString);

import 'dart:convert';

PrefiestasOrderDetailModel prefiestasOrderDetailModelFromJson(String str) =>
    PrefiestasOrderDetailModel.fromJson(json.decode(str));

String prefiestasOrderDetailModelToJson(PrefiestasOrderDetailModel data) =>
    json.encode(data.toJson());

class PrefiestasOrderDetailModel {
  PrefiestasOrderDetailModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PrefiestasOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      PrefiestasOrderDetailModel(
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
    this.parentDetail,
    this.orderDetail,
  });

  Detail? parentDetail;
  List<OrderDetail>? orderDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        parentDetail: Detail.fromJson(json["parentDetail"]),
        orderDetail: List<OrderDetail>.from(
            json["orderDetail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parentDetail": parentDetail?.toJson(),
        "orderDetail": List<dynamic>.from(orderDetail!.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.date,
    this.time,
    this.orderBy,
    this.transferCharge,
    this.totalPrice,
    this.address,
    this.orderStatus,
    this.paymentParams,
    this.paymentMode,
    this.categoryDetail,
    this.orderItem,
  });

  int? id;
  DateTime? date;
  String? time;
  int? orderBy;
  dynamic transferCharge;
  int? totalPrice;
  String? address;
  String? orderStatus;
  PaymentParams? paymentParams;
  String? paymentMode;
  Detail? categoryDetail;
  List<OrderItem>? orderItem;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        orderBy: json["order_by"],
        transferCharge: json["transfer_charge"],
        totalPrice: json["total_price"],
        address: json["address"],
        orderStatus: json["order_status"],
        paymentParams: PaymentParams.fromJson(json["payment_params"]),
        paymentMode: json["payment_mode"],
        categoryDetail: Detail.fromJson(json["category_detail"]),
        orderItem: List<OrderItem>.from(
            json["order_item"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time": time,
        "order_by": orderBy,
        "transfer_charge": transferCharge,
        "total_price": totalPrice,
        "address": address,
        "order_status": orderStatus,
        "payment_params": paymentParams?.toJson(),
        "payment_mode": paymentMode,
        "category_detail": categoryDetail?.toJson(),
        "order_item": List<dynamic>.from(orderItem!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.name,
    this.parentId,
    this.image,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
    this.id,
    this.status,
  });

  String? name;
  int? parentId;
  String? image;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;
  int? id;
  String? status;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        name: json["name"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        image: json["image"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
        id: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "parent_id": parentId == null ? null : parentId,
        "image": image,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
        "id": id == null ? null : id,
        "status": status == null ? null : status,
      };
}

class OrderItem {
  OrderItem({
    this.orderId,
    this.preFiestaId,
    this.quantity,
    this.price,
    this.preFiesta,
  });

  int? orderId;
  int? preFiestaId;
  int? quantity;
  int? price;
  PreFiesta? preFiesta;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orderId: json["order_id"],
        preFiestaId: json["pre_fiesta_id"],
        quantity: json["quantity"],
        price: json["price"],
        preFiesta: PreFiesta.fromJson(json["pre_fiesta"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "pre_fiesta_id": preFiestaId,
        "quantity": quantity,
        "price": price,
        "pre_fiesta": preFiesta?.toJson(),
      };
}

class PreFiesta {
  PreFiesta({
    this.id,
    this.name,
    this.quantity,
    this.categories,
    this.image,
    this.price,
    this.description,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
  });

  int? id;
  String? name;
  int? quantity;
  String? categories;
  String? image;
  String? price;
  String? description;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;

  factory PreFiesta.fromJson(Map<String, dynamic> json) => PreFiesta(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        categories: json["categories"],
        image: json["image"],
        price: json["price"],
        description: json["description"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "quantity": quantity,
        "categories": categories,
        "image": image,
        "price": price,
        "description": description,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
      };
}

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
        "outcome": outcome!.toJson(),
        "paid": paid,
        "payment_intent": paymentIntent,
        "payment_method": paymentMethod,
        "payment_method_details": paymentMethodDetails?.toJson(),
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
  String? name;
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
  String? name;
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
