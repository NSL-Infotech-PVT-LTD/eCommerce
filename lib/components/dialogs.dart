import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';
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
              child: Text("${getTranslated(context, "ok")}",
                  //   Strings.ok,
                  style: TextStyle(
                      fontFamily: Fonts.dmSansMedium,
                      fontSize: size.width * 0.05)),
            ),
          ],
        );
      },
    );
  }

  static simpleAlertDialog({context, String? title, String? content, func}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title.toString()),
          content: new Text(content.toString()),
          actions: <Widget>[
            TextButton(
              child: new Text("${getTranslated(context, "no")}"
                  //Strings.no
                  ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: new Text("${getTranslated(context, "yes")}"
                    //  Strings.yes
                    ),
                onPressed: func),
          ],
        );
      },
    );
  }

  static simpleOkAlertDialog({context, String? title, String? content, func}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title.toString()),
          content: new Text(content.toString()),
          actions: <Widget>[
            TextButton(
              child: new Text("${getTranslated(context, "ok")}"
                  //  Strings.yes
                  ),
              onPressed: () {
                func();
              },
            ),
          ],
        );
      },
    );
  }

  static showBasicsFlash(
      {context,
      Duration? duration,
      flashStyle = FlashBehavior.floating,
      String? content,
      Color? color}) {
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          backgroundColor: color == null ? AppColors.blackBackground : color,
          behavior: flashStyle,
          position: FlashPosition.bottom,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text(
              '$content',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        );
      },
    );
  }
}
