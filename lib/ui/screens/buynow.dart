import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/fiestasDetailmodel.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/screens/cardDetail.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';

class BuyNow extends StatefulWidget {
  final FiestasDetailModel? fiestasM;

  const BuyNow({Key? key, this.fiestasM}) : super(key: key);

  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  bool _isVertical = false;
  double _initialRating = 2.0;

  bool _loading = false;

  double bookingCharges = 0.0;
  double grandTotal = 0.0;
  double tarnsferCharge = 0.0;
  num itemCount = 0;

  // - + funtion

  addTicket(
      {int? index,
      int? indexMap,
      String? name,
      int? count,
      var price,
      String? image}) {
    print("add button press indexMap : $indexMap");

    var oldCount = 0;
    try {
      setState(() {
        oldCount = UserData.ticketcartMap[indexMap]["ticketCount"];
      });
    } catch (e) {
      setState(() {
        oldCount = 0;
      });
    }

    print(UserData.ticketcartMap);
    if (UserData.tiketList[indexMap!]["max"] > 0 &&
        oldCount < UserData.tiketList[indexMap]["max"]) {
      setState(() {
        if (UserData.ticketcartMap.containsKey(index)) {
          UserData.ticketcartMap[index]["ticketCount"] =
              UserData.ticketcartMap[index]["ticketCount"] + 1;

          UserData.ticketcartMap[index]["ticketPrice"] =
              UserData.ticketcartMap[index]["ticketCount"] *
                  UserData.tiketList[index!]["price"];

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
        } else {
          UserData.ticketcartMap[index] = {
            "ticketname": name,
            "ticketCount": count,
            "ticketPrice": price,
            "ticketimage": image,
            // new
            "ticketBookingCharge": index == 0
                ? int.parse(Strings.fiestaBasicTicketBookingCharge)
                : index == 1
                    ? int.parse(Strings.fiestaStandardTicketBookingCharge)
                    : int.parse(Strings.fiestaVipTicketBookingCharge)
          };
        }
        totalTicket();

        print(UserData.ticketcartMap);
      });
    }
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
      } else {
        UserData.ticketcartMap.remove(index);
      }

      if (UserData.ticketcartMap.isEmpty) {
        navigatePopFun(context);
      }

