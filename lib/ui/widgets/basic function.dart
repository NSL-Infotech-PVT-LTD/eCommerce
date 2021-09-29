import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/addProductFuctions.dart';
import 'package:funfy/components/shortPrices.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class SlidingBannerProviderDetails extends StatelessWidget {
  final image;
  const SlidingBannerProviderDetails({this.image});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // print("fjd $image");
    return Container(
      height: size.height,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              // colorFilter:
              //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
            width: size.width,
            // height: size.height * 0.28,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/AuthenticationIcon/BG_2.png"),
                    fit: BoxFit.cover))),
      ),

      // FadeInImage(
      //   width: SizeConfig.screenWidth,
      //   placeholder: NetworkImage(bannerImage),
      //   image: NetworkImage(image ?? bannerImage),
      //   fit: BoxFit.cover,
      // ),
    );
  }
}

Widget ticket({context, index, mapdata, addFunc, removeFunc}) {
  var size = MediaQuery.of(context).size;

  var tiketcart;

  try {
    tiketcart = ProductCart.ticketcart[index];

    // print(tiketcart);
  } catch (e) {
    tiketcart = null;

    // print(tiketcart);
  }

  // print("print here");

  // print(ProductCart.ticketcart.length);
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.3,
              color: AppColors.tagBorder,
            )),
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            //  SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Stack(
              children: [
                SizedBox(
                    width: SizeConfig.screenWidth,
                    child: SvgPicture.asset(
                      "assets/images/Rectangle84.svg",
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: SizeConfig.screenHeight * 0.13,
                    child: Padding(
                      // padding: const EdgeInsets.all(8.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.001),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: size.height * 0.005),
                              child: SvgPicture.asset(mapdata["image"])),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.40,
                                child: Text(
                                  mapdata["name"],
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 22,
                                    fontFamily: "DM Sans Bold",
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: size.width * 0.48,
                                child: Text(
                                  mapdata["description"],
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: size.width * 0.04,
                                    fontFamily: Fonts.dmSansMedium,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.40,
                                child: Text(
                                  mapdata['max'] == 0
                                      ? "${getTranslated(context, "outofStock")}"
                                      : "${getTranslated(context, "qty")} : ${mapdata['max']}",
                                  style: TextStyle(
                                    color: AppColors.descriptionfirst,
                                    fontSize: size.width * 0.035,
                                    fontFamily: "DM Sans Bold",
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                // Text(
                                //   mapdata["description"],
                                //   textAlign: TextAlign.start,
                                //   maxLines: 2,
                                //   softWrap: true,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(
                                //       color: AppColors.brownlite, fontSize: 14),
                                // ),
                              ),
                            ],
                          ),
                          Spacer(),
                          mapdata['max'] != 0
                              ? Column(
                                  children: [
                                    Text(
                                      Strings.euro +
                                          " " +
                                          "${k_m_b_generator(mapdata["price"])}",
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.03,
                                    ),

                                    // + - buttons
                                    mapdata['max'] != 0
                                        ? UserData.ticketcartMap
                                                .containsKey(index)
                                            ? Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      removeFunc(
                                                          name: mapdata["name"],
                                                          index: index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .white),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.width *
                                                                        0.01)),
                                                      ),
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.04,
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.08,
                                                      child: Center(
                                                          child: Text(
                                                        "-",
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontFamily:
                                                              "DM Sans Medium",
                                                          fontSize:
                                                              size.width * 0.04,
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.03,
                                                  ),

                                                  // center number
                                                  Text(
                                                    UserData.ticketcartMap
                                                            .containsKey(index)
                                                        ? UserData
                                                            .ticketcartMap[
                                                                index]
                                                                ["ticketCount"]
                                                            .toString()
                                                        : "0",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "DM Sans Medium",
                                                        fontSize:
                                                            size.width * 0.04,
                                                        color: AppColors.white),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.03,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      addFunc(
                                                          index: index,
                                                          name: mapdata["name"],
                                                          count: 1,
                                                          price: double.parse(
                                                              mapdata["price"]
                                                                  .toString()),
                                                          image:
                                                              mapdata["image"]);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors.skin,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.width *
                                                                        0.01)),
                                                      ),
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.04,
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.08,
                                                      child: Center(
                                                          child: Text(
                                                        "+",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "DM Sans Medium",
                                                            fontSize:
                                                                size.width *
                                                                    0.04,
                                                            color: AppColors
                                                                .homeBackground),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  addFunc(
                                                      index: index,
                                                      name: mapdata["name"],
                                                      count: 1,
                                                      price: double.parse(
                                                          mapdata["price"]
                                                              .toString()),
                                                      image: mapdata["image"]);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.skin,
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            size.width * 0.01)),
                                                  ),
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.04,
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.2,
                                                  child: Center(
                                                      child: Text(
                                                    "+ ${getTranslated(context, 'add')}",
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .blackBackground,
                                                      fontFamily:
                                                          "DM Sans Medium",
                                                      fontSize:
                                                          size.width * 0.04,
                                                    ),
                                                  )),
                                                ),
                                              )
                                        : SizedBox()
                                  ],
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: SizeConfig.screenHeight * 0.02,
            // ),
          ],
        ),
      ),

      //

      mapdata['max'] == 0
          ? Container(
              margin: EdgeInsets.only(top: 10),
              child: roundedBoxR(
                  radius: size.width * 0.045,
                  width: size.width,
                  height: size.height * 0.143,
                  backgroundColor: Colors.black.withOpacity(0.5)),
            )
          : SizedBox()
    ],
  );
}
