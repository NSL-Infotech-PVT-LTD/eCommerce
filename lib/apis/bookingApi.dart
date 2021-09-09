import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/cardListmodel.dart';
import 'package:funfy/models/fiestasBookingDetailModel.dart';
import 'package:funfy/models/fiestasDetailmodel.dart';
import 'package:funfy/models/preFiestasBookingListModel.dart';
import 'package:funfy/models/preFiestasCartModel.dart';
import 'package:funfy/models/prefiestasOrderDetailModel.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// <FistaBooking?>
Future fiestasBooking(
    {String? id,
    context,
    String? ticketcount,
    String? standardticketcount,
    String? vipticketcount,
    String? cardId}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  Map<String, String> body = {
    "fiesta_id": "$id",
    "ticket_price_standard":
        standardticketcount != null ? "$standardticketcount" : "0",
    "ticket_price_vip": vipticketcount != null ? "$vipticketcount" : "0",
    "ticket_price_normal": ticketcount != null ? "$ticketcount" : "0",
    "payment_mode": "card",
    "addressId": "${Constants.prefs?.getString("addressId")}",
    "card_id": cardId ?? ""
  };

  var res = await http.post(Uri.parse(Urls.fiestasBookingUrl),
      body: body, headers: headers);

  final jsonRes = json.decode(res.body);

  // var response = Map<String, dynamic>.from(jsonRes);

  // print(res.body);

  if (res.statusCode == 201) {
    return jsonRes;

    // FistaBooking.fromJson(response);
  } else {
    // return jsonRes;
    Dialogs.simpleOkAlertDialog(
        context: context,
        title: "${getTranslated(context, "alert!")}",
        content: "${jsonRes['error']}",
        func: () {
          navigatePopFun(context);
        });
    // print(res.body);
  }
}

// booking list show
// <FiestasBookingList?>
Future fiestasBookingList() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res =
      await http.post(Uri.parse(Urls.fiestasBookingListUrl), headers: headers);

  final jsonRes = json.decode(res.body);

  // print("here is fiestas body");

  // print(res.body);

  // print(jsonRes["data"]["data"]);

  if (res.statusCode == 200) {
    // print("newModle" + res.body);
    // return fiestasBookingListFromJson(res.body);
    return jsonRes["data"]["data"];
  } else {
    print(res.body);
  }
}

Future addproductinCartPrefiestas(
    {String? preFiestaID, String? quantity}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  // print("Bearer ${UserData.userToken}");
  var body = {"pre_fiesta_id": preFiestaID, "quantity": quantity, "reset": "0"};

  var res = await http.post(Uri.parse(Urls.preFiestasBookingUrl),
      body: body, headers: headers);

  // print(res.body);

  var jsonBody = json.decode(res.body);

  print("here is json body cart $jsonBody");

  // CreatePrefiestasCartModel jsonBody =
  //     createPrefiestasCartModelFromJson(res.body); // .decode(res.body);
  if (res.statusCode == 200 || res.statusCode == 201) {
    return jsonBody;
  } else {
    return jsonBody;
  }
}

Future cartResetPrefiestas({
  String? preFiestaID,
  String? quantity,
}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  // print("Bearer ${UserData.userToken}");
  var body = {"pre_fiesta_id": preFiestaID, "quantity": quantity, "reset": "1"};

  var res = await http.post(Uri.parse(Urls.preFiestasBookingUrl),
      body: body, headers: headers);

  var jsonBody = json.decode(res.body);

  return jsonBody;
}

Future<PreFiestasBookingListModel?> preFiestaBookingListApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var res = await http.post(Uri.parse(Urls.preFiestasBookingListUrl),
      headers: headers);

  if (res.statusCode == 200) {
    // print("body Here ---------");

    // print(res.body);

    try {
      return preFiestasBookingListModelFromJson(res.body);
    } catch (e) {
      print("e-------------------- $e");
    }
  } else {
    print("else Here ---------");
    print(res.body);
  }
}

// make Order ------------------- //

Future makeOrderApi({String? cartId, String? addressId, String? cardID}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  DateTime datetime = DateTime.now();

  String date = DateFormat('yyyy-MM-dd').format(datetime);

  String time = DateFormat('kk:mm').format(datetime);

  var body = {
    "cart_id": cartId,
    "date": date,
    "time": time,
    "address_id": addressId,
    "payment_mode": "card",
    "card_id": cardID,
  };

  print("here is body : $body");

  var res = await http.post(Uri.parse(Urls.makeOrderUrl),
      body: body, headers: headers);

  var resp = json.decode(res.body);

  if (res.statusCode == 201) {
    return resp;
  } else {
    print("here is error ${res.body}");
    return resp;
  }
}

