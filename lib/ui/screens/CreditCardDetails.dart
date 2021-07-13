import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/screens/bookingSuccess.dart';
import 'package:funfy/utils/colors.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  bool _isVertical = false;
  double _initialRating = 2.0;
  double containerEdge = 07;

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
                      AppColors.homeBackgroundLite,
                      Colors.transparent
                    ], // red to yellow
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
                height: SizeConfig.screenHeight * 0.30,
              ),
              Positioned(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          0.0,
                          SizeConfig.screenWidth * 0.04,
                          SizeConfig.screenWidth * 0.04,
                          SizeConfig.screenWidth * 0.04,
                        ),
                        child: SvgPicture.asset("assets/svgicons/cartsvg.svg"),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.03,
                      ),
                      Text("Your Cart"),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.brownLite,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: SizeConfig.screenHeight * 0.10,
                    width: SizeConfig.screenWidth * 0.80,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          8.0,
                          SizeConfig.screenHeight * 0.02,
                          8.0,
                          SizeConfig.screenHeight * 0.01),
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
                              Text("Ticket"),
                              Text("Qty:2"),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.02,
                              ),
                            ],
                          ),
                          Spacer(),
                          Text("€ 29.99")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payment"),
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
                                // Text(
                                //   "Payment",
                                //   style: TextStyle(
                                //       fontFamily: "Product_Sans_Regular",
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 15),
                                // ),
                                // SizedBox(
                                //   height: SizeConfig.screenHeight * 0.03,
                                // ),
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
                                            Text("Add Credit / Debit Card")
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
                                                      hintText:
                                                          "Card Holder's Name"),
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
                                                      hintText: "Card Number"),
                                                ))),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.02,
                                        ),
                                        Text(
                                          "ExpertDate",
                                          style: TextStyle(
                                              fontFamily:
                                                  "Product_Sans_Regular"),
                                        ),
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
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.80,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Swipe to pay',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      navigatorPushFun(
                                          context, BookingSuccess());
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