      totalTicket();
    });
  }

  // total ticket count

  totalTicket() {
    // UserData.totalTicketNum = 0;

    num tot = 0;
    double totBCharge = 0.0;
    double totPrice = 0.0;

    // print(UserData.totalTicketNum);
    for (var i in UserData.ticketcartMap.values.toList()) {
      // print(i["ticketCount"] + 1);
      tot = tot + i["ticketCount"];
      totBCharge = totBCharge + i["ticketBookingCharge"];
      totPrice = totPrice + double.parse("${i["ticketPrice"]}");
    }

    setState(() {
      UserData.totalTicketNum = tot;
      itemCount = tot;
      bookingCharges = totBCharge;
      tarnsferCharge =
          totPrice * double.parse("${Strings.fiestaTransferCharge}") / 100;
      grandTotal = bookingCharges + tarnsferCharge + totPrice;
    });
  }

  // booking api call

  fiestasBookingApi() async {
    setState(() {
      _loading = true;
    });
    var net = await Internetcheck.check();
    try {
      if (net != true) {
        Internetcheck.showdialog(context: context);
      } else {
        // filter cart value
        String ticket = "";
        String standard = "";
        String vip = "";

        UserData.ticketcartMap.forEach((key, value) {
          if (value["ticketname"] == "Ticket") {
            ticket = value["ticketCount"].toString();
          }
          if (value["ticketname"] == "Standard") {
            standard = value["ticketCount"].toString();
          }

          if (value["ticketname"] == "VIP Table") {
            vip = value["ticketCount"].toString();
          }
        });

        await fiestasBooking(
                id: widget.fiestasM?.data!.id.toString(),
                ticketcount: ticket,
                standardticketcount: standard,
                vipticketcount: vip,
                context: context)
            .then((res) {
          setState(() {
            _loading = false;
          });

          print("here is ${res?.toJson()}");

          if (res?.status == true && res?.code == 201) {
            setState(() {
              UserData.ticketcartMap.clear();
              UserData.totalTicketNum = 0;
            });
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => BookingSuccess()),
            //     (route) => false);
          }
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });

      print("Error in book fiestas-------------$e");
    }
  }

  @override
  void initState() {
    totalTicket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: AppColors.homeBackground,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: AppColors.homeBackground,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(SizeConfig.screenHeight * 0.02),
                        height: SizeConfig.screenHeight * 0.20,
                        child: Row(
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // cvfbgtkl;./
                                  width: SizeConfig.screenWidth * 0.80,

                                  margin:
                                      EdgeInsets.only(top: size.height * 0.01),

                                  //   height: SizeConfig.screenHeight,
                                  child: Text(
                                    "${widget.fiestasM?.data!.name}",
                                    style: TextStyle(
                                        fontSize: size.width * 0.08,
                                        fontFamily: "DM Sans Bold",
                                        color: AppColors.white),
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                ratingstars(
                                    size: size.width * 0.06,
                                    ittempading: size.width * 0.005,
                                    color: AppColors.tagBorder,
                                    rating: widget.fiestasM?.data?.clubRating !=
                                            null
                                        ? double.parse(
                                            "${widget.fiestasM?.data?.clubRating}")
                                        : 0.0)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // here sart bottom content

                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.homeBackgroundLite,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,

                        colors: <Color>[
                          AppColors.homeBackgroundLite,
                          Colors.transparent
                        ],
                        tileMode: TileMode
                            .repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    height: size.height * 0.76,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // cart title
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.screenWidth * 0.04),
                                child: SvgPicture.asset(
                                    "assets/svgicons/cartsvg.svg"),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.003,
                              ),
                              Text(
                                "${getTranslated(context, "yourCart")}",
                                //Strings.yourCart,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: Fonts.dmSansMedium,
                                    fontSize: size.width * 0.04),
                              ),
                            ],
                          ),

                          // Cart list

                          Column(
                            children: [
                              for (int i = 0;
                                  i < UserData.ticketcartMap.values.length;
                                  i++)
                                cartItem(
                                    size: size,
                                    context: context,
                                    index:
                                        UserData.ticketcartMap.keys.toList()[i],
                                    title: UserData.ticketcartMap.values
                                        .elementAt(i)["ticketname"],
                                    image: UserData.ticketcartMap.values
                                        .elementAt(i)["ticketimage"],
                                    count: UserData.ticketcartMap.values
                                        .elementAt(i)["ticketCount"],
                                    price: UserData.ticketcartMap.values
                                        .elementAt(i)["ticketPrice"],
                                    mapIndex: UserData.ticketcartMap.values
                                        .elementAt(i)["index"],
                                    bookingCharge: UserData.ticketcartMap.values
                                        .elementAt(i)["ticketBookingCharge"],
                                    remove: ticketRemove,
                                    add: addTicket)
                            ],
                          ),

                          // Expanded(
                          //   // height: size.height * 0.5,
                          //   child: ListView.builder(
                          //       itemCount: UserData.ticketcartMap.values.length,
                          //       itemBuilder: (context, index) {
                          //         var data = UserData.ticketcartMap.values
                          //             .elementAt(index);
                          //         var indexKey =
                          //             UserData.ticketcartMap.keys.toList()[index];

                          //         // print(indexKey);

                          //         return cartItem(
                          //             size: size,
                          //             context: context,
                          //             index: indexKey,
                          //             title: data["ticketname"],
                          //             image: data["ticketimage"],
                          //             count: data["ticketCount"],
                          //             price: data["ticketPrice"],
                          //             mapIndex: data["index"],
                          //             bookingCharge: data["ticketBookingCharge"],
                          //             remove: ticketRemove,
                          //             add: addTicket);
                          //       }),
                          // ),

                          SizedBox(height: size.height * 0.01),

                          // charges tottal

                          // tax

                          totalText(
                              context: context,
                              title: "bookingCharges",
                              price:
                                  "${double.parse('$bookingCharges').toStringAsFixed(2)}"),

                          SizedBox(
                            height: size.height * 0.008,
                          ),

                          Strings.fiestaTransferCharge != "0" &&
                                  Strings.fiestaTransferCharge != null
                              ? totalText(
                                  context: context,
                                  title: "transferCharges",
                                  price: "$tarnsferCharge")
                              : SizedBox(),

                          SizedBox(
                            height: size.height * 0.008,
                          ),

                          Container(
                            width: SizeConfig.screenWidth * 0.90,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "${getTranslated(context, "GrandTotal")}",
                                  //   "Other Taxes",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: size.width * 0.05,
                                      fontFamily: Fonts.dmSansMedium),
                                ),
                                // Spacer(),

                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Text(
                                  "${Strings.euro}" +
                                      double.parse("$grandTotal")
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: size.width * 0.052,
                                      fontFamily: Fonts.dmSansBold),
                                )
                              ],
                            ),
                          ),

                          // proceed to pay

                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),

                          SizedBox(
                            width: SizeConfig.screenWidth * 0.90,
                            child: ElevatedButton(
                              child: Text(
                                "${getTranslated(context, "proceedtopay")}",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: size.width * 0.05,
                                    fontFamily: Fonts.dmSansBold),
                              ),
                              onPressed: () {
                                navigatorPushFun(
                                    context,
                                    CartDetail(
                                      fiestasId: widget.fiestasM?.data?.id,
                                      totalCount: itemCount,
                                      totalPrice: grandTotal,
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth * 0.06,
                                    vertical: SizeConfig.screenHeight * 0.02),
                                primary: AppColors.redlite,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: SizeConfig.screenWidth * 0.80,
                              ),
                              child: Text.rich(TextSpan(
                                  text:
                                      "${getTranslated(context, "thisisthefinalstepOnceyoupressOnceyouPress")} ", // Strings.byContinuingYouAgreetoOur,
                                  style: TextStyle(
                                      fontFamily: Fonts.dmSansMedium,
                                      color: AppColors.descriptionfirst,
                                      fontSize: size.width * 0.038),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          " ${getTranslated(context, "Proceedtopay")} ", //"${Strings.termsOfService}",
                                      style: TextStyle(
                                          fontFamily: Fonts.dmSansBold,
                                          color: Colors.white,
                                          fontSize: size.width * 0.04),
                                    ),
                                    TextSpan(
                                      text:
                                          " ${getTranslated(context, "buttonthetransactionWillbeProceed.")} ", //"${Strings.termsOfService}",
                                      style: TextStyle(
                                          fontFamily: Fonts.dmSansMedium,
                                          color: AppColors.descriptionfirst,
                                          fontSize: size.width * 0.038),
                                    ),
                                  ]))),

                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _loading ? Center(child: CircularProgressIndicator()) : SizedBox()
        ],
      ),
    );
  }
}

