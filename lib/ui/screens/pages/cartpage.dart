import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/ui/screens/address/addressList.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/screens/preFiestasCardDetail.dart';
import 'package:funfy/ui/screens/preFistaOrderMix.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../utils/strings.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({Key? key}) : super(key: key);
  @override
  _CartpageState createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  // PrefiestasCartModel? myCartModel = PrefiestasCartModel();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _loading = false;
  bool _centerLoading = false;
  bool alcoholTrue = false;

  String _totalPrice = "0";
  String _transferCharge = "0";

  // double count = 0.0;

  getMyCart() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      try {
        setState(() {
          _loading = true;
        });
        await getPrefiestasCart().then((res) {
          setState(() {
            _loading = false;
          });
          setState(() {
            UserData.myCartModel = res;

            print("here is cart ${res?.toJson()}");

            bool alco = false;

            for (int i = 0;
                i < int.parse('${res?.data?.cart?.cartItems?.length}');
                i++) {
              print("look here ");

              String data =
                  '${res?.data?.cart?.cartItems![i].preFiesta?.categories}';

              if (data == 'alcohol' || data == 'Alcohol') {
                alco = true;
                print("code break");
                break;
              } else {
                print("code else");
                alco = false;
              }
            }

            alcoholTrue = alco;
          });
        });
      } catch (e) {
        setState(() {
          _loading = false;
          UserData.myCartModel = null;
        });
        print("error in my cart $UserData.myCartModel");
        print(e);
      }
    }
  }

  // - + funtion

  addTicket(
      {int? index, int? type, int itemCount = 0, String? id, var cart}) async {
    // clear

    print("add button press  index: $index  id: $id");
    int cartCount;

    try {
      cartCount = cart[index]["preticketCount"];
    } catch (e) {
      cartCount = itemCount;
    }
    setState(() {
      cartCount = cartCount + 1;
    });

    print("Cart Count: $cartCount");

    await addToCart(id: id, cont: cartCount.toString()).then((value) {
      print("this is value $value");
      if (value) {
        setState(() {
          cart[index] = {
            "id": id,
            "preticketCount": cartCount,
          };
        });

        totalCount2(value: true);

        if (type == 1) {
          var alco = Constants.prefs?.getString('alcohol');
          int alcohol = alco == null ? 0 : int.parse("$alco");

          int tot = alcohol + 1;
          Constants.prefs?.setString("alcohol", "$tot");
        }
      }
    });

    // totalCount();
    print(cart);
  }

  // remove button

  ticketRemove(
      {String? id,
      int itemCount = 0,
      int? index,
      var cart,
      int? itemType}) async {
    print("remove id: $id  index: $index");

    int cartCount;

    try {
      cartCount = cart[index]["preticketCount"];
    } catch (e) {
      cartCount = itemCount;
    }
    setState(() {
      cartCount = cartCount - 1;
    });

    if (cartCount > 0) {
      await addToCart(id: id, cont: cartCount.toString()).then((value) {
        print("this is value $value");
        if (value) {
          setState(() {
            cart[index] = {
              "id": id,
              "preticketCount": cartCount,
            };
          });

          if (cartCount == 0) {
            // setItemValue(type: itemType, valueTureFalse: false);
          }

          if (itemType == 1) {
            var alco = Constants.prefs?.getString('alcohol');
            int alcohol = alco == null ? 0 : int.parse("$alco");

            int tot = alcohol - 1;
            Constants.prefs?.setString("alcohol", "$tot");
          }
          totalCount2(value: false);
        }
      });
    } else {
      print("value is < 2");
    }

    // if (cartCount <= 0 && cart.isNotEmpty && cart.containsKey(index)) {
    //   setState(() {
    //     cart.remove(index);
    //   });
    // }

    // totalCount();
    // print(cart);
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

// remove from list

  ticketremoveFromList(
      {String? id, String? count = "0", int? index, String? type}) async {
    print("look here remove id: $id  count: $count index: $index $type");

    String totnum = Constants.prefs?.getString("cartTot") == null ||
            Constants.prefs?.getString("cartTot") == ""
        ? "0"
        : "${Constants.prefs?.getString("cartTot")}";

    int totalNumnber = int.parse(totnum);

    int totalCount = totalNumnber - int.parse("$count");

    print("here is num here  $totalCount");

    await addToCart(id: id, cont: "0").then((value) {
      if (value) {
        // remove from total
        String totnum = Constants.prefs?.getString("cartTot") == null ||
                Constants.prefs?.getString("cartTot") == ""
            ? "0"
            : "${Constants.prefs?.getString("cartTot")}";

        int totalNumnber = int.parse(totnum);

        int totalCount = totalNumnber - int.parse("$count");

        print("here is num here  $totalCount");

        // Constants.prefs
        //     ?.setString("cartTot", "${totalCount < 0 ? 0 : totalCount}");

        setState(() {
          // myCartModel?.data?.cartItems?.removeAt(index!);
          if (type == "alcohol") {
            UserData.preFiestasAlcoholCart = "";
            int alcohol = Constants.prefs?.getString('alcohol') == null
                ? 0
                : int.parse("${Constants.prefs?.getString('alcohol')}");

            int tot = alcohol - int.parse("$count");

            // tot

            Constants.prefs?.setString("alcohol", "0");
            UserData.preFiestasAlcoholCartMap.clear();

            // print(type);
            // clearCart();
            getMyCart();
          }

          if (type == "mix") {
            // Constants.prefs?.setString("cartTot", "$totalCount");
            UserData.preFiestasMixesTicketCart.clear();

            // UserData.myCartModel?.data?.cart?.cartItems?.removeAt(index!);
            getMyCart();
          }

          if (type == "extras") {
            // Constants.prefs?.setString("cartTot", "$totalCount");
            UserData.preFiestasExtrasTicketCart.clear();
            // UserData.myCartModel?.data?.cart?.cartItems?.removeAt(index!);
            getMyCart();
          }
        });
      }
    });

    //

    // totalCount();
  }

  // total count
  totalCount() {
    print("total Count run");
    print(Constants.prefs?.getString("cartTot"));

    setState(() {
      num tot = 0;

      if (UserData.preFiestasAlcoholCart != "") {
        tot = tot + 1;
        Constants.prefs?.setString("alcohol", "alcohol");
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
      // Constants.prefs?.setString("cartTot", tot.toString());

      print(UserData.totalTicketNum);

      print(UserData.preFiestasMixesTicketCart);
      print(UserData.preFiestasExtrasTicketCart);
      print(UserData.preFiestasAlcoholCart);
    });
  }

  totalCount2({bool? value}) {
    print("total Count run");

// ++
    if (value!) {
      setState(() {
        String totnum = "${Constants.prefs?.getString("cartTot")}" == "null" ||
                "${Constants.prefs?.getString("cartTot")}" == ""
            ? "0"
            : "${Constants.prefs?.getString("cartTot")}";

        int totalNumnber = int.parse(totnum);

        int totalCount = totalNumnber + 1;

        print("here is num $totalCount");

        // Constants.prefs?.setString("cartTot", "$totalCount");
      });
    }

// --

    if (value == false) {
      setState(() {
        String totnum = "${Constants.prefs?.getString("cartTot")}" == "null" ||
                "${Constants.prefs?.getString("cartTot")}" == ""
            ? "0"
            : "${Constants.prefs?.getString("cartTot")}";

        int totalNumnber = int.parse(totnum);

        int totalCount = totalNumnber - 1;

        print("here is num $totalCount");

        Constants.prefs
            ?.setString("cartTot", "${totalCount < 0 ? 0 : totalCount}");
      });
    }
  }

  // pre fiesta cart booking One Func
  Future<bool> addToCart({String? id, String? cont}) async {
    var net = await Internetcheck.check();

    bool? returnV;

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _centerLoading = true;
      });
      try {
        await addproductinCartPrefiestas(
                preFiestaID: id.toString(), quantity: cont.toString())
            .then((res) {
          print("here is res ---------- $id $cont");

          setState(() {
            _centerLoading = false;
          });
          if (res["status"] == true &&
              (res["code"] == 200 || res["code"] == 201)) {
            returnV = true;

            _totalPrice = "${res["data"]["cart"]["total_price"]}";
            _transferCharge = "${res["data"]["cart"]["transfer_charge"]}";

            if (res["data"]["message"] != "You're cart is empty!") {
              UserData.preFiestasCartid = res["data"]["cart"]["id"].toString();
            }
          } else {
            returnV = false;
          }
        });
      } catch (e) {
        getMyCart();
        print("Error here -------------- $e");

        setState(() {
          _centerLoading = false;
          returnV = false;
        });
      }
    }

    return returnV!;
  }

  clearCart() async {
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

  // item cart
  Widget listItem({
    size,
    String? topTile,
    String? title,
    String? descriptionTitle,
    String? price,
    String? quantity,
    bool? boolCount,
    String? pid,
    int? index,
    int? count,
    String? cl,
    Map? cart,
    String? type,
    int? itemTypes,
    required BuildContext context,
  }) {
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //"(${Strings.alcohol})",
            // "${getTranslated(context, "alcohol")}",
            "($topTile) ",
            style: TextStyle(
                color: AppColors.itemDescription,
                fontFamily: Fonts.dmSansRegular,
                fontSize: size.width * 0.03),
          ),
          SizedBox(
            height: size.height * 0.001,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    // width: size.width * 0.42,

                    constraints: BoxConstraints(maxWidth: size.width * 0.42),
                    child: Text(
                      "$title",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppColors.white,
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.045),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (Constants.prefs?.getString("addres") != null &&
                          Constants.prefs?.getString("addres") != '' &&
                          Constants.prefs?.getString("addressId") != null &&
                          Constants.prefs?.getString("addressId") != '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreFistaOrder(
                                    preFiestasID: UserData
                                        .myCartModel?.data?.parentDetail?.id
                                        .toString()))).then((value) {
                          getMyCart();
                        });
                      } else {
                        Dialogs.simpleOkAlertDialog(
                            context: context,
                            content:
                                "${getTranslated(context, 'pleaseAddYourLocation')}",
                            title: "${getTranslated(context, 'alert!')}",
                            func: () {
                              navigatorPushFun(
                                  context,
                                  AddressList(
                                    navNum: 1,
                                  ));
                            });
                      }
                    },
                    child: Text(
                      "${getTranslated(context, "change")}",
                      //Strings.change,
                      style: TextStyle(
                          color: AppColors.siginbackgrond,
                          decoration: TextDecoration.underline,
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.03),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                // String? ncountNunber =  cart!.containsKey(index)
                //                       ? "${cart[index]["preticketCount"]}"
                //                       : count.toString();
                onTap: () {
                  ticketremoveFromList(
                      index: index,
                      count: cart!.containsKey(index)
                          ? "${cart[index]["preticketCount"]}"
                          : count.toString(),
                      id: pid,
                      type: type);
                },
                child: Icon(
                  Icons.close,
                  size: size.width * 0.06,
                  color: AppColors.tagBorder,
                ),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          Text(
            "$cl CL",
            style: TextStyle(
                color: AppColors.itemDescription,
                fontFamily: Fonts.dmSansRegular,
                fontSize: size.width * 0.035),
          ),
          SizedBox(
            height: size.height * 0.003,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslated(context, 'euro')}" '$price',
                //Strings.euro + " " + "28.99",
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: Fonts.dmSansBold,
                    fontSize: size.width * 0.056),
              ),

              // + - buttons

              boolCount == null
                  ? SizedBox()
                  : Container(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              ticketRemove(
                                  index: index,
                                  itemCount: count ?? 0,
                                  id: pid,
                                  cart: cart,
                                  itemType: itemTypes);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: AppColors.white),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.01)),
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
                          InkWell(
                            onTap: () {
                              addTicket(
                                  index: index,
                                  itemCount: count ?? 0,
                                  id: pid,
                                  type: itemTypes,
                                  cart: cart);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.skin,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.01)),
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
                    )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _totalPrice = "0";

    setState(() {
      UserData.preFiestasAlcoholCartMap.clear();
      UserData.preFiestasExtrasTicketCart.clear();
      UserData.preFiestasMixesTicketCart.clear();
    });

    getMyCart();
  }

  // Make Order

  makeOrder() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _centerLoading = true;
      });
    }

    try {
      await makeOrderApi(cartId: UserData.preFiestasCartid, addressId: "2")
          .then((res) {
        // print(res?.toJson().toString());

        setState(() {
          _centerLoading = false;
        });

        if (res?.status == true && res?.code == 201) {
          print("we are here -------------------");

          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => BookingSuccess()),
          //     (route) => false);
        }
      });
    } catch (e) {
      setState(() {
        _centerLoading = false;
      });
      print("error ----------------  $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.blackBackground,
      child: SafeArea(
        child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //     onPressed: () {
            //       print(Constants.prefs?.getString("alcohol"));
            //     },
            //     child: Icon(Icons.local_activity)),
            backgroundColor: HexColor("#191512"),
            body: _loading == false &&
                    (UserData.myCartModel?.data?.cart?.cartItems == [] ||
                        UserData.myCartModel == null)
                ? ordernow(context)
                : SingleChildScrollView(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(children: [
                          // top bar
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.023,
                                  horizontal: size.width * 0.06),
                              width: size.width,
                              height: size.height * 0.155,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(Images.homeTopBannerPng),
                                      fit: BoxFit.cover)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${getTranslated(context, "mycart")}",
                                        //Strings.mycart,
                                        style: TextStyle(
                                            fontFamily: Fonts.dmSansBold,
                                            color: AppColors.white,
                                            fontSize: size.width * 0.065),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: size.width * 0.70,
                                        ),
                                        child: Text(
                                          "${getTranslated(context, "checkyourdeliverableordersstatus")}",
                                          //Strings.checkyourdeliverableordersstatus,
                                          style: TextStyle(
                                              fontFamily: Fonts.dmSansRegular,
                                              color: AppColors.white,
                                              fontSize: size.width * 0.036),
                                        ),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    "assets/svgicons/cartsvg.svg",
                                    width: size.width * 0.07,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: size.height * 0.03,
                          ),

                          // Expanded(
                          //     child: Container(
                          //   color: AppColors.ratingYellow,
                          // )),
                          // center content

                          _loading == true
                              ? Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.33),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : _loading == false &&
                                      (UserData.myCartModel?.data?.cart
                                                  ?.cartItems ==
                                              [] ||
                                          UserData.myCartModel == null)
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.33),
                                      child: Center(
                                        child: Text(
                                          "${getTranslated(context, "nodataFound")}",
                                          // Strings.nodataFound,
                                          style: TextStyle(
                                              color: AppColors.descriptionfirst,
                                              fontFamily: Fonts.dmSansBold,
                                              fontSize: size.width * 0.045),
                                        ),
                                      ))
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.03),
                                      width: size.width,
                                      child: Column(
                                        children: [
                                          roundedBoxBorder(
                                              context: context,
                                              width: size.width,
                                              // height: size.height * 0.58,
                                              borderColor: AppColors.tagBorder,
                                              backgroundColor:
                                                  AppColors.homeBackgroundLite,
                                              borderSize: size.width * 0.002,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.04,
                                                    vertical:
                                                        size.height * 0.015),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 0.6,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${UserData.myCartModel?.data?.parentDetail?.name}",
                                                                // "Pack 'La havanna",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .dmSansBold,
                                                                    fontSize: size
                                                                            .width *
                                                                        0.055),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.008,
                                                              ),
                                                              Text(
                                                                "${UserData.myCartModel?.data?.parentDetail?.description}",
                                                                // "${getTranslated(context, "lorem")}",
                                                                //Strings.lorem,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .dmSansRegular,
                                                                    fontSize: size
                                                                            .width *
                                                                        0.035),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                            height:
                                                                size.height *
                                                                    0.09,
                                                            width: size.width *
                                                                0.2,
                                                            child: Image.network(
                                                                "${UserData.myCartModel?.data?.parentDetail?.image}"))
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                int.parse(
                                                                    "${UserData.myCartModel?.data?.cart?.cartItems?.length}");
                                                            i++)
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.03,
                                                              ),
                                                              listItem(
                                                                  index: i,
                                                                  pid: UserData
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.cart
                                                                      ?.cartItems![
                                                                          i]
                                                                      .preFiesta
                                                                      ?.id
                                                                      .toString(),
                                                                  topTile: UserData
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.cart
                                                                      ?.cartItems![
                                                                          i]
                                                                      .preFiesta
                                                                      ?.categories,
                                                                  title: UserData
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.cart
                                                                      ?.cartItems![
                                                                          i]
                                                                      .preFiesta!
                                                                      .name,
                                                                  price: UserData.myCartModel?.data?.cart?.cartItems![i].price
                                                                      .toString(),
                                                                  quantity: UserData.myCartModel?.data?.cart?.cartItems![i].quantity
                                                                      .toString(),
                                                                  cl: UserData
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.cart
                                                                      ?.cartItems![
                                                                          i]
                                                                      .preFiesta
                                                                      ?.quantityInCl
                                                                      .toString(),
                                                                  size: size,
                                                                  type: UserData
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.cart
                                                                      ?.cartItems![i]
                                                                      .preFiesta
                                                                      ?.categories,
                                                                  // boolCount:
                                                                  //     type?.categories ==
                                                                  //             "alcohol"
                                                                  //         ? null
                                                                  //         : true,

                                                                  boolCount: true,
                                                                  context: context,
                                                                  count: UserData.myCartModel?.data?.cart?.cartItems![i].quantity,
                                                                  cart: UserData.myCartModel?.data?.cart?.cartItems![i].preFiesta?.categories == "mix"
                                                                      ? UserData.preFiestasMixesTicketCart
                                                                      : UserData.myCartModel?.data?.cart?.cartItems![i].preFiesta?.categories == "extras"
                                                                          ? UserData.preFiestasExtrasTicketCart
                                                                          : UserData.preFiestasAlcoholCartMap,
                                                                  itemTypes: UserData.myCartModel?.data?.cart?.cartItems![i].preFiesta?.categories == "alcohol"
                                                                      ? 1
                                                                      : UserData.myCartModel?.data?.cart?.cartItems![i].preFiesta?.categories == "extras"
                                                                          ? 2
                                                                          : 3),
                                                            ],
                                                          ),

                                                        // Total Price

                                                        SizedBox(
                                                          height: size.height *
                                                              0.03,
                                                        ),

                                                        Container(
                                                          // width: SizeConfig
                                                          //         .screenWidth *
                                                          //     0.80,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${getTranslated(context, "transferCharges")}",
                                                                //   "Other Taxes",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        size.width *
                                                                            0.04,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .dmSansMedium),
                                                              ),
                                                              // Spacer(),

                                                              SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.03,
                                                              ),
                                                              Text(
                                                                "${Strings.euro} ${_transferCharge != '0' && _transferCharge != "null" ? double.parse(_transferCharge).toStringAsFixed(2) : double.parse('${UserData.myCartModel?.data?.cart?.transferCharge ?? 0}').toStringAsFixed(2)}",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        size.width *
                                                                            0.04,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .dmSansBold),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: size.height *
                                                              0.012,
                                                        ),
                                                        Container(
                                                          // width: size.width,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text.rich(
                                                              TextSpan(
                                                                  text:
                                                                      "${getTranslated(context, 'totalPrice')} :", // Strings.byContinuingYouAgreetoOur,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          Fonts
                                                                              .dmSansMedium,
                                                                      color: AppColors
                                                                          .white,
                                                                      fontSize:
                                                                          size.width *
                                                                              0.06),
                                                                  children: <
                                                                      InlineSpan>[
                                                                TextSpan(
                                                                  text:
                                                                      " ${Strings.euro} ${_totalPrice != "0" && _totalPrice != "null" ? _totalPrice : UserData.myCartModel?.data?.cart?.totalPrice}", //"${Strings.termsOfService}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          Fonts
                                                                              .dmSansBold,
                                                                      color: AppColors
                                                                          .white,
                                                                      fontSize:
                                                                          size.width *
                                                                              0.06),
                                                                ),
                                                              ])),
                                                          // child: Text(
                                                          //   "${getTranslated(context, 'totalPrice')} : ${Strings.euro} 100",
                                                          //   style: TextStyle(
                                                          //       color:
                                                          //           AppColors.white,
                                                          //       fontFamily:
                                                          //           Fonts.dmSansBold,
                                                          //       fontSize: size.width *
                                                          //           0.06),
                                                          // ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                          SizedBox(height: size.height * 0.02),
                                          Text(
                                              "${getTranslated(context, "thisisFinalstepafteryouTouchingpaynowbuttonthepaymentwillbetransation")}",
                                              // Strings.thisisFinalstepafteryouTouchingpaynowbuttonthepaymentwillbetransation,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.itemDescription,
                                                  fontFamily:
                                                      Fonts.dmSansRegular,
                                                  fontSize: size.width * 0.03)),
                                          SizedBox(height: size.height * 0.03),

                                          // button

                                          GestureDetector(
                                            onTap: () {
                                              UserData
                                                              .myCartModel!
                                                              .data!
                                                              .cart!
                                                              .cartItems!
                                                              .length >
                                                          0 &&
                                                      alcoholTrue == true
                                                  ?
                                                  // makeOrder();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PrefiestasCardDetail())).then(
                                                      (value) {
                                                      initState();
                                                    })
                                                  : Dialogs.showBasicsFlash(
                                                      context: context,
                                                      color: AppColors
                                                          .siginbackgrond,
                                                      duration:
                                                          Duration(seconds: 3),
                                                      content: getTranslated(
                                                          context,
                                                          "pleaseSelectAlcohol"));
                                            },
                                            child: roundedBoxR(
                                              width: size.width,
                                              height: size.height * 0.07,
                                              radius: size.width * 0.02,
                                              backgroundColor:
                                                  AppColors.siginbackgrond,
                                              child: Center(
                                                child: Text(
                                                  "${getTranslated(context, "proceedtopay")}",
                                                  //   Strings.proceedtopay,
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontFamily:
                                                          Fonts.dmSansBold,
                                                      fontSize:
                                                          size.width * 0.045),
                                                ),
                                              ),
                                            ),
                                          )
                                          // : SizedBox()

                                          //  SizedBox(height: size.height * 0.05),
                                        ],
                                      ),
                                    ),
                          SizedBox(
                            height: 50,
                          ),
                        ]),
                        _centerLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox()
                      ],
                    ),
                  )),
      ),
    );
  }
}

