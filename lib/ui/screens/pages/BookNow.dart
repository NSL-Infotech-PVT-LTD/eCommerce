import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/utils/basic%20function.dart';
import 'package:funfy/utils/colors.dart';
import 'buynow.dart';

class BookNow extends StatefulWidget {
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  CarouselController _carouselController = CarouselController();
  List<Widget> cardList = [];
  int _currentIndex = 0;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;
  String name = "Loading...";
  String description = "Loading...";
  String freeDeliveryReturn = "Loading...";
  String price = "Loading...";

  @override
  void initState() {
    cardList = List<SlidingBannerProviderDetails>.generate(
        3, (index) => SlidingBannerProviderDetails());
    super.initState();
  }

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

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
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
          body: Stack(
            children: [
              Container(
                color: AppColors.homeBackgroundLite,
                height: SizeConfig.screenHeight,
                child: Column(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      child: CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            height: SizeConfig.screenHeight * 0.30,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            pauseAutoPlayOnTouch: true,
                            aspectRatio: 2.0,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: cardList //cardList
                          ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 05.0, horizontal: 2.0),
                    ),
                    Container(
                      color: AppColors.homeBackground,
                      padding: EdgeInsets.all(8.0),
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
                                  SizedBox(
                                      width: SizeConfig.screenWidth * 0.03),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.homeBackground,
                                      border:
                                          Border.all(color: AppColors.white),
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.02),
                                  child: Text(
                                    "$name",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "DM Sans Bold",
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              _ratingBar(1),
                            ],
                          ),
                          Spacer(),
                          Container(
                            child: Stack(children: [
                              SvgPicture.asset(
                                "assets/images/pricebanner.svg",
                                height: SizeConfig.screenHeight * 0.09,
                                width: SizeConfig.screenWidth * 0.20,
                                //  fit: BoxFit.fill,
                              ),
                              Positioned(
                                right: 0,
                                left: 0,
                                top: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "STARTING FROM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColors.brownlite,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      "€ 29",
                                      style: TextStyle(
                                          color: AppColors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: AppBar(
                        backgroundColor: AppColors.homeBackground,
                        foregroundColor: AppColors.homeBackground,
                        bottom: TabBar(
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: AppColors.siginbackgrond,
                          tabs: [
                            Tab(
                              icon: Text("Booking"),
                            ),
                            Tab(
                              icon: Text("About"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        ListView.builder(
                            itemCount: 4,
                            itemBuilder: (BuildContext context, index) {
                              return TicketFun();
                            }),
                        // first tab bar view widget
                        Container(
                          color: AppColors.homeBackground,
                          child: Padding(
                            padding:
                                EdgeInsets.all(SizeConfig.screenWidth * 0.06),
                            child: Container(
                              width: SizeConfig.screenWidth * 0.70,
                              height: null,
                              child: Card(
                                color: AppColors.homeBackgroundLite,
                                shadowColor: Colors.black26,
                                elevation: 10.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.40,
                                    child: ListView(
                                      children: [
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontFamily: "Product",
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.02),
                                        Text(
                                            "Dummy text   Dummy text   Dummy text   Dummy text   Dummy text   Dummy text   Dummy text   Dummy text   Dummy text   Dummy text   ",
                                            style: TextStyle(
                                                fontFamily: "Product",
                                                fontSize: 14,
                                                color: AppColors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0.0,
                  child: Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.10,
                      child: SvgPicture.asset(
                        "assets/images/Rectangle.svg",
                        fit: BoxFit.fill,
                      ))),
              Positioned(
                bottom: SizeConfig.screenHeight * 0.01,
                right: SizeConfig.screenWidth * 0.03,
                left: SizeConfig.screenWidth * 0.03,
                child: Container(
                  width: SizeConfig.screenWidth,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Added to cart",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.brownlite, fontSize: 8),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.01,
                          ),
                          SvgPicture.asset("assets/images/ticket.svg"),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.04,
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.40,
                        child: Flexible(
                          child: Text(
                            "ticket * 10",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "DM Sans Bold",
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          navigatorPushFun(context, BuyNow());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.06,
                              vertical: SizeConfig.screenHeight * 0.02),
                          primary: AppColors.redlite,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
