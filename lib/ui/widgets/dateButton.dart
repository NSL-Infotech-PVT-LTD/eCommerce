import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/strings.dart';

Widget dateButton(
    {context,
      text,
      month,
      textColor,
      borderwidth,
      backgroundColor,
      borderColor}) {
  var size = MediaQuery.of(context).size;

  return roundedBoxBorder(
      context: context,
      borderSize: borderwidth,
      width: size.width * 0.12,
      height: size.height * 0.06,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.width * 0.01),
        alignment: Alignment.center,
        child: Container(
          height: size.height * 0.052,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: size.width * 0.044,
                      fontFamily: Fonts.dmSansBold,
                      color: textColor),
                ),
              ),
              Text(
                month,
                style: TextStyle(
                    fontSize: size.width * 0.027,
                    fontFamily: Fonts.dmSansMedium,
                    color: textColor),
              ),
            ],
          ),
        ),
      ));
}
