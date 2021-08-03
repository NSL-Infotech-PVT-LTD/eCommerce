import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/introApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/preFiestasCartModel.dart';
import 'package:funfy/ui/screens/bookingSuccess.dart';
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
  PrefiestasCartModel? myCartModel = PrefiestasCartModel();
  bool _loading = false;
  bool _centerLoading = false;

  double count = 0.0;

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
            myCartModel = res;
            print("error $myCartModel");

            print(res?.toJson());

            count =
                double.parse("${myCartModel?.data?.cart?.cartItems?.length}") /
                        10 +
                    0.15;
          });
        });
      } catch (e) {
        setState(() {
          _loading = false;
          myCartModel = null;
        });
        print("error in my cart $myCartModel");
        print(e);
      }
    }
  }

  // - + funtion

  addTicket({int? index, int itemCount = 0, String? id, var cart}) async {
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

    print("Cart Count: ${cartCount}");

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
      }
    });

    // totalCount();
    print(cart);
  }

  // remove button

  ticketRemove({String? id, int itemCount = 0, int? index, var cart}) async {
    print("remove id: $id  index: $index");

    print("here count num - $itemCount");

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

// remove from list

  ticketremoveFromList({String? id, int? index, String? type}) async {
    print("look here remove id: $id  index: $index $type");

    await addToCart(id: id, cont: "0").then((value) {
      if (value) {
        setState(() {
          // myCartModel?.data?.cartItems?.removeAt(index!);
          if (type == "alcohol") {
            UserData.preFiestasAlcoholCart = "";
            print(type);
            clearCart();
            getMyCart();
          }

          if (type == "mix") {
            UserData.preFiestasMixesTicketCart.clear();
            myCartModel?.data?.cart?.cartItems?.removeAt(index!);
          }

          if (type == "extras") {
            UserData.preFiestasExtrasTicketCart.clear();
            myCartModel?.data?.cart?.cartItems?.removeAt(index!);
          }
        });
      }
    });

    totalCount();
  }

  // total count
  totalCount() {
    print("total Count run");

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
      Constants.prefs?.setString("cartTot", tot.toString());

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

        Constants.prefs?.setString("cartTot", "$totalCount");
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

        Constants.prefs?.setString("cartTot", "$totalCount");
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

            if (res["data"]["message"] != "You're cart is empty!") {
              UserData.preFiestasCartid = res["data"]["cart"]["id"].toString();
            }
          } else {
            returnV = false;
          }
        });
      } catch (e) {
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
      UserData.totalTicketNum = 0;
      UserData.preFiestasCartid = "";
      Constants.prefs?.setString("cartTot", "");
      Constants.prefs?.setString("alcohol", "");
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
    Map? cart,
    String? type,
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
            "($topTile)",
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
                  Text(
                    "$title",
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: Fonts.dmSansBold,
                        fontSize: size.width * 0.045),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      // print(
                      //     "Look here pid - ${myCartModel?.data?.parentDetail?.id}");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreFistaOrder(
                                  preFiestasID: myCartModel
                                      ?.data?.parentDetail?.id
                                      .toString()))).then((value) {
                        getMyCart();
                      });
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
                onTap: () {
                  ticketremoveFromList(index: index, id: pid, type: type);
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
            "70 CL",
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
                          GestureDetector(
                            onTap: () {
                              ticketRemove(
                                  index: index,
                                  itemCount: count ?? 0,
                                  id: pid,
                                  cart: cart);
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
                          GestureDetector(
                            onTap: () {
                              addTicket(
                                  index: index,
                                  itemCount: count ?? 0,
                                  id: pid,
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
    setState(() {
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

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BookingSuccess()),
              (route) => false);
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
            //       print("cart clear");
            //       clearCart();
            //     },
            //     child: Icon(Icons.local_activity)),
            backgroundColor: HexColor("#191512"),
            body: SingleChildScrollView(
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
                                image: AssetImage(Images.homeTopBannerPng),
                                fit: BoxFit.cover)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            margin: EdgeInsets.only(top: size.height * 0.33),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : _loading == false &&
                                (myCartModel?.data?.cart?.cartItems == [] ||
                                    myCartModel == null)
                            ? Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.33),
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
                                              horizontal: size.width * 0.04,
                                              vertical: size.height * 0.015),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: size.width * 0.6,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${myCartModel?.data?.parentDetail?.name}",
                                                          // "Pack 'La havanna",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontFamily: Fonts
                                                                  .dmSansBold,
                                                              fontSize:
                                                                  size.width *
                                                                      0.055),
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.008,
                                                        ),
                                                        Text(
                                                          "${myCartModel?.data?.parentDetail?.description}",
                                                          // "${getTranslated(context, "lorem")}",
                                                          //Strings.lorem,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontFamily: Fonts
                                                                  .dmSansRegular,
                                                              fontSize:
                                                                  size.width *
                                                                      0.035),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                      height:
                                                          size.height * 0.09,
                                                      width: size.width * 0.2,
                                                      child: Image.network(
                                                          "${myCartModel?.data?.parentDetail?.image}"))
                                                ],
                                              ),
                                              Container(
                                                height: size.height * count,
                                                child: ListView.builder(
                                                    itemCount: myCartModel
                                                        ?.data
                                                        ?.cart
                                                        ?.cartItems
                                                        ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var type = myCartModel
                                                          ?.data
                                                          ?.cart
                                                          ?.cartItems![index]
                                                          .preFiesta;
                                                      return Column(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.03,
                                                          ),
                                                          listItem(
                                                            index: index,
                                                            pid: myCartModel
                                                                ?.data
                                                                ?.cart
                                                                ?.cartItems![
                                                                    index]
                                                                .preFiesta
                                                                ?.id
                                                                .toString(),
                                                            topTile: type
                                                                ?.categories,
                                                            title: myCartModel
                                                                ?.data
                                                                ?.cart
                                                                ?.cartItems![
                                                                    index]
                                                                .preFiesta!
                                                                .name,
                                                            price: myCartModel
                                                                ?.data
                                                                ?.cart
                                                                ?.cartItems![
                                                                    index]
                                                                .price
                                                                .toString(),
                                                            quantity: myCartModel
                                                                ?.data
                                                                ?.cart
                                                                ?.cartItems![
                                                                    index]
                                                                .quantity
                                                                .toString(),
                                                            size: size,
                                                            type: type
                                                                ?.categories,
                                                            boolCount:
                                                                type?.categories ==
                                                                        "alcohol"
                                                                    ? null
                                                                    : true,
                                                            context: context,
                                                            count: myCartModel
                                                                ?.data
                                                                ?.cart
                                                                ?.cartItems![
                                                                    index]
                                                                .quantity,
                                                            cart: type
                                                                        ?.categories ==
                                                                    "mix"
                                                                ? UserData
                                                                    .preFiestasMixesTicketCart
                                                                : UserData
                                                                    .preFiestasExtrasTicketCart,
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),

                                              // items
                                              // SizedBox(
                                              //   height: size.height * 0.035,
                                              // ),
                                              // listItem(size: size, context: context),
                                              // SizedBox(
                                              //   height: size.height * 0.03,
                                              // ),
                                              // listItem(
                                              //     size: size,
                                              //     boolCount: true,
                                              //     context: context),
                                              // SizedBox(
                                              //   height: size.height * 0.03,
                                              // ),
                                              // listItem(
                                              //     size: size,
                                              //     boolCount: true,
                                              //     context: context),
                                            ],
                                          ),
                                        )),
                                    SizedBox(height: size.height * 0.02),
                                    Text(
                                        "${getTranslated(context, "thisisFinalstepafteryouTouchingpaynowbuttonthepaymentwillbetransation")}",
                                        // Strings.thisisFinalstepafteryouTouchingpaynowbuttonthepaymentwillbetransation,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.itemDescription,
                                            fontFamily: Fonts.dmSansRegular,
                                            fontSize: size.width * 0.03)),
                                    SizedBox(height: size.height * 0.03),

                                    // button
                                    GestureDetector(
                                      onTap: () {
                                        makeOrder();
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
                                                fontFamily: Fonts.dmSansBold,
                                                fontSize: size.width * 0.045),
                                          ),
                                        ),
                                      ),
                                    ),

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
                    child: Image.asset(Images.appLogo),
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

            roundedBoxBorder(
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

            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ));
}
