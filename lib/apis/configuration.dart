import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

class Configurations {
  static termsofservice() async {
    var headers = {
      'Authorization': 'Bearer ${UserData.userToken}',
      'X-localization': '${Constants.prefs?.getString("language")}'
    };
    var res =
        await http.get(Uri.parse(Urls.termsandconditionsUrl), headers: headers);

    var response = json.decode(res.body);

    if (response["status"] == true && response["code"] == 200) {
      UserData.termsofservice = response["data"]["config"];

      // print(response);
    } else {
      UserData.termsofservice = "no data";
    }
  }

  static privacypolicy() async {
    var res = await http.get(Uri.parse(Urls.privacypolicyUrl));

    var response = json.decode(res.body);

    if (response["status"] == true && response["code"] == 200) {
      UserData.privacypolicy = response["data"]["config"];
      // print(response);
    } else {
      UserData.privacypolicy = "no data";
    }
  }
}
