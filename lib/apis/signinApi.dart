import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/models/facebookSigninModel.dart';
import 'package:funfy/models/googleSigninModel.dart';
import 'package:funfy/models/userModel.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:funfy/utils/urls.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',

    // you can add extras if you require
  ],
);

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
  print(jsondata);

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

Future<GoogleSigninModel?> googleLogin(
    {String? name,
    String? email,
    String? googleid,
    String? deviceType,
    String? deviceToken,
    String? profileImage}) async {
  var body = {
    "name": name,
    "email": email,
    "google_id": googleid,
    "device_type": deviceType,
    "device_token": deviceToken,
    "image": profileImage
  };
  var res = await http.post(Uri.parse(Urls.googleSiginUrl), body: body);
  var jsondata = json.decode(res.body);
  print(jsondata);

  // var model = facebookSigninModelFromJson(res.body);

  // print(model.data?.user?.name);

  if (res.statusCode == 201) {
    return googleSigninModelFromJson(res.body);
  } else if (res.statusCode == 200) {
    return googleSigninModelFromJson(res.body);
  } else {
    print("Error in Google signin Api");
  }
}

saveDataInshareP(
    {String? name,
    String? email,
    String? token,
    String? profileImage,
    String? dob,
    String? social,
    String? gender}) {
  // token
  Constants.prefs?.setString("token", "$token");
  // name name
  Constants.prefs?.setString("name", "$name");
  //  email
  Constants.prefs?.setString("email", "$email");

  //  email
  Constants.prefs?.setString("dob", "$dob");

  // profileImage
  Constants.prefs?.setString("profileImage", "$profileImage");

  //  social
  Constants.prefs?.setString("social", "$social");

  //  gender
  Constants.prefs?.setString("gender", "$gender");
}

logout(context) {
  Dialogs.simpleAlertDialog(
      context: context,
      title: "${getTranslated(context, "alert")}", // Strings.alert,
      content: "${getTranslated(context, "areYousureWantToLogout")}",//Strings.areYousureWantToLogout,
      func: () {
        // token
        Constants.prefs?.setString("token", "");
        // name name
        Constants.prefs?.setString("name", "");
        // name email
        Constants.prefs?.setString("email", "");
        // lacation
        Constants.prefs?.setString("addres", "");

        //  dob
        Constants.prefs?.setString("dob", "");

        //  gender
        Constants.prefs?.setString("gender", "");

        //  social
        Constants.prefs?.setString("social", "false");

        // profileImage
        Constants.prefs?.setString("profileImage", "");

        _googleSignIn.signOut();

        // (MaterialPageRoute(builder: (context) => Signin()));

        // Navigator.of(context).pushAndRemoveUntil(newRoute, (route) => false)

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Signin()),
            (route) => false);
      });
}
