import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/userModel.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<bool> signApiCall(
    {String? fullname,
    String? email,
    String? password,
    String? dob,
    String? gender,
    String? devicetype}) async {
  var body = {
    "name": fullname,
    "email": email,
    "password": password,
    "dob": dob,
    "gender": gender,
    "device_token": "test",
    "device_type": devicetype
  };

  var res = await http.post(Uri.parse(Urls.signUpUrl), body: body);

  var response = json.decode(res.body);
  print(response);

  if (response["status"] == true && response["code"] == 201) {
    // Iterable userdata = response["data"];

    Constants.prefs?.setString("token", response["data"]['token']);

    print(response["data"]);

    // UserDataM.user =
    //     userdata.map((model) => UserModel.fromJson(model)).toList();

    return true;
  }

  return false;
}
