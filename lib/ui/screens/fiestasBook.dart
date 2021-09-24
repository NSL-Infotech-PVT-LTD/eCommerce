import 'package:flutter/material.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/shortPrices.dart';
import 'package:funfy/models/fiestasDetailmodel.dart';
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
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'buynow.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class FiestasBook extends StatefulWidget {
  final fiestasID;

  const FiestasBook({Key? key, this.fiestasID}) : super(key: key);

  @override
  _FiestasBookState createState() => _FiestasBookState();
}

class _FiestasBookState extends State<FiestasBook> {
  CarouselController _carouselController = CarouselController();
  List<Widget> cardList = [];

  double rating = 0.0;

  bool mapZoom = false;

  bool _fiestasfavoriteBool = false;

  bool _loadingMainCenter = false;

  bool _loading = false;

  FiestasDetailModel? fiestasDetailModel = FiestasDetailModel();

  String? price;

  DateTime? dateTime;

  String? day;
  String? month;
  String? time;
  String? onlyTime;
  String? amPm;

  // - + funtion

  addTicket({int? index, String? name, var count, var price, String? image}) {
    print(
        "add button press  $count  $index  ${Strings.fiestaBasicTicketBookingCharge}");

    print(Strings.fiestaBasicTicketBookingCharge);
    print(Strings.fiestaStandardTicketBookingCharge);
    print(Strings.fiestaVipTicketBookingCharge);

    var oldCount = 0;
    try {
      setState(() {
        oldCount = UserData.ticketcartMap[index]["ticketCount"];
      });
    } catch (e) {
      setState(() {
        oldCount = 0;
      });
    }

    if (UserData.tiketList[index!]["max"] > 0 &&
        oldCount < UserData.tiketList[index]["max"]) {
      setState(() {
        if (UserData.ticketcartMap.containsKey(index)) {
          // print(UserData.ticketcartMap);
          UserData.ticketcartMap[index]["ticketCount"] =
              UserData.ticketcartMap[index]["ticketCount"] + 1;

          UserData.ticketcartMap[index]["ticketPrice"] = double.parse(
                  UserData.ticketcartMap[index]["ticketCount"].toString()) *
              double.parse(UserData.tiketList[index]["price"].toString());

          // new

          if (index == 0) {
            UserData.ticketcartMap[index]["ticketBookingCharge"] = double.parse(
                    UserData.ticketcartMap[index]["ticketCount"].toString()) *
                double.parse(Strings.fiestaBasicTicketBookingCharge);
          } else if (index == 1) {
            UserData.ticketcartMap[index]["ticketBookingCharge"] = double.parse(
                    UserData.ticketcartMap[index]["ticketCount"].toString()) *
                double.parse(Strings.fiestaStandardTicketBookingCharge);
          } else if (index == 2) {
            UserData.ticketcartMap[index]["ticketBookingCharge"] = double.parse(
                    UserData.ticketcartMap[index]["ticketCount"].toString()) *
                double.parse(Strings.fiestaVipTicketBookingCharge);
          }

          totalTicket();
        } else {
          // print("new add $index");
          UserData.ticketcartMap[index] = {
            "ticketname": name,
            "ticketCount": 1,
            "ticketPrice": price,
            "ticketimage": image,
            "index": index,
            "ticketBookingCharge": index == 0
                ? double.parse(Strings.fiestaBasicTicketBookingCharge)
                : index == 1
                    ? double.parse(Strings.fiestaStandardTicketBookingCharge)
                    : double.parse(Strings.fiestaVipTicketBookingCharge)
          };

          totalTicket();
        }

        print(UserData.ticketcartMap);
      });
    }
  }

  clearCart() {
    setState(() {
      UserData.ticketcartMap.clear();
      UserData.totalTicketNum = 0;
    });
  }

  // remove button

  ticketRemove({String? name, int? index}) {
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
        await fiestasAddfavouriteApi(id: "${fiestasDetailModel?.data!.id}")
            .then((res) {
          print(res);
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
      _fiestasfavoriteBool = fiestasDetailModel!.data!.isFavourite!;

      _onAddMarkerButtonPressed();
    });
  }

  @override
  void initState() {
    super.initState();

    // get fiestas detail

    getFiestasApiCall();
  }

