import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';

class BookingSuccess extends StatefulWidget {
  BookingSuccess({Key? key}) : super(key: key);

  @override
  _BookingSuccessState createState() => _BookingSuccessState();
}

class _BookingSuccessState extends State<BookingSuccess> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.17,
              ),
              Text(
                "${getTranslated(context, "bookingSuccessfull")}",
              //  Strings.bookingSuccessfull,
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: Fonts.dmSansBold,
                    fontSize: size.width * 0.08),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                  child: SvgPicture.asset(
                Images.bookingSuccessfullSvg,
                width: size.width * 0.75,
              )),
              SizedBox(
                height: size.height * 0.2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Home()),
                      (route) => false);
                },
                child: roundedBoxR(
                    backgroundColor: AppColors.siginbackgrond,
                    width: size.width * 0.88,
                    height: size.height * 0.06,
                    radius: size.width * 0.007,
                    child: Align(
                      child: Text(
                        "${getTranslated(context, "seeReceipt")}",
                     //   Strings.seeReceipt,
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Fonts.dmSansBold,
                            fontSize: size.width * 0.045),
                      ),
                    )),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Home()),
                      (route) => false);
                },
                child: Text
                  (
                    "${getTranslated(context, "backtoHome")}",
                   // Strings.backtoHome,
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: Fonts.dmSansRegular,
                        fontSize: size.width * 0.04)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
