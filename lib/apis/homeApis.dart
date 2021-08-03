import 'dart:convert';
import 'dart:io';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/favourite/fiestasFavouriteModel.dart';
import 'package:funfy/models/favourite/preFiestasFavModel.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/models/prefiestasDetailModel.dart';
import 'package:funfy/models/prifiestasAlMxEx.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<FiestasModel?> fiestasPostGet({String? type, String? dateFilter}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {
    type == null ? "" : "type": "$type",
    dateFilter == null || dateFilter == "" ? "" : "filter": "$dateFilter"
  };

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
  };
  var res =
      await http.post(Uri.parse(Urls.preFiestasPostsUrl), headers: headers);

  // print(res.body);

  if (res.statusCode == 200) {
    return prefiestasModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in prefiestas");
  }
}

Future<PrefiestasDetailModel?> prefiestasDetailApi({
  String? id,
}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
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
  Map body = {"club_id": id};

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

Future<FiestasModel?> fiestasFavouriteListApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var res =
      await http.post(Uri.parse(Urls.fiestasfavoriteListUrl), headers: headers);

  // print(res.body);

  FiestasModel response = fiestasModelFromJson(res.body);

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


// getcart 

