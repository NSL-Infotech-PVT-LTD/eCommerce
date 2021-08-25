import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/models/prifiestasAlMxEx.dart';
import 'package:funfy/ui/screens/bookingSuccess.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/basic%20function.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:video_player/video_player.dart';
import 'package:funfy/models/prefiestasDetailModel.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class PreFistaOrder extends StatefulWidget {
  final preFiestasID;

  const PreFistaOrder({Key? key, this.preFiestasID}) : super(key: key);

  // const PreFistaOrder({Key? key, this.fiestasModel}) : super(key: key);

  @override
  _PreFistaOrderState createState() => _PreFistaOrderState();
}

class _PreFistaOrderState extends State<PreFistaOrder> {
  int? groupValue = -1;
  int? initvalue = 0;

  CarouselController _carouselController = CarouselController();
  List<Widget> cardList = [];
  List<Widget> alcoholList = [];
  VideoPlayerController? _controller;
  bool pauseBool = false;
  bool _loadingMainCenter = false;

  int alcoholCountNum = 0;

  PrefiestasDetailModel? prefiestasDetailModel = PrefiestasDetailModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loading = false;

  bool _alcoholloading = false;
  bool _mixloading = false;
  bool _extrasloading = false;

  bool _loadingCenter = false;
  bool _loadingBack = false;

  bool _favoriteBool = false;

  // Future<void> _handleRadioValueChange(int? value) async {
  //   setState(() {
  //     alcoholCountNum = Constants.prefs?.getString("alcohol") == null ||
  //             Constants.prefs?.getString("alcohol") == ""
  //         ? 0
  //         : 1;
  //   });
  //   String cartReturnV = await addToCart(
  //       id: "${prefiestasDetailModel?.data?.childData?.alcohol?.elementAt(value!).id}",
  //       cont: "1");

  //   if (cartReturnV == "true") {
  //     setState(() {
  //       groupValue = value;
  //       UserData.preFiestasAlcoholCart =
  //           "${prefiestasDetailModel?.data?.childData?.alcohol?.elementAt(value!).id}";

  //       alcoholCountNum = 1;
  //       Constants.prefs?.setString("alcohol", "alcohol");
  //     });
  //   }

  //   if (cartReturnV == "422") {
  //     Dialogs.simpleAlertDialog(
  //         context: context,
  //         title: "${getTranslated(context, "alert!")}",
  //         content:
  //             "${getTranslated(context, "youhaveselecteddifferentcategoryDoyouwanttoresetCart?")}",
  //         func: () async {
  //           navigatePopFun(context);

  //           setState(() {
  //             _loadingCenter = true;
  //           });

  //           await cartResetPrefiestas(
  //                   preFiestaID:
  //                       "${prefiestasDetailModel?.data?.childData?.alcohol?.elementAt(value!).id}",
  //                   quantity: "1")
  //               .then((resp) {
  //             setState(() {
  //               _loadingCenter = false;
  //             });

  //             print("here is json body $resp");

  //             if (resp["status"] == true && resp["code"] == 201) {
  //               setState(() {
  //                 clearCart();
  //                 groupValue = value;
  //                 UserData.preFiestasAlcoholCart =
  //                     "${prefiestasDetailModel?.data?.childData?.alcohol?.elementAt(value!).id}";

