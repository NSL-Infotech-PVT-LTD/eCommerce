import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/shortPrices.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/models/prifiestasAlMxEx.dart';
import 'package:funfy/ui/screens/bookNowBeta.dart';
import 'package:funfy/ui/screens/bookingSuccess.dart';
import 'package:funfy/ui/screens/pages/BookNow.dart';
import 'package:funfy/ui/widgets/basic%20function.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:video_player/video_player.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class PreFistaOrder extends StatefulWidget {
  final ProductInfo? prefiestasModel;

  const PreFistaOrder({Key? key, this.prefiestasModel}) : super(key: key);

  // const PreFistaOrder({Key? key, this.fiestasModel}) : super(key: key);

  @override
  _PreFistaOrderState createState() => _PreFistaOrderState();
}

class _PreFistaOrderState extends State<PreFistaOrder> {
  int? groupValue = -1;
  int? initvalue = 0;

  CarouselController _carouselController = CarouselController();
  List<Widget> cardList = [];
  double _initialRating = 2.0;
  bool _isVertical = false;
  String name = "Loading...";
  String description = "Loading...";
  String freeDeliveryReturn = "Loading...";
  String price = "Loading...";
  List<Widget> alcoholList = [];
  VideoPlayerController? _controller;
  bool pauseBool = false;

// model data
  PrefiestasAlMxExModel? alcohol;
  PrefiestasAlMxExModel? mix;
  PrefiestasAlMxExModel? extras;
  bool _loading = false;

  bool _loadingCenter = false;

  void _handleRadioValueChange(int? value) {
    setState(() {
      groupValue = value;

      UserData.preFiestasAlcoholCart =
          "${alcohol!.data!.data!.elementAt(int.parse(value.toString())).id}";

      totalCount();
    });
  }

  clearCart() {
    setState(() {
      UserData.preFiestasAlcoholCart = "";
      UserData.preFiestasExtrasTicketCart.clear();
      UserData.preFiestasMixesTicketCart.clear();
      UserData.totalTicketNum = 0;
    });
  }