Widget ordernow(context) {
  var size = MediaQuery.of(context).size;

  return Container(
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // top bar
            SafeArea(
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.023,
                      horizontal: size.width * 0.045),
                  width: size.width,
                  height: size.height * 0.155,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.homeTopBannerPng),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getTranslated(context, "mycart")}",
                        //  Strings.mycart,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white,
                            fontSize: size.width * 0.065),
                      ),
                      Text(
                        Strings.checkyourdeliverableordersstatus,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansRegular,
                            color: AppColors.white,
                            fontSize: size.width * 0.036),
                      )
                    ],
                  )),
            ),

            SizedBox(
              height: size.height * 0.15,
            ),

            // center content

            Container(
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.4,
                    height: size.height * 0.18,
                    child: SvgPicture.asset(Images.cartEmtySvg),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Text(
                    "${getTranslated(context, "nothingshowincartrightnow")}",
                    //  Strings.nothingshowincartrightnow,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansBold,
                        color: AppColors.white,
                        fontSize: size.width * 0.04),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.15,
            ),

            // content
            Container(
              width: size.width * 0.6,
              child: Text(
                "${getTranslated(context, "buyFiestasandPreFiestasbestdealsinyourcart")}",
                //    Strings.buyFiestasandPreFiestasbestdealsinyourcart,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Fonts.dmSansBold,
                    color: HexColor("#7a6d62"),
                    fontSize: size.width * 0.04),
              ),
            ),

            SizedBox(
              height: size.height * 0.02,
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home(
                          pageIndexNum: 0,
                        )));
              },
              child: roundedBoxBorder(
                  context: context,
                  backgroundColor: HexColor("#191512"),
                  width: size.width * 0.5,
                  height: size.height * 0.05,
                  borderColor: HexColor("#fdedba"),
                  borderSize: size.width * 0.002,
                  child: Align(
                    child: Text(
                      "${getTranslated(context, "orderNow")}",
                      //  Strings.orderNow,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          color: HexColor("#fdedba"),
                          fontSize: size.width * 0.04),
                    ),
                  )),
            ),

            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ));
}