  //                 alcoholCountNum = 1;
  //                 Constants.prefs?.setString("alcohol", "alcohol");
  //               });
  //             }
  //           });
  //         });
  //   }
  // }

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
        await prefiestasAddfavouriteApi(id: widget.preFiestasID.toString())
            .then((res) {
          setState(() {
            _loadingMainCenter = false;
          });

          if (res["status"] == true && res["code"] == 201) {
            print("added in favorite");

            setState(() {
              _favoriteBool = true;
            });
          }
          if (res["status"] == true && res["code"] == 200) {
            print("removed in favorite");
            _favoriteBool = false;
          }
        });
      } catch (e) {
        setState(() {
          _loadingMainCenter = false;
        });
      }
    }
  }

  clearCart() {
    setState(() {
      UserData.preFiestasAlcoholCart = "";
      UserData.preFiestasExtrasTicketCart.clear();
      UserData.preFiestasMixesTicketCart.clear();
      UserData.preFiestasAlcoholCartMap.clear();
      UserData.totalTicketNum = 0;
      UserData.preFiestasCartid = "";
      Constants.prefs?.setString("cartTot", "");
      Constants.prefs?.setString("alcohol", "");
      Constants.prefs?.setString("mix", "");
      Constants.prefs?.setString("extras", "");
    });
  }

  @override
  void initState() {
    alcoholCountNum = Constants.prefs?.getString("alcohol") == null ||
            Constants.prefs?.getString("alcohol") == ""
        ? 0
        : 1;
    getPrefiestasDetailfromApi();
    cardList = List<SlidingBannerProviderDetails>.generate(
        3, (index) => SlidingBannerProviderDetails());
    super.initState();
    // preFiestadatagetFromApi();

    setState(() {
      UserData.preFiestasAlcoholCartMap.clear();
      UserData.preFiestasExtrasTicketCart.clear();
      UserData.preFiestasMixesTicketCart.clear();
    });

    // video
    // _controller = VideoPlayerController.network(
    //     'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
  }

  // pauseButtonHide() {
  //   Timer(Duration(seconds: 3), () {
  //     setState(() {
  //       pauseBool = false;
  //     });
  //   });
  // }

  // + - count button
  Widget insdecButton(
      {int? index,
      int? itemType,
      var count,
      String? pid,
      add,
      remove,
      Map? cart}) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              remove(
                  index: index,
                  id: pid,
                  cart: cart,
                  itemCount: count,
                  itemType: itemType);
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
            cart!.containsKey(index)
                ? "${cart[index]["preticketCount"]}"
                : count.toString(),
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
              if ((Constants.prefs?.getString("alcohol") == null ||
                      Constants.prefs?.getString("alcohol") == "") &&
                  itemType != 1) {
                _scaffoldKey.currentState?.showSnackBar(new SnackBar(
                    duration: Duration(milliseconds: 600),
                    content: new Text(
                        "${getTranslated(context, "pleaseSelectAlcohol")}")));
              } else {
                add(
                    index: index,
                    id: pid,
                    cart: cart,
                    itemCount: count,
                    itemType: itemType);
              }
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
      int? type,
      String? title,
      String? subtitle,
      var model,
      bool? numCount,
      Map? cart,
      addFunc,
      var count,
      removeFunc}) {
    var size = MediaQuery.of(context).size;
    var data = model;

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
        trailing:

            // numCount != true
            //     ? Theme(
            //         data: Theme.of(context).copyWith(
            //           unselectedWidgetColor: AppColors.white,
            //         ),
            //         child: Radio<int?>(
            //             value: index,
            //             groupValue: groupValue != -1
            //                 ? groupValue
            //                 : count, //count == 1 && groupValue != -1 ? count : groupValue,
            //             onChanged: _handleRadioValueChange),
            //       )
            //     :

            Container(
          // color: Colors.blue,
          width: size.width * 0.3,
          child: Row(
            children: [
              Spacer(),
              insdecButton(
                  itemType: type,
                  add: addFunc,
                  remove: removeFunc,
                  index: index,
                  count: count,
                  cart: cart,
                  pid: data[index].id.toString()),
            ],
          ),
        ));
  }

  // prifiestas detail get from api

  getPrefiestasDetailfromApi() async {
    var net = await Internetcheck.check();
    // print("net = $net");

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loadingBack = true;
      });
      try {
        await prefiestasDetailApi(id: widget.preFiestasID.toString())
            .then((res) {
          setState(() {
            prefiestasDetailModel = res;
            _favoriteBool =
                prefiestasDetailModel!.data!.parentData!.isFavourite!;

            print(
                "video Url : ${prefiestasDetailModel!.data!.parentData!.videoUrl}");

            // video
            _controller = VideoPlayerController.network(
                // "https://www.youtube.com/watch?v=637wpikrN7s")
                "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4")
              // "${prefiestasDetailModel!.data!.parentData!.videoUrl ?? 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4'}")
              ..initialize().then((_) {
                setState(() {});
              });

            _loadingBack = false;
          });
        });
      } catch (e) {
        setState(() {
          _loadingBack = false;
        });

        print("error in  $e");
      }
    }
  }

  // - + funtion

  addTicket(
      {int? index,
      int itemCount = 0,
      String? id,
      var cart,
      int? itemType}) async {
    // print("add button press  index: $index  id: $id");

    if (_loadingCenter == false) {
      int cartCount;

      try {
        cartCount = cart[index]["preticketCount"];
      } catch (e) {
        cartCount = itemCount;
      }
      setState(() {
        cartCount = cartCount + 1;
      });

      // print("Here is Map : ${UserData.preFiestasAlcoholCartMap}");

      String returnRes = await addToCart(id: id, cont: cartCount.toString());

      if (returnRes == "true") {
        print("here is type : $itemType");
        setState(() {
          cart[index] = {
            "id": id,
            "preticketCount": cartCount,
          };

          if (itemType == 1) {
            var alco = Constants.prefs?.getString('alcohol');

            int alcohol = alco == null || alco == "" ? 0 : int.parse("$alco");

            print("here is alcohol : $alcohol");

            int tot = alcohol + 1;

            print("tot : $tot");
            Constants.prefs?.setString("alcohol", "$tot");

            print("here is num : ${Constants.prefs?.getString('alcohol')}");
          }
        });

        setItemValue(type: itemType, valueTureFalse: true);

        totalCount(value: true);
      }

      if (returnRes == "422") {
        Dialogs.simpleAlertDialog(
            context: context,
            title: "${getTranslated(context, "alert!")}",
            content:
                "${getTranslated(context, "youhaveselecteddifferentcategoryDoyouwanttoresetCart?")}",
            func: () async {
              navigatePopFun(context);

              setState(() {
                _loadingCenter = true;
              });

              if (itemType != 1) {
                _scaffoldKey.currentState?.showSnackBar(new SnackBar(
                    backgroundColor: AppColors.siginbackgrond,
                    duration: Duration(milliseconds: 700),
                    content: new Text(
                        "${getTranslated(context, "pleaseSelectAlcohol")}")));
                setState(() {
                  _loadingCenter = false;
                });
              } else {
                await cartResetPrefiestas(
                        preFiestaID: id, quantity: cartCount.toString())
                    .then((resp) {
                  setState(() {
                    clearCart();
                    _loadingCenter = false;
                  });

                  if (resp["status"] == true && resp["code"] == 201) {
                    print("here is response : ${resp["code"]}");
                    setState(() {
                      clearCart();
                      cart[index] = {
                        "id": id,
                        "preticketCount": cartCount,
                      };
                      Constants.prefs?.setString("alcohol", "1");

                      totalCount(value: true);
                    });
                  }
                });
              }
            });
      }
    }
  }

  // remove button

  ticketRemove(
      {String? id,
      int itemCount = 0,
      int? index,
      dynamic cart,
      int? itemType}) async {
    // print("remove itemCount: $itemCount id: $id  index: $index");

    if (_loadingCenter == false) {
      int cartCount;

      try {
        cartCount = cart[index]["preticketCount"];
        print("fkndnfjdk  $cartCount");
      } catch (e) {
        cartCount = itemCount;
        print("fkndnfjdkEcceptiopm  $cartCount");
      }
      setState(() {
        cartCount = cartCount - 1;
      });

      print("Actual value ==$cartCount  index: $index  id: $id");
      if (cartCount > -1) {
        String returnRes = await addToCart(id: id, cont: cartCount.toString());
        print("returnRes $returnRes");
        if (returnRes == "true") {
          setState(() {
            cart[index] = {
              "id": id,
              "preticketCount": cartCount,
            };
            if (cartCount == 0) {
              // setItemValue(type: itemType, valueTureFalse: false);
              // alcohol clear cart
              if (itemType == 1) {
                // clearCart();
              }
            }

            if (itemType == 1) {
              var alco = Constants.prefs?.getString('alcohol');
              int alcohol = alco == null ? 0 : int.parse("$alco");

              int tot = alcohol - 1;
              Constants.prefs?.setString("alcohol", "$tot");
            }
            totalCount(
              value: false,
            );
          });
        }
      }

      print(cart);
    }
  }

  // bottom popup

  Widget bottomSheet() {
    var size = MediaQuery.of(context).size;

    String totalNum = Constants.prefs?.getString("cartTot") != "" &&
            Constants.prefs?.getString("cartTot") != null
        ? "${Constants.prefs?.getString("cartTot")}"
        : "0";

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
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svgicons/cartsvg.svg",
                          width: size.width * 0.04,
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "${getTranslated(context, "addtocart")}",
                          // Strings.addtocart,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: size.width * 0.03),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.008,
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Container(
                        child: Text(
                          "${int.parse(totalNum)}  ${getTranslated(context, "item")}",
                          // "${Strings.ticket} * ${UserData.totalTicketNum}",
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
                    "${getTranslated(context, "viewcart")}",
                    // 'Buy Now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // makeOrder();
                    navigatorPushFun(
                        context,
                        Home(
                          pageIndexNum: 1,
                        ));
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

  // set item value in share preference

  setItemValue({int? type, bool? valueTureFalse}) {
    setState(() {
      // if (type == 1) {
      //   Constants.prefs?.setString("alcohol", "${valueTureFalse! ? type : ''}");
      // }

      if (type == 2) {
        Constants.prefs?.setString("mix", "${valueTureFalse! ? type : ''}");
      }

      if (type == 3) {
        Constants.prefs?.setString("extras", "${valueTureFalse! ? type : ''}");
      }
    });
  }

  // total count
  totalCount({bool? value}) {
    print("total Count run");

// ++
    if (value!) {
      setState(() {
        String totnum = Constants.prefs?.getString("cartTot") == null ||
                Constants.prefs?.getString("cartTot") == ""
            ? "0"
            : "${Constants.prefs?.getString("cartTot")}";

        // print("here is tot num - $totnum");

        int totalNumnber = int.parse(totnum);

        int totalCount = totalNumnber + 1;

        Constants.prefs?.setString("cartTot", "$totalCount");
      });
    }

// --

    if (value == false) {
      setState(() {
        String totnum = Constants.prefs?.getString("cartTot") == null ||
                Constants.prefs?.getString("cartTot") == ""
            ? "0"
            : "${Constants.prefs?.getString("cartTot")}";

        int totalNumnber = int.parse(totnum);

        int totalCount = totalNumnber - 1;

        print("here is num $totalCount");

        if (totalCount > 0) {
          Constants.prefs?.setString("cartTot", "$totalCount");
        }
      });
    }
  }

  // pre fiesta cart booking One Func
  Future<String> addToCart({String? id, String? cont}) async {
    var net = await Internetcheck.check();

    String? returnV;

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loadingCenter = true;
      });
      try {
        await addproductinCartPrefiestas(preFiestaID: id, quantity: cont)
            .then((res) async {
          setState(() {
            _loadingCenter = false;
          });
          if (res["status"] == true &&
              (res["code"] == 200 || res["code"] == 201)) {
            if (res["code"] == 201) {
              UserData.preFiestasCartid = "${res['data']['cart']['id']}";
            }
            setState(() {
              returnV = "true";
            });
          }

          if (res["status"] == false && res["code"] == 422) {
            setState(() {
              returnV = "422";
            });
          }
        });
      } catch (e) {
        print("Error ------------  $e");

        setState(() {
          _loadingCenter = false;
          returnV = "false";
        });
      }
    }

    print("last value bool $returnV");
    return returnV!;
  }