  setPriceToList() {
    setState(() {
      UserData.tiketList[0]["price"] =
          double.parse('${fiestasDetailModel?.data!.ticketPriceNormal}');

      UserData.tiketList[0]["max"] =
          int.parse('${fiestasDetailModel?.data!.leftNormalTicket}');

      UserData.tiketList[0]["tickets"] =
          int.parse('${fiestasDetailModel?.data!.totalNormalTickets}');

      UserData.tiketList[1]["price"] =
          double.parse('${fiestasDetailModel?.data!.ticketPriceStandard}');

      UserData.tiketList[1]["max"] =
          int.parse('${fiestasDetailModel?.data!.leftStandardTicket}');

      UserData.tiketList[1]["tickets"] =
          int.parse('${fiestasDetailModel?.data!.totalStandardTickets}');

      UserData.tiketList[2]["price"] =
          double.parse('${fiestasDetailModel?.data!.ticketPriceVip}');

      UserData.tiketList[2]["max"] =
          int.parse('${fiestasDetailModel?.data!.leftVipTicket}');

      UserData.tiketList[2]["tickets"] =
          int.parse('${fiestasDetailModel?.data!.totalVipTickets}');
    });
  }

  // get fiestas by id ----------- //

  getFiestasApiCall() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        if (UserData.ticketcartMap.isNotEmpty) {
          clearCart();
        }

