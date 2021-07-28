import 'package:flutter/material.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/shortPrices.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/widgets/basic%20function.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:intl/intl.dart';
import 'buynow.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class BookNowBeta extends StatefulWidget {
  final Datum? fiestasModel;

  // final fiestasModel;

  const BookNowBeta({Key? key, this.fiestasModel}) : super(key: key);

  @override
  _BookNowBetaState createState() => _BookNowBetaState();
}

class _BookNowBetaState extends State<BookNowBeta> {
  CarouselController _carouselController = CarouselController();
  List<Widget> cardList = [];

  bool _fiestasfavoriteBool = false;

  bool _loadingMainCenter = false;

  // - + funtion

  addTicket({int? index, String? name, var count, var price, String? image}) {
    print("add button press  $count  $index");
    print("price is here $price");
    // print(UserData.ticketcartMap[index]["ticketPrice"].runtimeType);

    // print(UserData.ticketcartMap.toString());

    setState(() {
      if (UserData.ticketcartMap.containsKey(index)) {
        print("old add");
        print(UserData.ticketcartMap);
        UserData.ticketcartMap[index]["ticketCount"] =
            UserData.ticketcartMap[index]["ticketCount"] + 1;

        UserData.ticketcartMap[index]["ticketPrice"] =
            int.parse(UserData.ticketcartMap[index]["ticketCount"].toString()) *
                int.parse(UserData.tiketList[index!]["price"].toString());

        totalTicket();
      } else {
        print("new add $index");
        UserData.ticketcartMap[index] = {
          "ticketname": name,
          "ticketCount": 1,
          "ticketPrice": price,
          "ticketimage": image
        };

        totalTicket();
      }
    });

    print(UserData.ticketcartMap);
  }

  // remove button

