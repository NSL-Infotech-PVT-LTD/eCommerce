import 'package:flutter/material.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/strings.dart';

class Dialogs {
  static simpledialogshow(
      {context, String? title, String? description, okfunc}) {
    var size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title.toString(),
            style: TextStyle(
                fontFamily: Fonts.dmSansBold, fontSize: size.width * 0.065),
          ),
          content: Text(description.toString(),
              style: TextStyle(
                  fontFamily: Fonts.dmSansMedium,
                  fontSize: size.width * 0.045)),
          actions: [
            MaterialButton(
              onPressed: () {
                okfunc();
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