// prefiestas Order detail show ------------------- //

Future<PrefiestasOrderDetailModel?> prefiestasShowOrderDetail(
    {String? orderId}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    // 'X-localization': '${Constants.prefs?.getString("language")}'
  };

  // print("token is here - ${UserData.userToken}");

  var body = {
    "id": orderId.toString(),
  };

  var res = await http.post(Uri.parse(Urls.preFiestasOrderItemDetail),
      body: body, headers: headers);

  // print("data is here ");

  // print(res.body);

  if (res.statusCode == 200) {
    // print(res.body);
    return prefiestasOrderDetailModelFromJson(res.body);
  } else {
    print("here is error ${res.body}");
  }
}

// get my prefiestas cart..

Future<PrefiestasCartModel?> getPrefiestasCart() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res =
      await http.post(Uri.parse(Urls.preFiestasGetCartUrl), headers: headers);

  if (res.statusCode == 200) {
    return prefiestasCartModelFromJson(res.body);
  } else {
    print("here is error ${res.body}");
  }
}

// get fiestas by id

Future<FiestasDetailModel?> getFiestasbyId({String? fiestasID}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {"id": "$fiestasID"};

  var res = await http.post(Uri.parse(Urls.fiestasGetByidUrl),
      body: body, headers: headers);

  if (res.statusCode == 200) {
    // print("here is fiestas detail - ${res.body}");
    return fiestasDetailModelFromJson(res.body);
  } else {
    print("here is error ${res.body}");
  }
}

// add card for payment

Future storePaymentCard({String? cardToken}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {"token": "$cardToken"};

  var res = await http.post(Uri.parse(Urls.addPaymentCardUrl),
      body: body, headers: headers);

  if (res.statusCode == 201) {
    return json.decode(res.body);
    // print("here is fiestas detail - ${res.body}");

  } else {
    // print("here is error ${res.body}");
  }
}

// get card list

Future<CardListModel?> getCardList({String? cardToken}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {"token": "$cardToken"};

  var res = await http.post(Uri.parse(Urls.getCardListUrl),
      body: body, headers: headers);

  if (res.statusCode == 200) {
    // print("here is fiestas detail - ${res.body}");

    return cardListModelFromJson(res.body);
  } else {
    return null;
    // print("here is error ${res.body}");
  }
}

// delete card

Future deleteCard({String? cardIds}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {"card_id": "$cardIds"};

  var res = await http.post(Uri.parse(Urls.deleteCardUrl),
      body: body, headers: headers);

  if (res.statusCode == 200) {
    print("here is delete - ${res.body}");

    return cardListModelFromJson(res.body);
  } else {
    print("here is error ${res.body}");
  }
}

// fiestas booking order detail

Future<FiestasBookingDetailModel?> fiestaBookingOrderDetailApi(
    {String? fiestasId, context}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {"id": "$fiestasId"};

  var res = await http.post(Uri.parse(Urls.fiestasBookingOrderDetail),
      headers: headers, body: body);

  print(res.body);
  if (res.statusCode == 422) {
    Dialogs.simpleOkAlertDialog(
        context: context,
        content: "${getTranslated(context, 'theSelectedItemIsinvalid')}",
        title: "${getTranslated(context, 'alert!')}",
        func: () {
          navigatePopFun(context);
        });

    Future.delayed(Duration(seconds: 2), () {
      navigatorPushFun(
          context,
          Home(
            pageIndexNum: 0,
          ));
    });
  }

  if (res.statusCode == 200) {
    // return null;
    return fiestasBookingDetailModelFromJson(res.body);
  } else {
    print(res.body);
  }
}

// fiestas rating Api

Future<bool?> fiestaRatingApi(
    {String? orderId, String? fiestasId, double? rating}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {
    "fiesta_id": fiestasId,
    "booking_id": orderId,
    "rate": "$rating",
    "review": "Rating"
  };

  print("here is $body");

  var res = await http.post(Uri.parse(Urls.fiestasRatingUrl),
      headers: headers, body: body);

  print(res.body);

  if (res.statusCode == 200) {
    return true;
  } else {
    // print(res.body);

    return false;
  }
}

// fiestas rating Api

Future<bool?> prefiestaRatingApi({String? orderId, double? rating}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {"order_id": orderId, "rate": "$rating", "review": "Rating"};

  print("here is $body");

  var res = await http.post(Uri.parse(Urls.prefiestasRatingUrl),
      headers: headers, body: body);

  print(res.body);

  if (res.statusCode == 200) {
    return true;
  } else {
    // print(res.body);

    return false;
  }
}
