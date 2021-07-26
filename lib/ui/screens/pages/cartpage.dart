import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../utils/strings.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({Key? key}) : super(key: key);
  @override
  _CartpageState createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.blackBackground,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: HexColor("#191512"),
            body: SingleChildScrollView(
              child: Column(children: [
                // top bar
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.023,
                        horizontal: size.width * 0.06),
                    width: size.width,
                    height: size.height * 0.155,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.homeTopBannerPng),
                            fit: BoxFit.cover)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${getTranslated(context, "mycart")}",
                              //Strings.mycart,
                              style: TextStyle(
                                  fontFamily: Fonts.dmSansBold,
                                  color: AppColors.white,
                                  fontSize: size.width * 0.065),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.70,
                              ),
                              child: Text(
                                "${getTranslated(context, "checkyourdeliverableordersstatus")}",
                                //Strings.checkyourdeliverableordersstatus,
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansRegular,
                                    color: AppColors.white,
                                    fontSize: size.width * 0.036),
                              ),
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          Images.cartIconUnActSvg,
                          width: size.width * 0.07,
                        ),
                      ],
                    )),
                SizedBox(
                  height: size.height * 0.03,
                ),
                // center content
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  width: size.width,
                  child: Column(
                    children: [
                      roundedBoxBorder(
                          context: context,
                          width: size.width,
                          // height: size.height * 0.58,
                          borderColor: AppColors.tagBorder,
                          backgroundColor: AppColors.homeBackgroundLite,
                          borderSize: size.width * 0.002,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                                vertical: size.height * 0.015),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Pack 'La havanna",
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontFamily: Fonts.dmSansBold,
                                                fontSize: size.width * 0.055),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.008,
                                          ),
                                          Text(
                                            "${getTranslated(context, "lorem")}",
                                            //Strings.lorem,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontFamily: Fonts.dmSansRegular,
                                                fontSize: size.width * 0.035),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                        height: size.height * 0.09,
                                        child:
                                            Image.network(Images.beer2nettwork))
                                  ],
                                ),

                                // items
                                SizedBox(
                                  height: size.height * 0.035,
                                ),
                                listItem(size: size,context: context),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                listItem(size: size, boolCount: true,context: context),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                listItem(size: size, boolCount: true,context: context),
                              ],
                            ),
                          )),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          "${getTranslated(context, "thisisFinalstepafteryouTouchingpaynowbuttonthepaymentwillbetransation")}",
                          // Strings.thisisFinalstepafteryouTouchingpaynowbuttonthepaymentwillbetransation,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.itemDescription,
                              fontFamily: Fonts.dmSansRegular,
                              fontSize: size.width * 0.03)),
                      SizedBox(height: size.height * 0.03),

                      // button
                      roundedBoxR(
                        width: size.width,
                        height: size.height * 0.07,
                        radius: size.width * 0.02,
                        backgroundColor: AppColors.siginbackgrond,
                        child: Center(
                          child: Text(
                            "${getTranslated(context, "proceedtopay")}",
                         //   Strings.proceedtopay,
                            style: TextStyle(
                                color: AppColors.white,
                                fontFamily: Fonts.dmSansBold,
                                fontSize: size.width * 0.045),
                          ),
                        ),
                      ),

                      //  SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ]),
            )),
      ),
    );
  }
}

