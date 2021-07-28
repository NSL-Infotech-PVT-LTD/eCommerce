import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';

Widget inputs(
    {context,
    controller,
    obscureTextBool,
    String? titletxt,
    String? hinttxt,
    String? inputError,
    readonly,
    ontapFun
    }) {
  var size = MediaQuery.of(context).size;

  return Container(
    // width: size.width * 0.78,
    margin: EdgeInsets.only(top: size.height * 0.015),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titletxt.toString(),
          style: TextStyle(
              fontFamily: Fonts.dmSansMedium,
              fontSize: size.width * 0.04,
              // fontWeight: FontWeight.w500,
              color: AppColors.inputTitle),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        roundedBox(
          // width: size.width * 0.78,
          width: size.width,
          height: size.height * 0.058,
          backgroundColor: AppColors.inputbackgroung,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            child: Align(
              alignment: Alignment.center,
              child: TextField(
                readOnly: readonly,
                onTap: () {
                  if (ontapFun != null) {
                    ontapFun(context);
                  }
                },
                obscureText: obscureTextBool,
                controller: controller,
                style: TextStyle(
                  fontFamily: Fonts.dmSansRegular,
                  color: AppColors.inputHint,
                ),
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColors.white,
                decoration: InputDecoration(
                  hintText: hinttxt,
                  border: InputBorder.none,
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: size.height * 0.000001),
                  // contentPadding: EdgeInsets.only(

                  //     left: size.width * 0.04, right: size.width * 0.04
                  //     ),
                  hintStyle: TextStyle(
                      color: AppColors.inputHint, fontSize: size.width * 0.04),
                ),
              ),
            ),
          ),
        ),

        // error text
        inputError != ""
            ? Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  inputError.toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: Fonts.dmSansMedium,
                      fontSize: size.width * 0.035),
                ))
            : SizedBox()
      ],
    ),
  );
}

Widget inputstype2(
    {context,
    controller,
    obscureTextBool,
    String? titletxt,
    String? hinttxt,
    String? inputError,
    readonly,
    height,
    ontapFun}) {
  var size = MediaQuery.of(context).size;

  return Container(
    // width: size.width * 0.78,
    margin: EdgeInsets.only(top: size.height * 0.015),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titletxt.toString(),
          style: TextStyle(
              fontFamily: Fonts.dmSansMedium,
              fontSize: size.width * 0.04,
              // fontWeight: FontWeight.w500,
              color: AppColors.inputTitle),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        roundedBox(
          // width: size.width * 0.78,
          width: size.width,
          height: height,
          backgroundColor: AppColors.inputbackgroung,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: TextField(
              readOnly: readonly,
              onTap: () {
                if (ontapFun != null) {
                  ontapFun(context);
                }
              },
              obscureText: obscureTextBool,
              controller: controller,
              style: TextStyle(
                fontFamily: Fonts.dmSansRegular,
                color: AppColors.inputHint,
              ),
              keyboardType: TextInputType.emailAddress,
              cursorColor: AppColors.white,
              decoration: InputDecoration(
                hintText: hinttxt,
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(
                //     left: size.width * 0.04, right: size.width * 0.04),
                hintStyle: TextStyle(
                    color: AppColors.inputHint, fontSize: size.width * 0.04),
              ),
            ),
          ),
        ),

        // error text
        inputError != ""
            ? Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  inputError.toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: Fonts.dmSansMedium,
                      fontSize: size.width * 0.035),
                ))
            : SizedBox()
      ],
    ),
  );
}