        await getFiestasbyId(fiestasID: "${widget.fiestasID}").then((res) {
          setState(() {
            // print("here is Res .........");

            // print(res?.toJson());

            fiestasDetailModel = res;

            setPriceToList();
            setFavoriteBool();
            k_m_b_generator(double.parse(
                "${fiestasDetailModel?.data!.ticketPriceNormal ?? 0}"));

            dateTime = DateTime.parse("${fiestasDetailModel?.data!.timestamp}");

            day = DateFormat('dd').format(dateTime!);

            month = DateFormat('MMMM').format(dateTime!);
            time = DateFormat('hh:mm a').format(dateTime!);

            onlyTime = time?.split(" ")[0];
            amPm = time?.split(" ")[1];

            if (fiestasDetailModel?.data!.fiestaImages?.length != 0 &&
                fiestasDetailModel?.data!.fiestaImages != null) {
              cardList = [];
              print("images 1 -------");
              for (var i in fiestasDetailModel!.data!.fiestaImages!) {
                // print(i);
                cardList.add(SlidingBannerProviderDetails(image: "${i.image}"));
              }
            } else {
              cardList = [];
              print("images 2 -------");
              for (int i = 1; i < 4; i++) {
                print("here is i $i");
                cardList.add(SlidingBannerProviderDetails(
                    image: "${fiestasDetailModel?.data!.clubDetail?.image}"));
              }
            }

            if (fiestasDetailModel?.data?.clubRating == null ||
                fiestasDetailModel?.data?.clubRating == 0.0) {
              rating = 0.0;
            } else {
              rating = double.parse("${fiestasDetailModel?.data?.clubRating}");
            }

            // print(cardList);

            _loading = false;
          });
        });
      } catch (e) {
        setState(() {
          _loading = false;
        });
        print("Error in Fiestas detail Api $e");
      }
    }
  }

  PageController pageControllerL = PageController();

  int pageChanged = 1;
  bool fiestasButton = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (mapZoom == true) {
            setState(() {
              mapZoom = false;
            });
          } else {
            Navigator.pop(context);
          }

          return false;
        },
        child: Scaffold(
            appBar: mapZoom == false
                ? AppBar(
                    backgroundColor: AppColors.blackBackground,
                    title: Text("Fiestas"),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: addFavorite,
                        icon: Container(
                          child: SvgPicture.asset(
                              "assets/svgicons/hearticon.svg",
                              // _fiestasfavoriteBool
                              //     ? "assets/partydetail/fullHeart.svg"
                              //     : "assets/svgicons/hearticon.svg",
                              color: _fiestasfavoriteBool
                                  ? Colors.red
                                  : Colors.white),
                        ),
                      )
                    ],
                  )
                : AppBar(
                    toolbarHeight: 0,
                  ),
            backgroundColor: AppColors.homeBackground,
            body: Stack(
              children: [
                _loading
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          DefaultTabController(
                            length: 2,
                            child: NestedScrollView(
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return [
                                  SliverAppBar(
                                    automaticallyImplyLeading: false,
                                    collapsedHeight: 150.0,
                                    expandedHeight: 200.0,
                                    floating: true,
                                    pinned: true,
                                    snap: true,
                                    actionsIconTheme:
                                        IconThemeData(opacity: 0.0),
                                    flexibleSpace: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: Container(
                                            width: SizeConfig.screenWidth,
                                            child: CarouselSlider(
                                                carouselController:
                                                    _carouselController,
                                                options: CarouselOptions(
                                                  viewportFraction: 1.0,
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.30,
                                                  autoPlay: false,
                                                  autoPlayInterval:
                                                      Duration(seconds: 3),
                                                  autoPlayAnimationDuration:
                                                      Duration(
                                                          milliseconds: 800),
                                                  autoPlayCurve:
                                                      Curves.fastOutSlowIn,
                                                  pauseAutoPlayOnTouch: true,
                                                  aspectRatio: 2.0,
                                                  enableInfiniteScroll: false,
                                                  onPageChanged:
                                                      (index, reason) {},
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
                                    padding: EdgeInsets.only(
                                        top: 16, left: 16, right: 16),
                                    sliver: SliverList(
                                      delegate: SliverChildListDelegate([
                                        //table view

                                        Container(
                                          // padding: EdgeInsets.symmetric(
                                          //     vertical: size.height * 0.01,
                                          //     horizontal: size.width * 0.04),
                                          // color: Colors.blue,
                                          width: size.width,
                                          // height: size.height * 0.09,
                                          child: roundedBox(
                                              width: size.width * 0.8,
                                              height: size.height * 0.07,
                                              backgroundColor: AppColors
                                                  .homeTopbuttonbackground,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.height * 0.01,
                                                    horizontal:
                                                        size.width * 0.022),
                                                child: Row(
                                                  children: [
                                                    // fiestas button

                                                    Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          pageControllerL.animateToPage(
                                                              pageChanged = 0,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      150),
                                                              curve: Curves
                                                                  .bounceInOut);
                                                          setState(() {
                                                            pageChanged = 0;
                                                            fiestasButton =
                                                                true;
                                                          });
                                                        },
                                                        child: roundedBox(
                                                            backgroundColor:
                                                                fiestasButton
                                                                    ? AppColors
                                                                        .siginbackgrond
                                                                    : AppColors
                                                                        .homeTopbuttonbackground,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "${getTranslated(context, "about")}",
                                                                //    Strings.fiestas,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            0.038,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .dmSansBold,
                                                                    color: AppColors
                                                                        .white),
                                                              ),
                                                            )),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),

                                                    Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          pageControllerL.animateToPage(
                                                              pageChanged = 1,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      200),
                                                              curve: Curves
                                                                  .bounceInOut);
                                                          setState(() {
                                                            pageChanged = 1;
                                                            fiestasButton =
                                                                false;
                                                          });
                                                        },
                                                        child: roundedBox(
                                                            // width: size.width * 0.44,
                                                            backgroundColor:
                                                                fiestasButton
                                                                    ? AppColors
                                                                        .homeTopbuttonbackground
                                                                    : AppColors
                                                                        .siginbackgrond,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "${getTranslated(context, "booking")}",
                                                                //   Strings.preFiestas,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            0.038,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .dmSansBold,
                                                                    color: AppColors
                                                                        .white),
                                                              ),
                                                            )),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),

                                        // TabBar(
                                        //   unselectedLabelColor: Colors.grey,

                                        //   // indicatorColor:
                                        //   //     AppColors.siginbackgrond,
                                        //   tabs: [
                                        //     Tab(
                                        //       icon: Text(
                                        //         "${getTranslated(context, "about")}",
                                        //       ),
                                        //     ),
                                        //     Tab(
                                        //       icon: Text(
                                        //         "${getTranslated(context, "booking")}",
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ]),
                                    ),
                                  ),
                                ];
                              },
                              body: PageView(
                                  pageSnapping: true,
                                  controller: pageControllerL,
                                  onPageChanged: (index) {
                                    setState(() {
                                      print(index);
                                      pageChanged = index;

                                      if (index == 0) {
                                        fiestasButton = true;
                                      } else {
                                        fiestasButton = false;
                                      }
                                    });
                                  },
                                  children: [
                                    // first tab bar view widget
                                    SingleChildScrollView(
                                      child: Container(
                                        color: AppColors.homeBackground,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // heading data

                                            Container(
                                              margin: EdgeInsets.only(
                                                top: size.height * 0.015,
                                                left: size.width * 0.04,
                                                right: size.width * 0.04,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${fiestasDetailModel?.data!.name ?? ''}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.08,
                                                        fontFamily:
                                                            "DM Sans Bold",
                                                        color: AppColors.white),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.005,
                                                  ),
                                                  ratingstars(
                                                      size: size.width * 0.06,
                                                      ittempading:
                                                          size.width * 0.005,
                                                      color:
                                                          AppColors.tagBorder,
                                                      rating: rating)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            aboutItems(
                                                imageHeight: 0.038,
                                                size: size,
                                                icon:
                                                    "assets/partydetail/peopplecoming.png",
                                                content:
                                                    "${fiestasDetailModel?.data!.totalMembers} ${getTranslated(context, 'peopleAttendinginthisevent')}"),
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.025),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      aboutItems(
                                                          imageHeight: 0.035,
                                                          size: size,
                                                          icon:
                                                              "assets/partydetail/calender.png",
                                                          content:
                                                              "$day ${month?.substring(0, 4)}"),
                                                      // SizedBox(
                                                      //   height: size.width * 0.06,
                                                      // ),
                                                      aboutItems(
                                                          imageHeight: 0.035,
                                                          size: size,
                                                          icon:
                                                              "assets/partydetail/dresScode.png",
                                                          content:
                                                              "${fiestasDetailModel?.data?.filterClothing?.name}"),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.07,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      aboutItems(
                                                          imageHeight: 0.035,
                                                          // circlePading: 0.05,
                                                          size: size,
                                                          icon:
                                                              "assets/partydetail/time.png",
                                                          content:
                                                              "$onlyTime $amPm"),
                                                      // SizedBox(
                                                      //   height: size.height * 0.005,
                                                      // ),
                                                      aboutItems(
                                                          imageHeight: 0.035,
                                                          size: size,
                                                          icon:
                                                              "assets/partydetail/music.png",
                                                          content:
                                                              "${fiestasDetailModel?.data?.filterMusic?.name}"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),

                                            // Description

                                            Container(
                                              width: size.width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.04),
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
                                                      fontFamily:
                                                          Fonts.dmSansBold,
                                                      fontSize:
                                                          size.width * 0.046,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.01),
                                                  Divider(
                                                    color: AppColors.tagBorder,
                                                    thickness: 0.3,
                                                  ),
                                                  SizedBox(
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.01),
                                                  Text(
                                                      // "${getTranslated(context, "lorem")}",
                                                      "${fiestasDetailModel?.data!.description ?? getTranslated(context, "nodataFound")}",
                                                      style: TextStyle(
                                                          fontFamily: "Product",
                                                          fontSize: 14,
                                                          color:
                                                              AppColors.white)),
                                                ],
                                              ),
                                            ),

                                            //>

                                            SizedBox(
                                              height: size.height * 0.05,
                                            ),
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  child: GoogleMap(
                                                    zoomControlsEnabled: false,
                                                    onTap: (latLng) {
                                                      print(
                                                          "Current Value ==> $latLng");
                                                    },
                                                    onMapCreated: _onMapCreated,
                                                    initialCameraPosition:
                                                        CameraPosition(
                                                      target: LatLng(
                                                          double.parse(
                                                              fiestasDetailModel
                                                                      ?.data
                                                                      ?.clubDetail
                                                                      ?.latitude ??
                                                                  "0.0"),
                                                          double.parse(
                                                              fiestasDetailModel
                                                                      ?.data
                                                                      ?.clubDetail
                                                                      ?.longitude ??
                                                                  "0.0")),
                                                      zoom: 10.0,
                                                    ),
                                                    markers: _markers,
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 5,
                                                  child: MaterialButton(
                                                      color: Colors.blue,
                                                      textColor: Colors.white,
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.zoom_in)),
                                                      minWidth:
                                                          size.width * 0.05,

                                                      // Text("Zoom In"),
                                                      onPressed: () {
                                                        setState(() {
                                                          mapZoom = true;
                                                        });
                                                      }),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // heading data

                                            Container(
                                              margin: EdgeInsets.only(
                                                top: size.height * 0.015,
                                                left: size.width * 0.04,
                                                right: size.width * 0.04,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${fiestasDetailModel?.data!.name}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.08,
                                                        fontFamily:
                                                            "DM Sans Bold",
                                                        color: AppColors.white),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.005,
                                                  ),
                                                  ratingstars(
                                                      size: size.width * 0.06,
                                                      ittempading:
                                                          size.width * 0.005,
                                                      color:
                                                          AppColors.tagBorder,
                                                      rating: rating)
                                                ],
                                              ),
                                            ),

                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount:
                                                      UserData.tiketList.length,
                                                  itemBuilder: (
                                                    BuildContext context,
                                                    index,
                                                  ) {
                                                    return ticket(
                                                        context: context,
                                                        index: index,
                                                        mapdata: UserData
                                                            .tiketList[index],
                                                        addFunc: addTicket,
                                                        removeFunc:
                                                            ticketRemove);
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
                                                        width: SizeConfig
                                                            .screenWidth,
                                                        height: SizeConfig
                                                                .screenHeight *
                                                            0.10,
                                                        child: SvgPicture.asset(
                                                          "assets/images/Rectangle.svg",
                                                          fit: BoxFit.fill,
                                                        )),
                                                    Container(
                                                      width: SizeConfig
                                                          .screenWidth,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: size
                                                                      .width *
                                                                  0.03,
                                                              vertical:
                                                                  size.height *
                                                                      0.01),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${getTranslated(context, "addtocart")}",
                                                                // Strings.addtocart,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .brownlite,
                                                                    fontSize:
                                                                        size.width *
                                                                            0.03),
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .screenHeight *
                                                                    0.01,
                                                              ),
                                                              Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/images/ticket.svg",
                                                                      width: size
                                                                              .width *
                                                                          0.07,
                                                                    ),
                                                                    SizedBox(
                                                                      width: size
                                                                              .width *
                                                                          0.02,
                                                                    ),
                                                                    Container(
                                                                      // width: SizeConfig.screenWidth * 0.40,
                                                                      child:
                                                                          Text(
                                                                        "${getTranslated(context, "ticket")} * ${UserData.totalTicketNum}",
                                                                        // "${Strings.ticket} * ${UserData.totalTicketNum}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.white,
                                                                          fontSize:
                                                                              size.width * 0.05,
                                                                          fontFamily:
                                                                              "DM Sans Bold",
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        maxLines:
                                                                            1,
                                                                        softWrap:
                                                                            true,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.04,
                                                          ),
                                                          Spacer(),
                                                          ElevatedButton(
                                                            child: Text(
                                                              "${getTranslated(context, "buyNow")}",
                                                              // Strings.buyNow,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) => BuyNow(
                                                                          fiestasM:
                                                                              fiestasDetailModel)))
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  totalTicket();
                                                                });
                                                              });
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      SizeConfig
                                                                              .screenWidth *
                                                                          0.06,
                                                                  vertical:
                                                                      SizeConfig
                                                                              .screenHeight *
                                                                          0.02),
                                                              primary: AppColors
                                                                  .redlite,
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
                                  ]),
                            ),
                          ),
                          _loadingMainCenter
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox()
                        ],
                      ),
                mapZoom
                    ? Stack(
                        children: [
                          Container(
                            height: size.height,
                            width: size.width,
                            child: GoogleMap(
                              zoomControlsEnabled: false,
                              onTap: (latLng) {
                                print("Current Value ==> $latLng");
                              },
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    double.parse(fiestasDetailModel
                                            ?.data?.clubDetail?.latitude ??
                                        "0.0"),
                                    double.parse(fiestasDetailModel
                                            ?.data?.clubDetail?.longitude ??
                                        "0.0")),
                                zoom: 10.0,
                              ),
                              markers: _markers,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 5,
                            child: MaterialButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Center(child: Icon(Icons.zoom_out)),
                                minWidth: size.width * 0.05,
                                onPressed: () {
                                  setState(() {
                                    mapZoom = false;
                                  });
                                }),
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            )),
      ),
    );
  }

