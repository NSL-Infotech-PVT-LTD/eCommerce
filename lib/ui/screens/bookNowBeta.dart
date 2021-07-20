import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/ui/widgets/basic%20function.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';
import 'Your order Summery.dart';
import 'bookNowBeta.dart';
import 'buynow.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class BookNowBeta extends StatefulWidget {
  final Datum? fiestasModel;

  const BookNowBeta({Key? key, this.fiestasModel}) : super(key: key);

  @override
  _BookNowBetaState createState() => _BookNowBetaState();
}

class _BookNowBetaState extends State<BookNowBeta> {
  CarouselController _carouselController = CarouselController();
  List<Widget> cardList = [];
  // double _initialRating = 2.0;
  // bool _isVertical = false;

  // String description = "Loading...";
  // String freeDeliveryReturn = "Loading...";
  // String price = "Loading...";

  // - + funtion

  addTicket({int? index, String? name, int? count, var price, String? image}) {
    print("add button press");

    setState(() {
      if (UserData.ticketcartMap.containsKey(index)) {
        UserData.ticketcartMap[index]["ticketCount"] =
            UserData.ticketcartMap[index]["ticketCount"] + 1;

        UserData.ticketcartMap[index]["ticketPrice"] =
            UserData.ticketcartMap[index]["ticketCount"] *
                UserData.tiketList[index!]["price"];
        totalTicket();
      } else {
        UserData.ticketcartMap[index] = {
          "ticketname": name,
          "ticketCount": count,
          "ticketPrice": price,
          "ticketimage": image
        };

        totalTicket();
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
        totalTicket();
      } else {
        UserData.ticketcartMap.remove(index);
        totalTicket();
      }
    });
  }

  // total ticket count

  totalTicket() {
    // UserData.totalTicketNum = 0;

    num tot = 0;

    // print(UserData.totalTicketNum);
    for (var i in UserData.ticketcartMap.values.toList()) {
      // print(i["ticketCount"] + 1);
      tot = tot + i["ticketCount"];
    }

    UserData.totalTicketNum = tot;
  }

