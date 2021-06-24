import 'dart:convert';

import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<bool> forgotpasswordApiCall({String? email}) async {
  var body = {"email": email};

  var res = await http.post(Uri.parse(Urls.forgotpasswordUrl), body: body);

  var response = json.decode(res.body);

  if (response["status"] == true && response["code"] == 201) {
    return true;
  }

  return false;
}
