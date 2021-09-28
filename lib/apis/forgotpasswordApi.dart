import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<bool> forgotpasswordApiCall({String? email}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
    'X-localization': '${Constants.prefs?.getString("language")}'
  };
  var body = {"email": email};

  var res = await http.post(Uri.parse(Urls.forgotpasswordUrl),
      headers: headers, body: body);

  var response = json.decode(res.body);

  if (response["status"] == true && response["code"] == 201) {
    return true;
  }

  return false;
}
