import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/models/favourite/fiestasFavouriteModel.dart';
import 'package:funfy/models/favourite/preFiestasFavModel.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/filterModel.dart';
import 'package:funfy/models/notificationListModel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/models/prefiestasDetailModel.dart';
import 'package:funfy/models/prifiestasAlMxEx.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/strings.dart';
import 'package:funfy/utils/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<FiestasModel?> fiestasPostGet(
    {context,
    String? type,
    String? dateFilter,
    filterDataF,
    String? pageCount,
    String? limitCount}) async {
  // print("here is date filter");

  // print("$dateFilter");
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {
    // type == null ? "" :

    "type": "${type ?? ''}",
    // dateFilter == null || dateFilter == "" ? "" :
    "date": "${dateFilter ?? ''}",
    "local": "${filterDataF['local']}",
    "environment": "${filterDataF['environment']}",
    "schedule": "${filterDataF['schedule']}",
    "music": "${filterDataF['music']}",
    "clothing": "${filterDataF['clothing']}",
    "ageGroup": "${filterDataF['ageGroup']}",
    "limit": "${limitCount ?? ''}",
    "sort_by": "desc",
    'page': "${pageCount ?? ''}",

    "latitude": "${Constants.prefs?.getString("lat") ?? ''}",
    "longitude": "${Constants.prefs?.getString("lng") ?? ''}"
  };

  var res = await http.post(Uri.parse(Urls.fiestasPostUrl),
      body: body, headers: headers);

  // print(res.body);

  if (res.statusCode == 401) {
    userSessionExpired(context);
  }

  if (res.statusCode == 200) {
    try {
      // print("here is data");
      // print(res.body);
      return fiestasModelFromJson(res.body);
    } catch (e) {
      print("here is filter error........$e");
    }
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in fiestas");
  }
}

Future<PrefiestasModel?> prefiestasPostGet(
    {context, String? pageCount, String? limitCount}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {"limit": "${limitCount ?? ''}", "page": "${pageCount ?? ''}"};
  var res = await http.post(Uri.parse(Urls.preFiestasPostsUrl),
      body: body, headers: headers);

  // print(res.body);

  if (res.statusCode == 401) {
    userSessionExpired(context);
  }

  if (res.statusCode == 200) {
    return prefiestasModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in prefiestas");
  } else {
    print("error in api -------------------");
  }
}

Future<PrefiestasDetailModel?> prefiestasDetailApi({
  String? id,
}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  Map body = {"id": id, "categories": "0"};
  var res = await http.post(Uri.parse(Urls.preFiestachildlistUrl),
      body: body, headers: headers);

  // print(res.body);

  if (res.statusCode == 200) {
    return prefiestasDetailModelFromJson(res.body);
  } else {
    print("ERRRO IN THE API in prefiestas child");
  }
}

Future<PrefiestasAlMxExModel?> prefiestasAlMxExApi(
    {String? id, String? categoriesName}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  Map body = {"id": id, "categories": categoriesName};
  var res = await http.post(Uri.parse(Urls.preFiestachildlistUrl),
      body: body, headers: headers);

  // print(res.body);

  if (res.statusCode == 200) {
    return prefiestasAlMxExModelFromJson(res.body);
  } else {
    print("ERRRO IN THE API in prefiestas child");
  }
}

// favourite api

Future fiestasAddfavouriteApi({
  String? id,
}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };
  Map body = {"fiesta_id": id};

  var res = await http.post(Uri.parse(Urls.fiestasAddfavoriteUrl),
      body: body, headers: headers);

  // print(res.body);

  var response = json.decode(res.body);

  return response;
}

//

Future prefiestasAddfavouriteApi({
  String? id,
}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };
  Map body = {"pre_fiesta_id": id};

  var res = await http.post(Uri.parse(Urls.preFiestasAddfavoriteUrl),
      body: body, headers: headers);

  // print(res.body);

  var response = json.decode(res.body);

  return response;
}

// favourite list fiestas

Future<FiestasFavouriteModel?> fiestasFavouriteListApi({int? pageCount}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {"limit": "3", "page": "${pageCount ?? ''}", "sort_by": "desc"};

  var res = await http.post(Uri.parse(Urls.fiestasfavoriteListUrl),
      body: body, headers: headers);

  // print(res.body);

  if (res.statusCode == 200) {
    try {
      return fiestasFavouriteModelFromJson(res.body);
    } catch (e) {
      print(e);
      return null;
    }
  } else {
    print(res.body);
  }
}

// favourite list prefiestas