// reset value cart
  Future<bool> resetCart({String? id, String? cont}) async {
    setState(() {
      _loadingCenter = true;
    });

    await cartResetPrefiestas(preFiestaID: id, quantity: cont).then((resp) {
      setState(() {
        _loadingCenter = false;
      });

      print("here is json body $resp");

      if (resp["status"] == true && resp["code"] == 201) {
        print("Just for check");
        clearCart();
        return true;
      }
    });

    return false;
  }

  // Make Order

  makeOrder() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loadingMainCenter = true;
      });
    }

    try {
      await makeOrderApi(cartId: UserData.preFiestasCartid, addressId: "2")
          .then((res) {
        // print(res?.toJson().toString());

        setState(() {
          _loadingMainCenter = false;
        });

        if (res?.status == true && res?.code == 201) {
          clearCart();
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => BookingSuccess()),
          //     (route) => false);
        }
      });
    } catch (e) {
      setState(() {
        _loadingMainCenter = false;
      });
      print("error $e");
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

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     print("here is ");
          //     print(Constants.prefs?.getString("alcohol"));
          //   },
          //   child: Icon(Icons.add),
          // ),
          appBar: AppBar(
            backgroundColor: AppColors.blackBackground,
            title: Text("Pre-Fiestas"),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  addFavorite();
                },
                child: Container(
                  margin: EdgeInsets.only(right: size.width * 0.04),
                  child: SvgPicture.asset(
                    "assets/svgicons/hearticon.svg",
                    color: _favoriteBool ? Colors.red : Colors.white,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: AppColors.homeBackground,
          bottomSheet: _loadingBack == false &&
                  (Constants.prefs?.getString("alcohol") != null &&
                      Constants.prefs?.getString("alcohol") != "" &&
                      Constants.prefs?.getString("alcohol") != "0")
              ? bottomSheet()
              : SizedBox(),
          body: _loadingBack == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
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
                              automaticallyImplyLeading: false,
                              // actions: [
                              //   GestureDetector(
                              //     onTap: () {
                              //       addFavorite();
                              //     },
                              //     child: Container(
                              //       margin: EdgeInsets.only(
                              //           right: size.width * 0.04),
                              //       child: SvgPicture.asset(
                              //         "assets/svgicons/hearticon.svg",
                              //         color: _favoriteBool
                              //             ? Colors.red
                              //             : Colors.white,
                              //       ),
                              //     ),
                              //   )
                              // ],
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
                                                            aspectRatio:
                                                                _controller!
                                                                    .value
                                                                    .aspectRatio,
                                                            child: VideoPlayer(
                                                                _controller!),
                                                          )
                                                        : Container()),
                                                Center(
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _controller!.value
                                                                  .isPlaying
                                                              ? _controller
                                                                  ?.pause()
                                                              : _controller
                                                                  ?.play();
                                                        });
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          _controller!.value
                                                                  .isPlaying
                                                              ? Icon(
                                                                  Icons.pause,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  size:
                                                                      size.width *
                                                                          0.11,
                                                                )
                                                              : SizedBox(),
                                                          _controller!.value
                                                                      .isPlaying ==
                                                                  false
                                                              ? Container(
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    Images
                                                                        .playSvg,
                                                                    width: size
                                                                            .width *
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
                                              width:
                                                  SizeConfig.screenWidth * 0.60,
                                              //   height: SizeConfig.screenHeight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    // left: SizeConfig.screenWidth * 0.02,
                                                    top: size.width * 0.01),
                                                child: Text(
                                                  "${prefiestasDetailModel?.data?.parentData?.name}",
                                                  // "${widget.prefiestasdataMap!["name"] ?? "Name"}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.058,
                                                      fontFamily:
                                                          "DM Sans Bold",
                                                      color: AppColors.white),
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // cvfbgtkl;./
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              //   height: SizeConfig.screenHeight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    // left: SizeConfig.screenWidth * 0.02,
                                                    top: size.width * 0.01),
                                                child: topHeadingContent(
                                                    description:
                                                        "${prefiestasDetailModel?.data?.parentData?.description}",

                                                    // widget
                                                    //         .prefiestasdataMap![
                                                    //     "description"],
                                                    textEnd:
                                                        " ${Strings.muchMore}"),
                                              ),
                                            ),
                                            SizedBox(
                                                height: size.height * 0.005),
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
                                          // Strings.alcohol
                                          "${getTranslated(context, "alcohol")}",
                                        ),
                                      ),
                                      Tab(
                                        icon: Text(
                                          "${getTranslated(context, "mixes")}",
                                          // Strings.mixes
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
                        body: Stack(
                          children: [
                            TabBarView(children: [
                              // alcohol

                              (prefiestasDetailModel
                                              ?.data?.childData?.alcohol ==
                                          null ||
                                      prefiestasDetailModel
                                              ?.data?.childData?.alcohol ==
                                          [])
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
                                            width:
                                                SizeConfig.screenWidth * 0.95,
                                            child: richText("Select at most ",
                                                "One", " from Mixes"),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: prefiestasDetailModel
                                                      ?.data
                                                      ?.childData
                                                      ?.alcohol
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return alcoholGradientFunction(
                                                    type: 1,
                                                    index: index,
                                                    model: prefiestasDetailModel
                                                        ?.data
                                                        ?.childData
                                                        ?.alcohol,
                                                    addFunc: addTicket,
                                                    cart: UserData
                                                        .preFiestasAlcoholCartMap,
                                                    count: prefiestasDetailModel
                                                        ?.data
                                                        ?.childData
                                                        ?.alcohol
                                                        ?.elementAt(index)
                                                        .isInMyCartQuantity,
                                                    removeFunc: ticketRemove,
                                                    numCount: true);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                              // mix

                              (prefiestasDetailModel?.data?.childData?.mix ==
                                          null ||
                                      prefiestasDetailModel
                                              ?.data?.childData?.mix ==
                                          [])
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
                                            width:
                                                SizeConfig.screenWidth * 0.95,
                                            child: richText("Select at most ",
                                                "One", " from Mixes"),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: prefiestasDetailModel
                                                      ?.data
                                                      ?.childData
                                                      ?.mix
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return alcoholGradientFunction(
                                                    type: 2,
                                                    index: index,
                                                    model: prefiestasDetailModel
                                                        ?.data?.childData?.mix,
                                                    addFunc: addTicket,
                                                    cart: UserData
                                                        .preFiestasMixesTicketCart,
                                                    count: prefiestasDetailModel
                                                        ?.data?.childData?.mix
                                                        ?.elementAt(index)
                                                        .isInMyCartQuantity,
                                                    removeFunc: ticketRemove,
                                                    numCount: true);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                              // extras

                              (prefiestasDetailModel?.data?.childData?.extras ==
                                          null ||
                                      prefiestasDetailModel
                                              ?.data?.childData?.extras ==
                                          [])
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
                                            width:
                                                SizeConfig.screenWidth * 0.95,
                                            child: richText("Select at most ",
                                                "One", " from Mixes"),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: prefiestasDetailModel
                                                      ?.data
                                                      ?.childData
                                                      ?.extras
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return alcoholGradientFunction(
                                                    type: 3,
                                                    index: index,
                                                    model: prefiestasDetailModel
                                                        ?.data
                                                        ?.childData
                                                        ?.extras,
                                                    addFunc: addTicket,
                                                    cart: UserData
                                                        .preFiestasExtrasTicketCart,
                                                    count: prefiestasDetailModel
                                                        ?.data
                                                        ?.childData
                                                        ?.extras
                                                        ?.elementAt(index)
                                                        .isInMyCartQuantity,
                                                    removeFunc: ticketRemove,
                                                    numCount: true);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ]),
                            _loadingCenter
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),

                    // loading

                    _loadingMainCenter
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox()
                  ],
                )),
    );
  }
}
