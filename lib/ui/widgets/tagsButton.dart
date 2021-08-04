import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';

Widget tagbutton({context, text, borderColor, borderwidth}) {
  var size = MediaQuery.of(context).size;

  return Padding(
    padding: EdgeInsets.only(left: size.width * 0.025),
    child: roundedBoxBorder(
        // width: size.width * 0.05,
        context: context,
        borderSize: borderwidth,
        height: size.height * 0.04,
        backgroundColor: AppColors.homeBackground,
        borderColor: borderColor,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontFamily: Fonts.dmSansMedium,
                    color: AppColors.white),
              ),
              Icon(
                Icons.close,
                size: size.width * 0.04,
                color: AppColors.white,
              )
            ],
          ),
        )),
  );
}

Widget tagbutton2({context, text, textColor, borderColor, borderwidth}) {
  var size = MediaQuery.of(context).size;

  return roundedBoxBorder(
      // width: size.width * 0.05,
      context: context,
      borderSize: borderwidth,
      height: size.height * 0.04,
      backgroundColor: AppColors.homeBackground,
      borderColor: borderColor,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
        ), // vertical: size.height * 0.01),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: Fonts.dmSansMedium,
              color: textColor),
        ),
      ));
}
