import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/models/addressLsitModel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<bool?> addAddressApi(
    {String? addresname,
    String? street,
    String? city,
    String? state,
    String? zip,
    String? country,
    String? latitude,
    String? longitude}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  Map body = {
    "name": "$addresname",
    "street_address": "$street",
    "city": "$city",
    "state": "$state",
    "zip": "$zip",
    "country": "$country",
    "latitude": "$latitude",
    "longitude": "$longitude"
  };
  var res = await http.post(Uri.parse(Urls.addresscreateUrl),
      headers: headers, body: body);

  print("add Address body ${res.body}");

  var jsonRes = json.decode(res.body);

  if (res.statusCode == 201) {
    print(jsonRes);
    Constants.prefs?.setString("addres",
        "${jsonRes['data']['address']['street_address']}, ${jsonRes['data']['address']['city']}, ${jsonRes['data']['address']['state']}, ${jsonRes['data']['address']['country']}");

    Constants.prefs
        ?.setString("addressId", "${jsonRes['data']['address']['id']}");
    return true;
  } else {
    return false;
    // Dialogs.showBasicsFlash(
    //     context: context,
    //     color: AppColors.siginbackgrond,
    //     duration: Duration(seconds: 1),
    //     content: "Error ");
  }
}

Future<AddressListModel?> getAddressList() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var res = await http.get(
    Uri.parse(Urls.addressListUrl),
    headers: headers,
  );

  // print(res.body);

  if (res.statusCode == 200) {
    return addressListModelFromJson(res.body);
  } else {
    return null;
  }
}

Future<bool?> updateaddAddressApi(
    {String? id,
    String? addresname,
    String? street,
    String? city,
    String? state,
    String? zip,
    String? country,
    String? latitude,
    String? longitude}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  Map body = {
    "id": "$id",
    "name": "$addresname",
    "street_address": "$street",
    "city": "$city",
    "state": "$state",
    "zip": "$zip",
    "country": "$country",
    "latitude": "$latitude",
    "longitude": "$longitude"
  };
  var res = await http.post(Uri.parse(Urls.addressUpadteUrl),
      headers: headers, body: body);

  // print(res.body);

  var jsonRes = json.decode(res.body);

  if (res.statusCode == 201) {
    Constants.prefs?.setString("addres",
        "${jsonRes['data']['address']['street_address']}, ${jsonRes['data']['address']['city']}, ${jsonRes['data']['address']['state']}, ${jsonRes['data']['address']['country']}");

    Constants.prefs
        ?.setString("addressId", "${jsonRes['data']['address']['id']}");
    return true;
  } else {
    return false;
  }
}

Future<bool?> deleteAddress({
  String? id,
}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  Map body = {
    "id": "$id",
  };
  var res = await http.post(Uri.parse(Urls.addressDeleteUrl),
      headers: headers, body: body);

  print(res.body);

  if (res.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<String?> checkValidZipApi({String? zipcode}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };

  Map body = {
    "zip": "${zipcode ?? ''}",
  };
  var res = await http.post(Uri.parse(Urls.zipCodeChackUrl),
      headers: headers, body: body);

  var jsonRes = json.decode(res.body);

  print(res.body);

  if (res.statusCode == 200) {
    return "true";
  } else if (res.statusCode == 422) {
    return "${jsonRes["error"]}";
  }
}
