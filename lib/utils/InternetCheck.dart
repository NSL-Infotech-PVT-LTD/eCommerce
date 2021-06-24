import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/strings.dart';

class Internetcheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static showdialog({context}) {
    var size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Strings.unabletoconnect,
            style: TextStyle(
                fontFamily: Fonts.dmSansBold, fontSize: size.width * 0.065),
          ),
          content: Text(Strings.pleaseCheckYourInternet,
              style: TextStyle(
                  fontFamily: Fonts.dmSansMedium,
                  fontSize: size.width * 0.045)),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(Strings.ok,
                  style: TextStyle(
                      fontFamily: Fonts.dmSansMedium,
                      fontSize: size.width * 0.05)),
            ),
          ],
        );
      },
    );
  }
}
