import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

class Configurations {
  static termsofservice() async {
    var res = await http.get(Uri.parse(Urls.termsandconditionsUrl));

    var response = json.decode(res.body);

    if (response["status"] == true && response["code"] == 200) {
      UserDataM.termsofservice = response["data"]["config"];

      print(response);
    } else {
      UserDataM.termsofservice = "no data";
    }
  }

  static privacypolicy() async {
    var res = await http.get(Uri.parse(Urls.privacypolicyUrl));

    var response = json.decode(res.body);

    if (response["status"] == true && response["code"] == 200) {
      UserDataM.privacypolicy = response["data"]["config"];
      print(response);
    } else {
      UserDataM.privacypolicy = "no data";
    }
  }
}
