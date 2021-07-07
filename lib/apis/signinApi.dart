import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/models/facebookSigninModel.dart';
import 'package:funfy/models/userModel.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/strings.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<UserModel?> signinUser(
    {String? email, String? password, String? devicetype}) async {
  String _token = "test";
  var body = {
    "email": email,
    "password": password,
    "device_type": devicetype,
    "device_token": _token
  };
  var res = await http.post(Uri.parse(Urls.siginUrl), body: body);

  // var response = json.decode(res.body);

  if (res.statusCode == 200) {
    return userModelFromJson(res.body);
  } else {
    print(res.body);
  }
}

Future<FacebookSigninModel?> facebookLogin(
    {String? name,
    String? email,
    String? fbId,
    String? deviceType,
    String? deviceToken,
    String? profileImage}) async {
  var body = {
    "name": name,
    "email": email,
    "fb_id": fbId,
    "device_type": deviceType,
    "device_token": deviceToken,
    "image": profileImage
  };

  var res = await http.post(Uri.parse(Urls.faceBookSigninUrl), body: body);
  var jsondata = json.decode(res.body);
  print(jsondata["data"]["user"]);
  // var model = facebookSigninModelFromJson(res.body);

  // print(model.data?.user?.name);

  if (res.statusCode == 201) {
    return facebookSigninModelFromJson(res.body);
  } else if (res.statusCode == 200) {
    return facebookSigninModelFromJson(res.body);
  } else {
    print("Error in Facebook signin Api");
  }
}

saveDataInshareP({String? name, String? email, String? token}) {
  // token
  Constants.prefs?.setString("token", "$token");
  // name name
  Constants.prefs?.setString("name", "$name");
  // name email
  Constants.prefs?.setString("email", "$email");
}

logout(context) {
  Dialogs.simpleAlertDialog(
      context: context,
      title: Strings.alert,
      content: Strings.areYousureWantToLogout,
      func: () {
        // token
        Constants.prefs?.setString("token", "");
        // name name
        Constants.prefs?.setString("name", "");
        // name email
        Constants.prefs?.setString("email", "");
        // lacation
        Constants.prefs?.setString("addres", "");

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Signin()));
      });
}