// map navigate
  navigateToMap() {}

  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  void _onAddMarkerButtonPressed() {
    var _currentMapPosition = LatLng(
        double.parse(fiestasDetailModel?.data?.clubDetail?.latitude ?? "0.0"),
        double.parse(fiestasDetailModel?.data?.clubDetail?.longitude ?? "0.0"));
    print("CUrrent ==> ${fiestasDetailModel?.data?.clubDetail?.toJson()}");
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(fiestasDetailModel?.data?.clubId?.toString() ?? "1"),
        position: _currentMapPosition,
        infoWindow: InfoWindow(
            title: fiestasDetailModel?.data?.name ?? "",
            snippet: fiestasDetailModel?.data?.description ?? ""),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.04),
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
}

Widget aboutItems(
    {size,
    String? icon,
    String? content,
    double imageHeight = 0.02,
    double circlePading = 0.023}) {
  return Row(
    children: [
      Container(
          // padding: EdgeInsets.all(size.width * 0.023),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColors.brownLite),
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.04),
          child: Image.asset(
            "$icon",
            height: size.height * imageHeight,
          )),
      Container(
        // width: size.width * 0.7,
        constraints: BoxConstraints(maxWidth: size.width * 0.8),
        child: Text(
          "$content",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              color: AppColors.white,
              fontSize: size.width * 0.045,
              fontFamily: Fonts.dmSansBold),
        ),
      )
    ],
  );
}
