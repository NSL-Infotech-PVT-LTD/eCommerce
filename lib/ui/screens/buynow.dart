import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/utils/colors.dart';


class BuyNow extends StatefulWidget {

  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  bool _isVertical = false;
  double _initialRating = 2.0;
  @override
  Widget build(BuildContext context) {
    Widget _ratingBar(int mode) {
      switch (mode) {
        case 1:
          return RatingBar.builder(
            initialRating: _initialRating,
            minRating: 1,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            unratedColor: Colors.amber.withAlpha(50),
            itemCount: 5,
            itemSize: 22.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                //_rating = rating;
              });
            },
            updateOnDrag: true,
          );
        case 2:
          return RatingBar(
            initialRating: _initialRating,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: Icon(Icons.star),
              half: Icon(Icons.star_half),
              empty: Icon(Icons.star_border_outlined),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              setState(() {
                //   _rating = rating;
              });
            },
            updateOnDrag: true,
          );
        case 3:
          return RatingBar.builder(
            initialRating: _initialRating,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
                default:
                  return Container();
              }
            },
            onRatingUpdate: (rating) {
              setState(() {
                //   _rating = rating;
              });
            },
            updateOnDrag: true,
          );
        default:
          return Container();
      }
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          SvgPicture.asset(
            "assets/svgicons/hearticon.svg",
            color: Colors.white,
          )
        ],
        backgroundColor: AppColors.homeBackground,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: AppColors.homeBackground,
      body:
      Column(
        children: [
          Container(
            padding: EdgeInsets.all( SizeConfig.screenHeight * 0.02),
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
                                  fontFamily: "BabasNeue",
                                  fontSize: 17,
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
                                  fontFamily: "DM Sans Medium",
                                  fontSize: 12,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      // cvfbgtkl;./
                      width: SizeConfig.screenWidth * 0.60,
                      //   height: SizeConfig.screenHeight,
                      child: Text(
                        "Teatro Barceló",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: "DM Sans Bold",
                        ),
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _ratingBar(1),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: AppColors.homeBackgroundLite,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // 10% of the width, so there are ten blinds.
                    colors: <Color>[AppColors.homeBackgroundLite,Colors.transparent
                    ], // red to yellow
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                height: SizeConfig.screenHeight * 0.30,
              ),
              Positioned(
                child: Column(
                  children: [
                    Row(children: [

            Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth * 0.04),
              child: SvgPicture.asset("assets/svgicons/cartsvg.svg"),
            ),SizedBox(
                        width: SizeConfig.screenWidth * 0.03,
                      ),
                      Text("Your Cart"),
                    ],),
                    Container(
                      decoration: BoxDecoration(
                          color:AppColors.brownLite,
                          border: Border.all(
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),

                      height: SizeConfig.screenHeight * 0.20,
                      width: SizeConfig.screenWidth * 0.80,
                      child:  Padding(
                        padding: EdgeInsets.fromLTRB(8.0,SizeConfig.screenHeight * 0.02,8.0,SizeConfig.screenHeight * 0.04),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset("assets/images/ticket.svg",),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.03,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ticket"),
                                Text("Qty:2"),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.02,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.brownLite,
                                        border: Border.all(color: AppColors.white),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                      ),
                                      height: SizeConfig.screenHeight * 0.03,
                                      width: SizeConfig.screenWidth * 0.08,
                                      child: Center(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                            fontFamily: "DM Sans Medium",
                                            fontSize: 12,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.03,
                                    ),
                                    Text("0"),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.03,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.skin,
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(6)
                                        ),
                                      ),
                                      height: SizeConfig.screenHeight * 0.03,
                                      width: SizeConfig.screenWidth * 0.08,
                                      child: Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                fontFamily: "DM Sans Medium",
                                                fontSize: 12,
                                                color: AppColors.homeBackground
                                            ),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ), Spacer(), Text("€ 29.99")
                          ],
                        ),
                      ),)
                  ],
                ),
              ),

            ],
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.80,
            child: ElevatedButton(
              child: Text(
                'Proceed to pay',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // navigatorPushFun(context, CreditCard());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.06,
                    vertical: SizeConfig.screenHeight * 0.02),
                primary: AppColors.redlite,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.20,),
          ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: SizeConfig.screenWidth * 0.80,
              ),
              child: Text("This is the final step, after you touching Pay Now button, the payment will be transaction",))
        ],
      ),
    );
  }
}
