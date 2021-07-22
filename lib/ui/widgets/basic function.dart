import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/addProductFuctions.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/strings.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class SlidingBannerProviderDetails extends StatelessWidget {
  final image;
  const SlidingBannerProviderDetails({this.image});

  @override
  Widget build(BuildContext context) {
    // print("fjd $image");
    return Container(
      child: FadeInImage(
        width: SizeConfig.screenWidth,
        placeholder: NetworkImage(bannerImage),
        image: NetworkImage(image ?? bannerImage),
        fit: BoxFit.cover,
      ),
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
  return Container(
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
                            width: SizeConfig.screenWidth * 0.40,
                            child: Text(
                              mapdata["description"],
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.brownlite, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            Strings.euro + " " + "${mapdata["price"]}",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),

                          // + - buttons
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  removeFunc(
                                      name: mapdata["name"], index: index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: AppColors.white),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 0.01)),
                                  ),
                                  height: SizeConfig.screenHeight * 0.04,
                                  width: SizeConfig.screenWidth * 0.08,
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
                                UserData.ticketcartMap.containsKey(index)
                                    ? UserData.ticketcartMap[index]
                                            ["ticketCount"]
                                        .toString()
                                    : "0",
                                style: TextStyle(
                                    fontFamily: "DM Sans Medium",
                                    fontSize: size.width * 0.04,
                                    color: AppColors.white),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  addFunc(
                                      index: index,
                                      name: mapdata["name"],
                                      count: 1,
                                      price: 100,
                                      image: mapdata["image"]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.skin,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 0.01)),
                                  ),
                                  height: SizeConfig.screenHeight * 0.04,
                                  width: SizeConfig.screenWidth * 0.08,
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
                          )
                        ],
                      )
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
  );
}
