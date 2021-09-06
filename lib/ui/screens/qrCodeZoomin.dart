import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/ui/screens/bookNowBeta.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeZoomIn extends StatefulWidget {
  final qrId;
  final id;

  const QrCodeZoomIn({Key? key, this.qrId, @required this.id})
      : super(key: key);

  @override
  _QrCodeZoomInState createState() => _QrCodeZoomInState();
}

class _QrCodeZoomInState extends State<QrCodeZoomIn> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.siginbackgrond,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "${getTranslated(context, "youreTicket")}",
          // Strings.youreTicket,
          style: TextStyle(
              fontFamily: Fonts.dmSansMedium, fontSize: size.width * 0.05),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // center box
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.034),
                width: size.width,
                height: size.height * 0.74,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    // color: Colors.transparent,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 0.02))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            width: size.width * 0.06,
                            height: size.height * 0.03,
                            child: SvgPicture.asset(
                              Images.qrZoomOut,
                              width: size.width * 0.055,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * 0.1,
                    ),

                    // qr code

                    Container(
                      alignment: Alignment.center,
                      // width: size.width * 0.32,
                      // height: size.height * 0.16,
                      // color: Colors.yellow,
                      child: QrImage(
                        data: "${widget.qrId}",
                        version: QrVersions.auto,
                        size: size.width * 0.75,
                      ),
                    ),

                    Spacer(),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),

              InkWell(
                onTap: () {
                  navigatorPushFun(
                      context,
                      BookNowBeta(
                        fiestasID: widget.id,
                      ));
                },
                child: roundedBoxR(
                    height: size.height * 0.065,
                    width: size.width * 0.7,
                    backgroundColor: AppColors.blackBackground,
                    radius: size.width * 0.02,
                    child: Center(
                        child: Text(
                      "${getTranslated(context, "seeClubProfile")}",
                      // Strings.seeClubProfile,
                      style: TextStyle(
                          color: AppColors.white,
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.045),
                    ))),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget content({size, String? title, String? description}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$title",
        style: TextStyle(
            fontFamily: Fonts.dmSansBold,
            fontSize: size.width * 0.05,
            color: AppColors.blackBackground),
      ),
      SizedBox(
        height: size.height * 0.005,
      ),
      Text(
        "$description",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: Fonts.dmSansMedium,
            fontSize: size.width * 0.045,
            color: AppColors.inputTitle),
      ),
    ],
  );
}
