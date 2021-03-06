import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/facebookSigninModel.dart';
import 'package:funfy/models/googleSigninModel.dart';
import 'package:funfy/models/userModel.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/screens/languageScreen.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:funfy/utils/urls.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',

    // you can add extras if you require
  ],
);

Future<UserModel?> signinUser(
    {String? email, String? password, String? devicetype, context}) async {
  String _token = "test";
  var body = {
    "email": email,
    "password": password,
    "device_type": devicetype,
    "device_token": UserData.deviceToken
  };

  print("here is device type : $devicetype");
  var res = await http.post(Uri.parse(Urls.siginUrl), body: body);

  var data = json.decode(res.body);

  if (res.statusCode == 200) {
    return userModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    Dialogs.simpleOkAlertDialog(
        context: context,
        title: "${getTranslated(context, 'alert!')}",
        content: "${data['error']}",
        func: () {
          navigatePopFun(context);
        });
  } else {
    print(res.body);
  }
}

Future<FacebookSigninModel?> facebookLogin(
    {context,
    String? name,
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
    "device_token": UserData.deviceToken,
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
  } else if (res.statusCode == 422) {
    Dialogs.simpleOkAlertDialog(
        context: context,
        title: "${getTranslated(context, 'alert!')}",
        content: "${jsondata['error']}",
        func: () {
          navigatePopFun(context);
        });
  } else {
    print("Error in Facebook signin Api");
  }
}

Future<GoogleSigninModel?> googleLogin(
    {context,
    String? name,
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
    "device_token": UserData.deviceToken,
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
  } else if (res.statusCode == 422) {
    Dialogs.simpleOkAlertDialog(
        context: context,
        title: "${getTranslated(context, 'alert!')}",
        content: "${jsondata['error']}",
        func: () {
          navigatePopFun(context);
        });
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
      content:
          "${getTranslated(context, "areYousureWantToLogout")}", //Strings.areYousureWantToLogout,
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
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    TranslationPage(fromSplash: true)

                //  Signin()

                ),
            (route) => false);
      });
}

// logout api

Future<bool?> logoutApi() async {
  var dToken = Constants.prefs?.getString("fToken");

  print("here is device token : $dToken");

  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };
  var body = {
    "device_token": "$dToken",
    "device_type": Platform.isAndroid ? 'android' : 'ios'
  };

  var res =
      await http.post(Uri.parse(Urls.logoutUrl), body: body, headers: headers);
  var jsondata = json.decode(res.body);

  if (res.statusCode == 200) {
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

    // language
    Constants.prefs?.setString(Strings.radioValue, 'en');

    Constants.prefs?.setString('es', 'null');

    //  social
    Constants.prefs?.setString("social", "false");

    // profileImage
    Constants.prefs?.setString("profileImage", "");

    _googleSignIn.signOut();
    return true;
  } else {
    print(jsondata);
  }
}

// 401

userSessionExpired(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("${getTranslated(context, 'alert!')}"),
        content: new Text("${getTranslated(context, 'theSessionhasexpired')}"),
      );
    },
  );

  Future.delayed(Duration(seconds: 3), () {
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

    // language
    // Constants.prefs?.setString(Strings.radioValue, 'null');

    // Constants.prefs?.setString('es', 'null');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Signin()), (route) => false);
  });
}
