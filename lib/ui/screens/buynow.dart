import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/ui/screens/CreditCardDetails.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/strings.dart';

class BuyNow extends StatefulWidget {
  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  bool _isVertical = false;
  double _initialRating = 2.0;

  // - + funtion

  addTicket({int? index, String? name, int? count, var price, String? image}) {
    print("add button press");

    print(UserData.ticketcartMap);

    setState(() {
      if (UserData.ticketcartMap.containsKey(index)) {
        UserData.ticketcartMap[index]["ticketCount"] =
            UserData.ticketcartMap[index]["ticketCount"] + 1;

        UserData.ticketcartMap[index]["ticketPrice"] =
            UserData.ticketcartMap[index]["ticketCount"] *
                UserData.tiketList[index!]["price"];
      } else {
        UserData.ticketcartMap[index] = {
          "ticketname": name,
          "ticketCount": count,
          "ticketPrice": price,
          "ticketimage": image
        };
      }
    });
  }

  // remove button

  ticketRemove({String? name, int? index}) {
    print("remove");
    setState(() {
      if (UserData.ticketcartMap.containsKey(index) &&
          UserData.ticketcartMap[index]["ticketCount"] > 1) {
        UserData.ticketcartMap[index]["ticketCount"] =
            UserData.ticketcartMap[index]["ticketCount"] - 1;

        UserData.ticketcartMap[index]["ticketPrice"] =
            UserData.ticketcartMap[index]["ticketCount"] *
                UserData.tiketList[index!]["price"];
      } else {
        UserData.ticketcartMap.remove(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(right: size.width * 0.02),
            child: SvgPicture.asset(
              "assets/svgicons/hearticon.svg",
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: AppColors.homeBackground,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: AppColors.homeBackground,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print("here is list");
      //     print(UserData.ticketcartMap.length);
      //   },
      //   child: Icon(Icons.ac_unit),
      // ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(SizeConfig.screenHeight * 0.02),
                    height: SizeConfig.screenHeight * 0.20,
                    child: Row(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  height: SizeConfig.screenHeight * 0.03,
                                  width: SizeConfig.screenWidth * 0.15,
                                  child: Center(
                                      child: Text(
                                    "OPEN",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontFamily: "BabasNeue",
                                      fontSize: size.width * 0.043,
                                    ),
                                  )),
                                ),
                                SizedBox(width: SizeConfig.screenWidth * 0.03),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.homeBackground,
                                    border: Border.all(color: AppColors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  height: SizeConfig.screenHeight * 0.03,
                                  width: SizeConfig.screenWidth * 0.15,
                                  child: Center(
                                      child: Text(
                                    "Club",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontFamily: "DM Sans Medium",
                                      fontSize: size.width * 0.035,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            Container(
                              // cvfbgtkl;./
                              width: SizeConfig.screenWidth * 0.60,

                              margin: EdgeInsets.only(top: size.height * 0.01),

                              //   height: SizeConfig.screenHeight,
                              child: Text(
                                "Teatro Barceló",
                                style: TextStyle(
                                    fontSize: size.width * 0.08,
                                    fontFamily: "DM Sans Bold",
                                    color: AppColors.white),
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ratingstars(
                                size: size.width * 0.06,
                                ittempading: size.width * 0.005,
                                color: AppColors.tagBorder,
                                rating: 3.0)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // here sart bottom content

            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.homeBackgroundLite,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: <Color>[
                      AppColors.homeBackgroundLite,
                      Colors.transparent
                    ],
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
                height: size.height * 0.7,
                width: size.width,
                child: Column(
                  children: [
                    // cart title
                    Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.all(SizeConfig.screenWidth * 0.04),
                          child:
                              SvgPicture.asset("assets/svgicons/cartsvg.svg"),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.003,
                        ),
                        Text(
                          Strings.yourCart,
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Fonts.dmSansMedium,
                              fontSize: size.width * 0.04),
                        ),
                      ],
                    ),

                    // Cart list
                    Expanded(
                      // height: size.height * 0.5,
                      child: ListView.builder(
                          itemCount: UserData.ticketcartMap.values.length,
                          itemBuilder: (context, index) {
                            var data =
                                UserData.ticketcartMap.values.elementAt(index);
                            var indexKey =
                                UserData.ticketcartMap.keys.toList()[index];

                            // print(indexKey);
                            return cartItem(
                                size: size,
                                index: indexKey,
                                title: data["ticketname"],
                                image: data["ticketimage"],
                                count: data["ticketCount"],
                                price: data["ticketPrice"],
                                remove: ticketRemove,
                                add: addTicket);
                          }),
                    ),

                    // proceed to pay

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),

                    SizedBox(
                      width: SizeConfig.screenWidth * 0.90,
                      child: ElevatedButton(
                        child: Text(
                          Strings.proceedtopay,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: size.width * 0.05,
                              fontFamily: Fonts.dmSansBold),
                        ),
                        onPressed: () {
                          navigatorPushFun(context, CreditCard());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.06,
                              vertical: SizeConfig.screenHeight * 0.02),
                          primary: AppColors.redlite,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: SizeConfig.screenWidth * 0.80,
                        ),
                        child: Text(
                          Strings
                              .thisisthefinalstepafteryoutouchingPayNowbuttonthepaymentwillbetransaction,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.descriptionfirst,
                              fontSize: size.width * 0.035,
                              fontFamily: Fonts.dmSansMedium),
                        )),

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget cartItem(
    {size,
    int? index,
    String? title,
    String? image,
    int? count,
    var price,
    add,
    remove}) {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.005,
        horizontal: SizeConfig.screenWidth * 0.04),
    decoration: BoxDecoration(
        color: AppColors.brownLite,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(size.width * 0.02))),
    height: SizeConfig.screenHeight * 0.20,
    width: SizeConfig.screenWidth * 0.92,
    child: Padding(
      // padding: EdgeInsets.fromLTRB(8.0,SizeConfig.screenHeight * 0.02,8.0,SizeConfig.screenHeight * 0.04),
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015, horizontal: size.width * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/images/ticket.svg",
            width: size.width * 0.1,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.03,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: Fonts.dmSansMedium,
                    fontSize: size.width * 0.04),
              ),
              Text(Strings.qty + ":$count",
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: Fonts.dmSansMedium,
                      fontSize: size.width * 0.03)),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      remove(name: title, index: index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.brownLite,
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
                  Text(
                    "$count",
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
                      add(
                          index: index,
                          name: title,
                          count: count,
                          price: price,
                          image: image);
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
          ),
          Spacer(),
          Text(
            Strings.euro + " " + "$price",
            style: TextStyle(
                fontFamily: Fonts.dmSansMedium,
                fontSize: size.width * 0.055,
                color: AppColors.white),
          )
        ],
      ),
    ),
  );
}
