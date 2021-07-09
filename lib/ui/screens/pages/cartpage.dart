import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
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
    return Scaffold(
        backgroundColor: HexColor("#191512"), body: ordernow(context));
  }
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
                        Strings.mycart,
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
                    Strings.nothingshowincartrightnow,
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
                Strings.buyFiestasandPreFiestasbestdealsinyourcart,
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
                    Strings.orderNow,
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
