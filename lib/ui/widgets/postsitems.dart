import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';
import 'package:intl/intl.dart';

String beerImageLink =
    "https://freepngimg.com/thumb/bottle/67-beer-bottle-png-image.png";

String yellowImageLink =
    "https://i.pinimg.com/736x/e3/e7/d8/e3e7d871074c2b2256207b23a4eaeca4.jpg";

Widget fiestasItem({context, Datum? postModeldata}) {
  var size = MediaQuery.of(context).size;

  DateTime? date = postModeldata?.timestamp;

  String month = DateFormat('MMM').format(date!);

  return Container(
    margin: EdgeInsets.only(top: size.width * 0.04),
    width: size.width,
    height: size.height * 0.28,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Images.intro1), fit: BoxFit.cover)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.0035),
            color: AppColors.homeBackground.withOpacity(0.4),
            width: size.width * 0.1,
            height: size.height * 0.055,
            child: Container(
              height: size.height * 0.047,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "${date.day}",
                      style: TextStyle(
                          fontSize: size.width * 0.043,
                          fontFamily: Fonts.dmSansBold,
                          color: AppColors.white),
                    ),
                  ),
                  Text(
                    "${month.toUpperCase()}",
                    style: TextStyle(
                        fontSize: size.width * 0.027,
                        fontFamily: Fonts.dmSansMedium,
                        color: AppColors.white),
                  ),
                ],
              ),
            )),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.01),
          height: size.height * 0.15,
          decoration: BoxDecoration(
              color: AppColors.homeBackground,
              border: Border(
                left: BorderSide(
                    width: size.height * 0.001, color: AppColors.tagBorder),
                right: BorderSide(
                    width: size.height * 0.001, color: AppColors.tagBorder),
                bottom: BorderSide(
                    width: size.height * 0.001, color: AppColors.tagBorder),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${postModeldata?.name}",
                    style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontFamily: Fonts.dmSansBold,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.004,
                  ),
                  Text(
                    "${postModeldata?.distanceMiles}",
                    style: TextStyle(
                        fontSize: size.width * 0.03,
                        fontFamily: Fonts.dmSansMedium,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Container(
                      // width: size.width * 0.3,
                      child: ratingstars(
                          size: size.width * 0.05,
                          ittempading: size.width * 0.0001,
                          color: AppColors.tagBorder,
                          rating: 4))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Strings.startingfrom,
                    style: TextStyle(
                        fontSize: size.width * 0.025,
                        fontFamily: Fonts.dmSansMedium,
                        color: AppColors.white),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "€",
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white),
                      ),
                      Text(
                        "29",
                        style: TextStyle(
                            fontSize: size.width * 0.068,
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  roundedBoxR(
                      width: size.width * 0.23,
                      height: size.height * 0.033,
                      radius: 3.0,
                      backgroundColor: AppColors.siginbackgrond,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          Strings.booknow,
                          style: TextStyle(
                              fontSize: size.width * 0.03,
                              fontFamily: Fonts.dmSansBold,
                              color: AppColors.white),
                        ),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget preFiestasItem(context, ProductInfo? prefiestasdata) {
  var size = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.only(top: size.height * 0.02),
    child: roundedBoxBorder(
        context: context,
        height: size.height * 0.21,
        width: size.width,
        backgroundColor: AppColors.itemBackground,
        borderColor: AppColors.tagBorder,
        borderSize: size.width * 0.0025,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //left Image
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    Images.offeryellowBackgroundSvg,
                    fit: BoxFit.cover,
                    width: size.width * 0.11,
                  ),
                  Container(
                    height: size.height * 0.07,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            Strings.from,
                            style: TextStyle(
                                fontSize: size.width * 0.027,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                Strings.euro,
                                style: TextStyle(
                                    fontSize: size.width * 0.03,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "29",
                                style: TextStyle(
                                    fontSize: size.width * 0.06,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // center content
              Container(
                  width: size.width * 0.5,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${prefiestasdata?.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: size.width * 0.054,
                            fontFamily: Fonts.dmSansBold),
                      ),
                      SizedBox(
                        height: size.height * 0.008,
                      ),
                      Text(
                        "${prefiestasdata?.description}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.itemDescription,
                            fontSize: size.width * 0.03,
                            fontFamily: Fonts.dmSansRegular),
                      ),

                      SizedBox(
                        height: size.height * 0.013,
                      ),

                      // order Now
                      roundedBoxR(
                          radius: size.width * 0.005,
                          width: size.width * 0.2,
                          height: size.height * 0.04,
                          backgroundColor: AppColors.siginbackgrond,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              Strings.orderNow,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: size.width * 0.03,
                                  fontFamily: Fonts.dmSansBold),
                            ),
                          ))
                    ],
                  )),

              // right image

              Container(
                padding: EdgeInsets.only(
                    top: size.height * 0.02, bottom: size.height * 0.013),
                width: size.width * 0.25,
                decoration: BoxDecoration(),
                child: Image.network(
                  "${prefiestasdata?.image}",
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        )),
  );
}
