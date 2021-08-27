import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/favourite/fiestasFavouriteModel.dart';
import 'package:funfy/models/favourite/preFiestasFavModel.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/notificationListModel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/models/prefiestasDetailModel.dart';
import 'package:funfy/models/prifiestasAlMxEx.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<FiestasModel?> fiestasPostGet({String? type, String? dateFilter}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var body = {
    type == null ? "" : "type": "$type",
    dateFilter == null || dateFilter == "" ? "" : "filter": "$dateFilter"
  };

  // print("here is body : $body");

  // print("Token" + "${UserData.userToken}");
  var res = await http.post(Uri.parse(Urls.fiestasPostUrl),
      body: body, headers: headers);

  // print(res.body);

  if (res.statusCode == 200) {
    return fiestasModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in fiestas");
  }
}

Future<PrefiestasModel?> prefiestasPostGet() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };
  var res =
      await http.post(Uri.parse(Urls.preFiestasPostsUrl), headers: headers);

  // print(res.body);

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

Future<FiestasFavouriteModel?> fiestasFavouriteListApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res =
      await http.post(Uri.parse(Urls.fiestasfavoriteListUrl), headers: headers);

  // print(res.body);

  var response = fiestasFavouriteModelFromJson(res.body);

  if (res.statusCode == 200) {
    return response;
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

  PrefiestasFavouriteModel response =
      prefiestasFavouriteModelFromJson(res.body);

  if (res.statusCode == 200) {
    return response;
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
    Uri.parse(Urls.helpUrl),
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

  print(res.body);

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
  print("notiBoolNum $notificationNum");
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

  print("here is ${response["data"]}");

  bool notif = response["data"]["user"]["is_notify"] == "1" ? true : false;

  Constants.prefs?.setBool("notif", notif);

  if (res.statusCode == 201) {
    return notif;
  } else {
    print(res.body);
  }
}

// notification List api

Future<NotificationListModel?> notificatiListApi({int? notificationNum}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    //  'X-localization': '${Constants.prefs?.getString("language")}'
  };

  var res = await http.post(
      Uri.parse(
        Urls.notificationUrl,
      ),
      headers: headers);

  print(res.body);

  if (res.statusCode == 200) {
    return notificationListModelFromJson(res.body);
  } else {
    print(res.body);
  }
}