  @override
  void initState() {
    cardList = List<SlidingBannerProviderDetails>.generate(
        3, (index) => SlidingBannerProviderDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  collapsedHeight: 150.0,
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actions: [
                    SvgPicture.asset(
                      "assets/svgicons/hearticon.svg",
                      color: Colors.white,
                    )
                  ],
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
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
                                onPageChanged: (index, reason) {},
                              ),
                              items: cardList //cardList
                              ),
                        ),
                      ),
                      Positioned(bottom: 0.0, child: Text(""))
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      height: SizeConfig.screenHeight * 0.03,
                                      width: SizeConfig.screenWidth * 0.15,
                                      child: Center(
                                          child: Text(
                                        "OPEN",
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: "BabasNeue",
                                          fontSize: size.width * 0.045,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      height: SizeConfig.screenHeight * 0.03,
                                      width: SizeConfig.screenWidth * 0.15,
                                      child: Center(
                                          child: Text(
                                        "Club",
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: "DM Sans Medium",
                                          fontSize: size.width * 0.03,
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
                                        left: SizeConfig.screenWidth * 0.02,
                                        top: size.width * 0.01),
                                    child: Text(
                                      "${widget.fiestasModel?.name ?? "AnyName"}",
                                      style: TextStyle(
                                          fontSize: size.width * 0.058,
                                          fontFamily: "DM Sans Bold",
                                          color: AppColors.white),
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                // _ratingBar(1),

                                SizedBox(
                                  height: size.height * 0.005,
                                ),

                                ratingstars(
                                    size: size.width * 0.06,
                                    ittempading: size.width * 0.005,
                                    color: AppColors.tagBorder,
                                    rating: 3.0)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        Strings.startingfrom,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.brownlite,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        "€ 29",
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                      TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: AppColors.siginbackgrond,
                        // labelColor: Colors.black87,
                        // unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            icon: Text(Strings.booking),
                          ),
                          Tab(
                            icon: Text(Strings.about),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              //   Text(""),
              Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: UserData.tiketList.length,
                            itemBuilder: (
                              BuildContext context,
                              index,
                            ) {
                              return ticket(
                                  context: context,
                                  index: index,
                                  mapdata: UserData.tiketList[index],
                                  addFunc: addTicket,
                                  removeFunc: ticketRemove);
                            }),
                      ),
                    ],
                  ),
                  UserData.ticketcartMap.isEmpty
                      ? SizedBox()
                      : Positioned(
                          bottom: 0.0,
                          child: Stack(
                            children: [
                              Container(
                                  width: SizeConfig.screenWidth,
                                  height: SizeConfig.screenHeight * 0.10,
                                  child: SvgPicture.asset(
                                    "assets/images/Rectangle.svg",
                                    fit: BoxFit.fill,
                                  )),
                              Container(
                                width: SizeConfig.screenWidth,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: size.height * 0.01),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Added to cart",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppColors.brownlite,
                                              fontSize: size.width * 0.03),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.01,
                                        ),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/ticket.svg",
                                                width: size.width * 0.07,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.02,
                                              ),
                                              Container(
                                                // width: SizeConfig.screenWidth * 0.40,
                                                child: Text(
                                                  "${Strings.ticket} * ${UserData.totalTicketNum}",
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: size.width * 0.05,
                                                    fontFamily: "DM Sans Bold",
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ]),
                                      ],
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.04,
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      child: Text(
                                        'Buy Now',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        navigatorPushFun(context, BuyNow());
                                        //    navigatorPushFun(context, BuyNow());
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),

              // first tab bar view widget
              SingleChildScrollView(
                child: Container(
                  color: AppColors.homeBackground,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.screenWidth * 0.06),
                    child: Container(
                      width: SizeConfig.screenWidth * 0.70,
                      height: null,
                      child: Column(
                        children: [
                          // about items
                          Container(
                            width: size.width * 0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                aboutItem(
                                    context: context,
                                    imageName: Images.aboutcalenderSvg,
                                    text1: "23",
                                    text2: "June"),
                                aboutItem(
                                    context: context,
                                    imageName: Images.aboutProfileSvg,
                                    text1: "23",
                                    text2: "June"),
                                aboutItem(
                                    context: context,
                                    imageName: Images.aboutWatchSvg,
                                    text1: "23",
                                    text2: "June"),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.03,
                          ),

                          Card(
                            color: AppColors.homeBackgroundLite,
                            shadowColor: Colors.black26,
                            elevation: 10.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height:
                                //     SizeConfig.screenHeight * 0.40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.description,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: "Product",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                        height: SizeConfig.screenHeight * 0.02),
                                    Text(Strings.lorem,
                                        style: TextStyle(
                                            fontFamily: "Product",
                                            fontSize: 14,
                                            color: AppColors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

Widget aboutItem({context, String? imageName, String? text1, String? text2}) {
  var size = MediaQuery.of(context).size;

  return Column(
    children: [
      roundedBoxR(
          width: size.width * 0.15,
          height: size.height * 0.07,
          backgroundColor: AppColors.homeBackgroundLite,
          radius: size.width * 0.01,
          child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.04),
              // color: AppColors.white,
              child: SvgPicture.asset(
                "$imageName",
                width: size.width * 0.01,
              )

              // Image.asset(
              //   "$imageName",
              //   width: size.width * 0.01,
              // )

              )),
      SizedBox(
        height: size.height * 0.008,
      ),
      Text(
        "$text1",
        style: TextStyle(
            color: Colors.white,
            fontFamily: Fonts.dmSansBold,
            fontSize: size.width * 0.05),
      ),
      Text(
        "$text2",
        style: TextStyle(
            color: Colors.white,
            fontFamily: Fonts.dmSansRegular,
            fontSize: size.width * 0.03),
      )
    ],
  );
}