Future<PrefiestasFavouriteModel?> prefiestasFavouriteListApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res = await http.post(Uri.parse(Urls.preFiestasfavoriteListUrl),
      headers: headers);

  // print(res.body);

  if (res.statusCode == 200) {
    try {
      return prefiestasFavouriteModelFromJson(res.body);
    } catch (e) {
      print('Here is p error $e');
      return null;
    }
  } else {
    print(res.body);
  }
}

// help Api

// favourite list prefiestas

Future<String?> helpApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res = await http.get(
    Uri.parse(Urls.termsandconditionsUrl),
  );

  // print(res.body);

  var response = jsonDecode(res.body);

  if (res.statusCode == 200) {
    return response["data"]["config"];
  } else {
    print(res.body);

    return "false";
  }
}

Future<String?> privacypol() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res = await http.get(
    Uri.parse(Urls.privacyPolUrl),
  );

  // print(res.body);

  var response = jsonDecode(res.body);

  if (res.statusCode == 200) {
    return response["data"]["config"];
  } else {
    print(res.body);

    return "false";
  }
}
// about us Api

Future<String?> aboutApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    // 'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res = await http.get(
    Uri.parse(Urls.aboutUsUrl),
  );

  // print(res.body);

  var reponse = jsonDecode(res.body);

  if (res.statusCode == 200) {
    return reponse["data"]["config"];
  } else {
    print(res.body);

    return "false";
  }
}

// notification on off api

Future<bool?> notificationOffApi({int? notificationNum}) async {
  // print("notiBoolNum $notificationNum");
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {"is_notify": "$notificationNum"};

  var res = await http.post(
      Uri.parse(
        Urls.notificationonOffUrl,
      ),
      body: body,
      headers: headers);

  var response = jsonDecode(res.body);

  // print("here is ${response["data"]}");

  bool notif = response["data"]["user"]["is_notify"] == "1" ? true : false;

  Constants.prefs?.setBool("notif", notif);

  if (res.statusCode == 201) {
    return notif;
  } else {
    print(res.body);
  }
}

// notification List api

// NotificationListModel?

Future notificatiListApi({int? notificationNum, int? pageCount}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {"limit": "10", "page": "${pageCount ?? ''}"};

  var res = await http.post(
      Uri.parse(
        Urls.notificationUrl,
      ),
      body: body,
      headers: headers);

  // print(res.body);

  var jsonData = json.decode(res.body);

  if (res.statusCode == 200) {
    return jsonData;

    // return notificationListModelFromJson(res.body);
  } else {
    // print(res.body);
  }
}

//fiestas filter List api

Future<FliterListModel?> filterList() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res = await http.get(
      Uri.parse(
        Urls.fiestasfilterUrl,
      ),
      headers: headers);

  // print(res.body);

  if (res.statusCode == 200) {
    return fliterListModelFromJson(res.body);
  } else {
    print(res.body);
  }
}

//payment config

Future paymentconfigApi({context}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res = await http.get(
      Uri.parse(
        Urls.paymentConfig,
      ),
      headers: headers);

  // print(res.body);
  try {
    if (res.statusCode == 200) {
      var paymentRes = json.decode(res.body);

      print("Euro ${paymentRes["data"]}");

      Strings.euro = paymentRes["data"]["currency_symbol"].toString();

      Strings.publishKey = paymentRes["data"]["public_key"].toString();

      Strings.androidPayMode = paymentRes["data"]["payment_mode"].toString();

      Strings.prefiestaMinimumBookingPrice =
          paymentRes["data"]["prefiesta_minimum_booking_price"].toString();

      Strings.fiestaBasicTicketBookingCharge =
          paymentRes["data"]["fiesta_basic_ticket_booking_charge"].toString();

      Strings.fiestaStandardTicketBookingCharge = paymentRes["data"]
              ["fiesta_standard_ticket_booking_charge"]
          .toString();

      Strings.fiestaVipTicketBookingCharge =
          paymentRes["data"]["fiesta_vip_ticket_booking_charge"].toString();

      Strings.fiestaTransferCharge =
          paymentRes["data"]["fiesta_transfer_charge"].toString();

      Strings.prefiestaTransferCharge =
          paymentRes["data"]["prefiesta_transfer_charge"].toString();

      return true;
    } else {
      print("Error is here in Config........");

      Dialogs.simpleOkAlertDialog(
          context: context,
          title: "Erro!",
          content: "Server Config Error. Please Reset App",
          func: () {
            exit(0);
          });
    }
  } catch (e) {
    print("Error is here in Config........");
    Dialogs.simpleOkAlertDialog(
        context: context,
        title: "Erro!",
        content: "Server Config Error. Please Reset App",
        func: () {
          exit(0);
        });
  }
}