  ticketRemove({String? name, int? index}) {
    print("remove");
    print(UserData.ticketcartMap);
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

  // add favorite

  addFavorite() async {
    print("add to favorite");

    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loadingMainCenter = true;
      });
      try {
        print("----------- ${widget.fiestasModel?.clubId.toString()}");
        await fiestasAddfavouriteApi(id: widget.fiestasModel?.clubId.toString())
            .then((res) {
          setState(() {
            _loadingMainCenter = false;
          });

          if (res["status"] == true && res["code"] == 201) {
            print("added in favorite");

            setState(() {
              _fiestasfavoriteBool = true;
            });
          }
          if (res["status"] == true && res["code"] == 200) {
            print("removed in favorite");
            _fiestasfavoriteBool = false;
          }
        });
      } catch (e) {
        setState(() {
          _loadingMainCenter = false;
        });
      }
    }
  }

  // setFavorite bool

  setFavoriteBool() {
    setState(() {
      _fiestasfavoriteBool = widget.fiestasModel!.isFavourite!;
    });
  }

  @override
  void initState() {
    // setFavorite bool

    // print("here is data ${widget.fiestasModel.toJson().toString()}");

    setFavoriteBool();

    cardList = List<SlidingBannerProviderDetails>.generate(
        3,
        (index) => SlidingBannerProviderDetails(
              image: "${widget.fiestasModel?.image}",
            ));

    setPriceToList();
    super.initState();
  }

  setPriceToList() {
    setState(() {
      UserData.tiketList[0]["price"] =
          int.parse('${widget.fiestasModel?.ticketPrice}');
      // k_m_b_generator(int.parse('${widget.fiestasModel?.ticketPrice}'));
      UserData.tiketList[1]["price"] =
          int.parse('${widget.fiestasModel?.ticketPriceStandard}');
      // k_m_b_generator(
      //     int.parse('${widget.fiestasModel?.ticketPriceStandard}'));
      UserData.tiketList[2]["price"] =
          int.parse('${widget.fiestasModel?.ticketPriceVip}');
      // k_m_b_generator(int.parse('${widget.fiestasModel?.ticketPriceVip}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String price =
        k_m_b_generator(int.parse("${widget.fiestasModel?.ticketPrice}"));

    DateTime? dateTime = DateTime.parse("${widget.fiestasModel?.timestamp}");

    String day = DateFormat('dd').format(dateTime);
    String month = DateFormat('MMMM').format(dateTime);
    String time = DateFormat('hh:mm a').format(dateTime);
    String onlyTime = time.split(" ")[0];
    String amPm = time.split(" ")[1];

    print("Look here $day $month $time");

    return SafeArea(
      child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //     onPressed: () {
          //       setState(() {
          //         UserData.totalTicketNum = 0;
          //         UserData.ticketcartMap.clear();
          //       });
          //     },
          //     child: Icon(Icons.add)),
          backgroundColor: AppColors.homeBackground,
          body: Stack(
            children: [
              DefaultTabController(
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
                          GestureDetector(
                            onTap: () {
                              addFavorite();
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                  "assets/svgicons/hearticon.svg",
                                  color: _fiestasfavoriteBool
                                      ? Colors.red
                                      : Colors.white),
                            ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              //
                                              color: widget
                                                          .fiestasModel?.type ==
                                                      "open"
                                                  ? AppColors.green
                                                  : AppColors.blackBackground,

                                              border: Border.all(
                                                  color: widget.fiestasModel
                                                              ?.type ==
                                                          "open"
                                                      ? AppColors
                                                          .blackBackground
                                                      : AppColors.white),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                            ),
                                            height:
                                                SizeConfig.screenHeight * 0.03,
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Center(
                                                child: Text(
                                              "${getTranslated(context, "open")}",
                                              // Strings.open,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontFamily: "BabasNeue",
                                                fontSize: size.width * 0.045,
                                              ),
                                            )),
                                          ),
                                          SizedBox(
                                              width: SizeConfig.screenWidth *
                                                  0.03),
                                          Container(
                                            decoration: BoxDecoration(
                                              //
                                              color: widget
                                                          .fiestasModel?.type ==
                                                      "club"
                                                  ? AppColors.green
                                                  : AppColors.blackBackground,

                                              border: Border.all(
                                                  color: widget.fiestasModel
                                                              ?.type ==
                                                          "club"
                                                      ? AppColors
                                                          .blackBackground
                                                      : AppColors.white),
                                              // color: AppColors.homeBackground,
                                              // border: Border.all(
                                              //     color: AppColors.white),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                            ),
                                            height:
                                                SizeConfig.screenHeight * 0.03,
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Center(
                                                child: Text(
                                              "${getTranslated(context, "club")}",
                                              // Strings.club,
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
                                        width: SizeConfig.screenWidth * 0.60,
                                        //   height: SizeConfig.screenHeight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  SizeConfig.screenWidth * 0.02,
                                              top: size.width * 0.01),
                                          child: Text(
                                            "${widget.fiestasModel?.name}",
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

                                  roundedBoxR(
                                      height: size.height * 0.1,
                                      // width: size.width * 0.3,
                                      radius: size.width * 0.02,
                                      backgroundColor: AppColors.brownLite,
                                      child: Container(
                                        // color: Colors.blue,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.03,
                                            vertical: size.height * 0.01),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              Strings.startingfrom,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors.brownlite,
                                                  fontSize: size.width * 0.026),
                                            ),
                                            Text(
                                              "${Strings.euro} " + "$price",
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontFamily: Fonts.dmSansBold,
                                                  fontSize: price.length > 3
                                                      ? size.width * 0.04
                                                      : size.width * 0.06),
                                            )
                                          ],
                                        ),
                                      ))

                                  // Container(
                                  //   child: Stack(children: [
                                  //     SvgPicture.asset(
                                  //       "assets/images/pricebanner.svg",
                                  //       height: SizeConfig.screenHeight * 0.09,
                                  //       width: SizeConfig.screenWidth * 0.20,
                                  //       //  fit: BoxFit.fill,
                                  //     ),
                                  //     Positioned(
                                  //       // right: 0,
                                  //       // left: 0,
                                  //       // top: 10,
                                  //       child:Container(
                                  //       // color: Colors.blue,
                                  //       alignment: Alignment.center,
                                  //       margin: EdgeInsets.symmetric(
                                  //           horizontal: size.width * 0.01),
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.center,
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             Strings.startingfrom,
                                  //             textAlign: TextAlign.center,
                                  //             style: TextStyle(
                                  //                 color: AppColors.brownlite,
                                  //                 fontSize: size.width * 0.03),
                                  //           ),
                                  //           Text(
                                  //             "${Strings.euro} " + "$price",
                                  //             style: TextStyle(
                                  //                 color: AppColors.white,
                                  //                 fontFamily: Fonts.dmSansBold,
                                  //                 fontSize: size.width * 0.05),
                                  //           )
                                  //         ],
                                  //       )
                                  //     )
                                  //   ]),
                                  // ),
                                ],
                              ),

                              //table view
                            ),
                            TabBar(
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: AppColors.siginbackgrond,
                              // labelColor: Colors.black87,
                              // unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                  icon: Text(
                                    // Strings.booking
                                    "${getTranslated(context, "booking")}",
                                  ),
                                ),
                                Tab(
                                  icon: Text(
                                    // Strings.about
                                    "${getTranslated(context, "about")}",
                                  ),
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
                                                "${getTranslated(context, "addtocart")}",
                                                // Strings.addtocart,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppColors.brownlite,
                                                    fontSize:
                                                        size.width * 0.03),
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.01,
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
                                                        "${getTranslated(context, "ticket")} * ${UserData.totalTicketNum}",
                                                        // "${Strings.ticket} * ${UserData.totalTicketNum}",
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize:
                                                              size.width * 0.05,
                                                          fontFamily:
                                                              "DM Sans Bold",
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 1,
                                                        softWrap: true,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.screenWidth * 0.04,
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            child: Text(
                                              "${getTranslated(context, "buyNow")}",
                                              // Strings.buyNow,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          BuyNow(
                                                              fiestasM: widget
                                                                  .fiestasModel)))
                                                  .then((value) {
                                                setState(() {
                                                  totalTicket();
                                                });
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      SizeConfig.screenWidth *
                                                          0.06,
                                                  vertical:
                                                      SizeConfig.screenHeight *
                                                          0.02),
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
                          padding:
                              EdgeInsets.all(SizeConfig.screenWidth * 0.06),
                          child: Container(
                            width: SizeConfig.screenWidth * 0.70,
                            height: null,
                            child: Column(
                              children: [
                                // about items
                                Container(
                                  width: size.width * 0.75,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      aboutItem(
                                          context: context,
                                          imageName: Images.aboutcalenderSvg,
                                          text1: "$day",
                                          text2: "$month"),
                                      aboutItem(
                                        context: context,
                                        imageName: Images.aboutProfileSvg,
                                        // ${widget.fiestasModel.total_members}
                                        text1:
                                            "${widget.fiestasModel?.totalMembers}",
                                        text2:
                                            "${getTranslated(context, "attendies")}",
                                      ),
                                      aboutItem(
                                          context: context,
                                          imageName: Images.aboutWatchSvg,
                                          text1: "$onlyTime",
                                          text2: "$amPm"),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${getTranslated(context, "description")}",
                                            // Strings.description,
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontFamily: "Product",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.02),
                                          Text(
                                              // "${getTranslated(context, "lorem")}",
                                              "${widget.fiestasModel?.description ?? getTranslated(context, "nodataFound")}",
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
              ),
              _loadingMainCenter
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox()
            ],
          )),
    );
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