Widget listItem(
    {size,
    String? topTile,
    String? title,
    String? descriptionTitle,
    bool? boolCount,
    required BuildContext context,
    }) {
  return Container(
    width: size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          //"(${Strings.alcohol})",
          "${getTranslated(context, "alcohol")}",
          style: TextStyle(
              color: AppColors.itemDescription,
              fontFamily: Fonts.dmSansRegular,
              fontSize: size.width * 0.03),
        ),
        SizedBox(
          height: size.height * 0.001,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Ron Bucanero Anejo",

                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: Fonts.dmSansBold,
                      fontSize: size.width * 0.045),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  "${getTranslated(context, "change")}",
                  //Strings.change,
                  style: TextStyle(
                      color: AppColors.siginbackgrond,
                      decoration: TextDecoration.underline,
                      fontFamily: Fonts.dmSansBold,
                      fontSize: size.width * 0.03),
                ),
              ],
            ),
            Icon(
              Icons.close,
              size: size.width * 0.06,
              color: AppColors.tagBorder,
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        Text(
          "70 CL",
          style: TextStyle(
              color: AppColors.itemDescription,
              fontFamily: Fonts.dmSansRegular,
              fontSize: size.width * 0.035),
        ),
        SizedBox(
          height: size.height * 0.003,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${getTranslated(context,'euro')}" '28.99',
              //Strings.euro + " " + "28.99",
              style: TextStyle(
                  color: AppColors.white,
                  fontFamily: Fonts.dmSansBold,
                  fontSize: size.width * 0.056),
            ),

            // + - buttons

            boolCount == null
                ? SizedBox()
                : Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: AppColors.white),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.01)),
                            ),
                            height: SizeConfig.screenHeight * 0.035,
                            width: SizeConfig.screenWidth * 0.075,
                            child: Center(
                                child: Text(
                              "-",
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: "DM Sans Medium",
                                fontSize: size.width * 0.04,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.03,
                        ),

                        // center number
                        Text(
                          "0",
                          style: TextStyle(
                              fontFamily: "DM Sans Medium",
                              fontSize: size.width * 0.04,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.skin,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.01)),
                            ),
                            height: SizeConfig.screenHeight * 0.035,
                            width: SizeConfig.screenWidth * 0.075,
                            child: Center(
                                child: Text(
                              "+",
                              style: TextStyle(
                                  fontFamily: "DM Sans Medium",
                                  fontSize: size.width * 0.04,
                                  color: AppColors.homeBackground),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ],
    ),
  );
}

Widget ordernow(context) {
  var size = MediaQuery.of(context).size;

  return Container(
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // top bar
            SafeArea(
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.023,
                      horizontal: size.width * 0.045),
                  width: size.width,
                  height: size.height * 0.155,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.homeTopBannerPng),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getTranslated(context, "mycart")}",
                      //  Strings.mycart,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white,
                            fontSize: size.width * 0.065),
                      ),
                      Text(
                        Strings.checkyourdeliverableordersstatus,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansRegular,
                            color: AppColors.white,
                            fontSize: size.width * 0.036),
                      )
                    ],
                  )),
            ),

            SizedBox(
              height: size.height * 0.15,
            ),

            // center content

            Container(
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: Image.asset(Images.appLogo),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Text(
                    "${getTranslated(context, "nothingshowincartrightnow")}",
                  //  Strings.nothingshowincartrightnow,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansBold,
                        color: AppColors.white,
                        fontSize: size.width * 0.04),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.15,
            ),

            // content
            Container(
              width: size.width * 0.6,
              child: Text(
                "${getTranslated(context, "buyFiestasandPreFiestasbestdealsinyourcart")}",
            //    Strings.buyFiestasandPreFiestasbestdealsinyourcart,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Fonts.dmSansBold,
                    color: HexColor("#7a6d62"),
                    fontSize: size.width * 0.04),
              ),
            ),

            SizedBox(
              height: size.height * 0.02,
            ),

            roundedBoxBorder(
                context: context,
                backgroundColor: HexColor("#191512"),
                width: size.width * 0.5,
                height: size.height * 0.05,
                borderColor: HexColor("#fdedba"),
                borderSize: size.width * 0.002,
                child: Align(
                  child: Text(
                    "${getTranslated(context, "orderNow")}",
                  //  Strings.orderNow,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansBold,
                        color: HexColor("#fdedba"),
                        fontSize: size.width * 0.04),
                  ),
                )),

            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ));
}