Widget totalText({context, String? title, String? price}) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: SizeConfig.screenWidth * 0.90,
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Text(
          "${getTranslated(context, "$title")}",
          //   "Other Taxes",
          style: TextStyle(
              color: AppColors.white,
              fontSize: size.width * 0.04,
              fontFamily: Fonts.dmSansMedium),
        ),
        // Spacer(),

        SizedBox(
          width: size.width * 0.03,
        ),
        Text(
          "${Strings.euro}$price",
          style: TextStyle(
              color: AppColors.white,
              fontSize: size.width * 0.04,
              fontFamily: Fonts.dmSansBold),
        )
      ],
    ),
  );
}

Widget cartItem(
    {size,
    context,
    int? index,
    String? title,
    String? image,
    int? count,
    var price,
    add,
    bookingCharge,
    int? mapIndex,
    remove}) {
  print("here index $index");
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.005,
        horizontal: SizeConfig.screenWidth * 0.04),
    decoration: BoxDecoration(
        color: AppColors.brownLite,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(size.width * 0.02))),
    height: SizeConfig.screenHeight * 0.20,
    width: SizeConfig.screenWidth * 0.92,
    child: Padding(
      // padding: EdgeInsets.fromLTRB(8.0,SizeConfig.screenHeight * 0.02,8.0,SizeConfig.screenHeight * 0.04),
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015, horizontal: size.width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "$image",
                width: size.width * 0.1,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.03,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: Fonts.dmSansMedium,
                        fontSize: size.width * 0.04),
                  ),
                  Text(Strings.qty + ":$count",
                      style: TextStyle(
                          color: AppColors.white,
                          fontFamily: Fonts.dmSansMedium,
                          fontSize: size.width * 0.03)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          remove(name: title, index: index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.brownLite,
                            border: Border.all(color: AppColors.white),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 0.01)),
                          ),
                          height: SizeConfig.screenHeight * 0.04,
                          width: SizeConfig.screenWidth * 0.08,
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
                      Text(
                        "$count",
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
                          add(
                              index: index,
                              indexMap: mapIndex,
                              name: title,
                              count: count,
                              price: price,
                              image: image);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.skin,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 0.01)),
                          ),
                          height: SizeConfig.screenHeight * 0.04,
                          width: SizeConfig.screenWidth * 0.08,
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
                  )
                ],
              ),
              Spacer(),
              Text(
                Strings.euro + " " + "$price",
                style: TextStyle(
                    fontFamily: Fonts.dmSansMedium,
                    fontSize: size.width * 0.055,
                    color: AppColors.white),
              )
            ],
          ),
          Text(
            "${getTranslated(context, 'bookingCharges')} ${Strings.euro}${double.parse(bookingCharge.toString()).toStringAsFixed(2)}",

            // Strings.euro + " " + "$price",
            style: TextStyle(
                fontFamily: Fonts.dmSansRegular,
                fontSize: size.width * 0.04,
                color: AppColors.white),
          )
        ],
      ),
    ),
  );
}
