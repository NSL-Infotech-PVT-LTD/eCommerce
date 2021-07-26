import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/screens/bookingSuccess.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:hexcolor/hexcolor.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  bool _isVertical = false;

  double containerEdge = 07;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        appBar: AppBar(
          backgroundColor: AppColors.homeBackground,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.homeBackgroundLite,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      // AppColors.homeBackgroundLite,
                      HexColor("#3d322a"),
                      HexColor("#1a1613")
                      // Colors.transparent
                    ], // red to yellow
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
                height: size.height,
              ),
              Positioned(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // top content
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgicons/cartsvg.svg",
                              width: size.width * 0.07,
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.03,
                            ),
                            Text(
                              "${getTranslated(context, "yourCart")}",
                         //     Strings.yourCart,
                              style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  fontFamily: Fonts.dmSansMedium,
                                  color: AppColors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.brownLite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: SizeConfig.screenHeight * 0.10,
                          width: SizeConfig.screenWidth,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.01,
                                horizontal: size.width * 0.03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //  mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ticket.svg",
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.03,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                        //"Ticket",
                                        "${getTranslated(context, "Ticket")}",
                                        style: TextStyle(
                                            fontSize: size.width * 0.045,
                                            fontFamily: Fonts.dmSansMedium,
                                            color: AppColors.white)),
                                    Text(
                                        //"Qty:2",
                                        "${getTranslated(context, "Qty")}",
                                        style: TextStyle(
                                            fontSize: size.width * 0.045,
                                            fontFamily: Fonts.dmSansMedium,
                                            color: AppColors.white)),
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.02,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text("€ 29.99",
                                    style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontFamily: Fonts.dmSansMedium,
                                        color: AppColors.white))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          //"Payment",
                          "${getTranslated(context, "Payment")}",
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontFamily: Fonts.dmSansMedium,
                              color: AppColors.white)),
                      Container(
                          height: SizeConfig.screenHeight * 0.90,
                          width: SizeConfig.screenWidth * 0.90,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: SizeConfig.screenWidth * 0.02,
                              top: SizeConfig.screenHeight * 0.03,
                              left: SizeConfig.screenWidth * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth * 80,
                                  color: AppColors.homeBackgroundLite,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.02,
                                        right: SizeConfig.screenWidth * 0.02,
                                        top: SizeConfig.screenHeight * 0.03),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/icons/card.svg"),
                                            SizedBox(
                                              width:
                                                  SizeConfig.screenWidth * 0.04,
                                            ),
                                            Text(
                                                "${getTranslated(context, "AddCreditDebitCard")}",
                                           //     "Add Credit / Debit Card",
                                                style: TextStyle(
                                                    fontSize:
                                                        size.width * 0.045,
                                                    fontFamily:
                                                        Fonts.dmSansMedium,
                                                    color: AppColors.white))
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.03,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.homeBackground,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        containerEdge))),
                                            child: Padding(
                                                padding: EdgeInsets.all(17),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            size.width * 0.045,
                                                        fontFamily:
                                                            Fonts.dmSansMedium,
                                                        color: AppColors
                                                            .inputHint),
                                                    hintText:
                                                        "Card Holder's Name",
                                                  ),
                                                ))),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.02,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.homeBackground,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        containerEdge))),
                                            child: Padding(
                                                padding: EdgeInsets.all(17),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          fontSize: size.width *
                                                              0.045,
                                                          fontFamily: Fonts
                                                              .dmSansMedium,
                                                          color: AppColors
                                                              .inputHint),
                                                      hintText: "Card Number"),
                                                ))),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.02,
                                        ),
                                        Text(
                                            "${getTranslated(context, "ExpireDate")}",
                                          //  "Expire Date",
                                            style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                fontFamily: Fonts.dmSansMedium,
                                                color: AppColors.white)),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .homeBackground,
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            containerEdge))),
                                                child: Padding(
                                                  padding: EdgeInsets.all(17),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        hintStyle: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    0.045,
                                                            fontFamily: Fonts
                                                                .dmSansMedium,
                                                            color: AppColors
                                                                .inputHint),
                                                        hintText: "Month"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.screenWidth * 0.03,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .homeBackground,
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            containerEdge))),
                                                child: Padding(
                                                  padding: EdgeInsets.all(17),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        hintStyle: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    0.045,
                                                            fontFamily: Fonts
                                                                .dmSansMedium,
                                                            color: AppColors
                                                                .inputHint),
                                                        hintText: "Year"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.02,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth * 0.45,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.homeBackground,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        containerEdge))),
                                            child: Padding(
                                              padding: EdgeInsets.all(17),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      fontSize:
                                                          size.width * 0.045,
                                                      fontFamily:
                                                          Fonts.dmSansMedium,
                                                      color:
                                                          AppColors.inputHint),
                                                  hintText: "Security Code",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.04,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.04,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: SizeConfig.screenWidth * 0.90,
                                    child: ElevatedButton(
                                      child: Text(
                                        "${getTranslated(context, "Swipetopay")}",
                                       // 'Swipe to pay',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        navigatorPushFun( context, BookingSuccess());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.screenWidth * 0.06,
                                            vertical:
                                                SizeConfig.screenHeight * 0.02),
                                        primary: AppColors.redlite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ))
            ])
          ]),
        ));
  }
}
