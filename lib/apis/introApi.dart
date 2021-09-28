import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/introModel.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

List<IntroModel> introdata = [];

Future<List<IntroModel>> getIntrodata() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };
  var res = await http.get(Uri.parse(Urls.introUrl), headers: headers);

  try {
    var response = json.decode(res.body);

    if (response["status"] == true && response["code"] == 200) {
      Iterable itresponse = response["data"];

      introdata =
          itresponse.map((model) => IntroModel.fromJson(model)).toList();

      return introdata;
    }
  } catch (e) {
    print(e);
    return introdata;
  }

  return introdata;
}