  @override
  void initState() {
    cardList = List<SlidingBannerProviderDetails>.generate(
        3, (index) => SlidingBannerProviderDetails());
    super.initState();
    preFiestadatagetFromApi();

    // video
    _controller = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  pauseButtonHide() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        pauseBool = false;
      });
    });
  }

  // + - count button
  Widget insdecButton({int? index, String? pid, add, remove, Map? cart}) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              remove(index: index, id: pid, cart: cart);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.white),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 0.01)),
              ),
              height: SizeConfig.screenHeight * 0.035,
              width: SizeConfig.screenWidth * 0.075,
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
            cart!.containsKey(index) ? "${cart[index]["preticketCount"]}" : "0",
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
              add(index: index, id: pid, cart: cart);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.skin,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 0.01)),
              ),
              height: SizeConfig.screenHeight * 0.035,
              width: SizeConfig.screenWidth * 0.075,
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
      ),
    );
  }

  ListTile alcoholGradientFunction(
      {index,
      String? title,
      String? subtitle,
      PrefiestasAlMxExModel? model,
      bool? numCount,
      Map? cart,
      addFunc,
      removeFunc}) {
    var size = MediaQuery.of(context).size;
    var data = model?.data?.data;
    return ListTile(
        title: Text("${data![index].name}",
            style: TextStyle(
                color: AppColors.white,
                fontFamily: Fonts.dmSansBold,
                fontSize: SizeConfig.screenWidth * 0.045)),
        subtitle: Text("70 CL",
            style: TextStyle(
                color: AppColors.grayFont,
                fontFamily: Fonts.dmSansBold,
                fontSize: SizeConfig.screenWidth * 0.040)),
        trailing: numCount != true
            ? Radio<int?>(
                value: index,
                groupValue: groupValue,
                onChanged: _handleRadioValueChange)
            : Container(
                width: size.width * 0.25,
                child: insdecButton(
                    add: addFunc,
                    remove: removeFunc,
                    index: index,
                    cart: cart,
                    pid: data[index].id.toString()),
              ));
  }

  // get data from api

  preFiestadatagetFromApi() async {
    var net = await Internetcheck.check();
    print("net = $net");

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });

      try {
        alcohollistget();
        mixlistget();
        extraslistget();
      } catch (e) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  // alcohol

  alcohollistget() async {
    await prefiestasAlMxExApi(
            id: widget.prefiestasModel?.id.toString(),
            categoriesName: Strings.alcohols)
        .then((res) {
      if (res?.status == true) {
        setState(() {
          alcohol = res;
          _loading = false;
        });
      } else {
        setState(() {
          alcohol = PrefiestasAlMxExModel();
          _loading = false;
        });
      }
    });
  }

  // mixes

  mixlistget() async {
    await prefiestasAlMxExApi(
            id: widget.prefiestasModel?.id.toString(),
            categoriesName: Strings.mixs)
        .then((res) {
      if (res?.status == true) {
        setState(() {
          mix = res;
          _loading = false;
        });
      } else {
        setState(() {
          mix = PrefiestasAlMxExModel();
          _loading = false;
        });
      }
    });
  }

  // extras

  extraslistget() async {
    await prefiestasAlMxExApi(
            id: widget.prefiestasModel?.id.toString(),
            categoriesName: Strings.extrass)
        .then((res) {
      if (res?.status == true) {
        setState(() {
          extras = res;
          _loading = false;
        });
      } else {
        setState(() {
          extras = PrefiestasAlMxExModel();
          _loading = false;
        });
      }
    });
  }

  // - + funtion

  addTicket({int? index, String? id, var cart}) {
    print("add button press  index: $index  id: $id");

    setState(() {
      if (cart!.containsKey(index)) {
        cart[index]["preticketCount"] = cart[index]["preticketCount"] + 1;
      } else {
        cart[index] = {
          "id": id,
          "preticketCount": 1,
        };
      }
    });

    totalCount();
    print(cart);
  }

  // remove button

  ticketRemove({String? id, int? index, var cart}) {
    print("remove id: $id  index: $index");

    setState(() {
      if (cart.isNotEmpty) {
        if (cart.containsKey(index) && cart[index]["preticketCount"] > 1) {
          cart[index]["preticketCount"] = cart[index]["preticketCount"] - 1;
        } else {
          cart.remove(index);
        }
      } else {
        // clearCart();
      }
    });
    totalCount();
    print(cart);
  }

  // bottom popup

  Widget bottomSheet() {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
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
                horizontal: size.width * 0.03, vertical: size.height * 0.01),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${getTranslated(context, "addtocart")}",
                      // Strings.addtocart,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.brownlite,
                          fontSize: size.width * 0.03),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.01,
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                    "${getTranslated(context, "buyNow")}",
                    // 'Buy Now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    preFiestaCartBookingCart();
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(
                    //         builder: (context) => BuyNow(
                    //             fiestasId: widget
                    //                 .fiestasModel?.id)))
                    //     .then((value) {
                    //   setState(() {
                    //     totalTicket();
                    //   });
                    // });
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
          )
        ],
      ),
    );
  }

  // total count
  totalCount() {
    print("total Count run");

    setState(() {
      num tot = 0;

      if (UserData.preFiestasAlcoholCart != "") {
        tot = tot + 1;
      }

      if (UserData.preFiestasMixesTicketCart.isNotEmpty) {
        for (var i in UserData.preFiestasMixesTicketCart.values.toList()) {
          tot = tot + i["preticketCount"];
        }
      }

      if (UserData.preFiestasExtrasTicketCart.isNotEmpty) {
        for (var i in UserData.preFiestasExtrasTicketCart.values.toList()) {
          tot = tot + i["preticketCount"];
        }
      }

      UserData.totalTicketNum = tot;

      print(UserData.totalTicketNum);
    });
  }

  // pre fiesta cart booking cart

  preFiestaCartBookingCart() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loadingCenter = true;
      });
      try {
        String? statusCode = "0";
        if (UserData.preFiestasAlcoholCart != "") {
          await preFiestaBookingApi(preFiestaID: UserData.preFiestasAlcoholCart)
              .then((res) {
            setState(() {
              statusCode = res?["code"].toString();
            });
          });
        }

        if (UserData.preFiestasMixesTicketCart.isNotEmpty) {
          for (var i in UserData.preFiestasMixesTicketCart.values.toList()) {
            await preFiestaBookingApi(
                    preFiestaID: i["id"],
                    quantity: i["preticketCount"].toString())
                .then((res) {
              setState(() {
                statusCode = res?["code"].toString();
              });
            });
          }
        }

        if (UserData.preFiestasExtrasTicketCart.isNotEmpty) {
          for (var i in UserData.preFiestasMixesTicketCart.values.toList()) {
            await preFiestaBookingApi(
                    preFiestaID: i["id"],
                    quantity: i["preticketCount"].toString())
                .then((res) {
              setState(() {
                statusCode = res?["code"].toString();
              });
            });
          }
        }

        // preFiestaBookingApi().then((res){});

        if (statusCode == "201") {
          setState(() {
            _loadingCenter = false;
            clearCart();
          });

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BookingSuccess()),
              (route) => false);
        } else {
          print(statusCode);
        }
      } catch (e) {
        setState(() {
          _loadingCenter = false;
        });
        print("error in preFiesta Bokking $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // inner heading
    Widget richText(
      String textStart,
      String textMiddle,
      String textEnd,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: size.width * 0.04),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.045,
                    fontFamily: Fonts.dmSansRegular,
                    color: AppColors.white),
                children: <TextSpan>[
                  TextSpan(
                      text: textStart,
                      style: TextStyle(color: AppColors.descriptionfirst)),
                  TextSpan(
                      text: textMiddle,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: textEnd,
                      style: TextStyle(color: AppColors.descriptionfirst)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          DottedLine(
            dashGapLength: size.width * 0.005,
            dashLength: size.width * 0.004,
            dashColor: AppColors.descriptionfirst,
          )
        ],
      );
    }

    // top heading
    Widget topHeadingContent({
      String? description,
      String? textEnd,
    }) {
      return RichText(
        maxLines: 3,
        text: TextSpan(
          style: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.04,
              fontFamily: Fonts.dmSansMedium,
              color: AppColors.white),
          children: <TextSpan>[
            TextSpan(
                text: description,
                style: TextStyle(color: AppColors.descriptionfirst)),
            TextSpan(
                text: textEnd, style: TextStyle(fontFamily: Fonts.dmSansBold)),
          ],
        ),
      );
    }

    // alcoholList =
    //     List<Widget>.generate(10, (index) => alcoholGradientFunction(index));

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.homeBackground,
          bottomSheet: UserData.preFiestasExtrasTicketCart.isNotEmpty ||
                  UserData.preFiestasMixesTicketCart.isNotEmpty ||
                  UserData.preFiestasAlcoholCart != ""
              ? bottomSheet()
              : SizedBox(),
          body: Stack(
            children: [
              DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        // backgroundColor: AppColors.white,
                        collapsedHeight: 150.0,
                        expandedHeight: 200.0,
                        floating: true,
                        pinned: true,
                        snap: true,
                        actions: [
                          Container(
                            margin: EdgeInsets.only(right: size.width * 0.04),
                            child: SvgPicture.asset(
                              "assets/svgicons/hearticon.svg",
                              color: Colors.white,
                            ),
                          )
                        ],
                        actionsIconTheme: IconThemeData(opacity: 0.0),
                        flexibleSpace: Stack(
                          children: <Widget>[
                            Container(
                                color: AppColors.blackBackground,
                                height: size.height,
                                width: size.width),
                            Positioned.fill(
                                child: _controller!.value.isInitialized
                                    ? Stack(
                                        children: [
                                          Center(
                                              child: _controller!
                                                      .value.isInitialized
                                                  ? AspectRatio(
                                                      aspectRatio: _controller!
                                                          .value.aspectRatio,
                                                      child: VideoPlayer(
                                                          _controller!),
                                                    )
                                                  : Container()),
                                          Center(
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _controller!.value.isPlaying
                                                        ? _controller?.pause()
                                                        : _controller?.play();
                                                  });
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    _controller!.value.isPlaying
                                                        ? Icon(
                                                            Icons.pause,
                                                            color:
                                                                AppColors.white,
                                                            size: size.width *
                                                                0.11,
                                                          )
                                                        : SizedBox(),
                                                    _controller!.value
                                                                .isPlaying ==
                                                            false
                                                        ? Container(
                                                            child: SvgPicture
                                                                .asset(
                                                              Images.playSvg,
                                                              width:
                                                                  size.width *
                                                                      0.11,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                )

                                                // child: _controller!.value.isPlaying
                                                //     ?  Icon(
                                                //         Icons.pause,
                                                //         color: AppColors.white,
                                                //         size: size.width * 0.11,
                                                //       )
                                                //     :  Container(
                                                //         child: SvgPicture.asset(
                                                //           Images.playSvg,
                                                //           width: size.width * 0.11,
                                                //         ),
                                                //       )

                                                //  Icon(
                                                //     Icons.play_arrow,
                                                //     color: Colors.white,
                                                //   ),
                                                ),
                                          )
                                        ],
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      )),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // cvfbgtkl;./
                                        width: SizeConfig.screenWidth * 0.60,
                                        //   height: SizeConfig.screenHeight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              // left: SizeConfig.screenWidth * 0.02,
                                              top: size.width * 0.01),
                                          child: Text(
                                            "${widget.prefiestasModel?.name ?? "Name"}",
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
                                      Container(
                                        // cvfbgtkl;./
                                        width: SizeConfig.screenWidth * 0.85,
                                        //   height: SizeConfig.screenHeight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              // left: SizeConfig.screenWidth * 0.02,
                                              top: size.width * 0.01),
                                          child: topHeadingContent(
                                              description: widget
                                                  .prefiestasModel?.description,
                                              textEnd: " ${Strings.muchMore}"),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.005),
                                    ],
                                  ),
                                  Spacer(),
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
                                  icon: Text(
                                      "${getTranslated(context, "alcohol")}",
                                      //Strings.alcohol
                                  ),
                                ),
                                Tab(
                                  icon: Text(
                                      "${getTranslated(context, "mixes")}",
                                      //Strings.mixes
                                  ),
                                ),
                                Tab(
                                  icon: Text(
                                      "${getTranslated(context, "extras")}",
                                      // Strings.extras
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
                    _loading == true
                        ? Center(child: CircularProgressIndicator())
                        : _loading == false && alcohol?.data?.data == []
                            ? Center(
                                child: Text(
                                  "${getTranslated(context, "nodataFound")}",
                                  //Strings.nodataFound,
                                  style: TextStyle(
                                      color: AppColors.descriptionfirst,
                                      fontFamily: Fonts.dmSansBold,
                                      fontSize: size.width * 0.045),
                                ),
                              )
                            : Container(
                                color: AppColors.homeBackgroundLite,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.03,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.95,
                                      child: richText("Select at most ", "One", " from Alcohols"),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            alcohol?.data?.data?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return alcoholGradientFunction(
                                              index: index,
                                              numCount: false,
                                              cart: UserData
                                                  .preFiestasExtrasTicketCart,
                                              model: alcohol);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    _loading == true
                        ? Center(child: CircularProgressIndicator())
                        : _loading == false && mix?.data?.data == []
                            ? Center(
                                child: Text(
                                  "${getTranslated(context, "nodataFound")}",
                                 // Strings.nodataFound,
                                  style: TextStyle(
                                      color: AppColors.descriptionfirst,
                                      fontFamily: Fonts.dmSansBold,
                                      fontSize: size.width * 0.045),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(8.0),
                                color: AppColors.homeBackgroundLite,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: SizeConfig.screenWidth * 0.95,
                                        child: richText("Select at most ",
                                            "Two", " from Mixes")),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: mix?.data?.data?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return alcoholGradientFunction(
                                              index: index,
                                              model: mix,
                                              cart: UserData
                                                  .preFiestasMixesTicketCart,
                                              addFunc: addTicket,
                                              removeFunc: ticketRemove,
                                              numCount: true);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                    // extras
                    _loading == true
                        ? Center(child: CircularProgressIndicator())
                        : _loading == false && extras?.data?.data == []
                            ? Center(
                                child: Text(
                                  "${getTranslated(context, "nodataFound")}",
                                  // Strings.nodataFound,
                                  style: TextStyle(
                                      color: AppColors.descriptionfirst,
                                      fontFamily: Fonts.dmSansBold,
                                      fontSize: size.width * 0.045),
                                ),
                              )
                            : Container(
                                color: AppColors.homeBackgroundLite,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.95,
                                      child: richText("Select at most ", "One",
                                          " from Mixes"),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            extras?.data?.data?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return alcoholGradientFunction(
                                              index: index,
                                              model: extras,
                                              addFunc: addTicket,
                                              cart: UserData
                                                  .preFiestasExtrasTicketCart,
                                              removeFunc: ticketRemove,
                                              numCount: true);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ]),
                ),
              ),

              // loading

              _loadingCenter
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox()
            ],
          )),
    );
  }
}
