import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/models/prefiestasOrderDetailModel.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:intl/intl.dart';

class YourOrderSum extends StatefulWidget {
  final orderID;
  final nav;

  const YourOrderSum({Key? key, @required this.orderID, this.nav})
      : super(key: key);
  @override
  _YourOrderSumState createState() => _YourOrderSumState();
}

class _YourOrderSumState extends State<YourOrderSum> {
  bool ratting = false;
  double currentRating = 3.0;
  PrefiestasOrderDetailModel? prefiestasOrderDetailModel;
  bool _loading = false;

  String? deliverydate;
  String? deliveryTime;

  String grandTotal = "0.0";

  getPrefiestasorderItemData() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        await prefiestasShowOrderDetail(orderId: widget.orderID.toString())
            .then((res) {
          print("data is here ");

          // print("here is id ------ ${widget.orderID}");

          setState(() {
            _loading = false;
            prefiestasOrderDetailModel = res;

            // Delivery date time
            DateTime deliverydate1 = DateTime.parse(
                "${prefiestasOrderDetailModel?.data?.orderDetail![0].date}");

            var time = prefiestasOrderDetailModel?.data?.orderDetail![0].time;

            var time2 =
                DateFormat.jm().format(DateFormat("hh:mm:ss").parse("$time"));

            var date2 = DateFormat('d MMMM').format(deliverydate1);

            deliverydate = "$date2";
            deliveryTime = "${getTranslated(context, "till")} $time2";

            grandTotal =
                "${prefiestasOrderDetailModel?.data?.orderDetail![0].grandTotal}";

            if (prefiestasOrderDetailModel?.data?.orderDetail![0].orderStatus ==
                "completed") {
              ratting = true;
            }
          });
        });
      } catch (e) {
        setState(() {
          _loading = false;
        });
        print("here is error- $e");
      }
    }
  }

  // rating Api
  rating() {
    // navigatePopFun(context);
    setState(() {
      ratting = false;
    });

    var data = prefiestasOrderDetailModel?.data?.orderDetail![0];

    prefiestaRatingApi(orderId: "${data?.id}", rating: currentRating)
        .then((value) {
      if (value == false) {
      } else {
        setState(() {
          ratting = true;
        });
        // print("here is else part");
        Dialogs.showBasicsFlash(
            context: context,
            content: "${getTranslated(context, "successfullyRated")}",
            duration: Duration(seconds: 1));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    print("data id : ${widget.orderID}");

    getPrefiestasorderItemData();
  }

  // rating popup

  Widget ratingPopup({
    size,
  }) {
    return Container(
      child: Column(
        children: [
          roundedBoxR(
              radius: size.width * 0.02,
              width: size.width,
              height: size.width * 0.4,
              backgroundColor: AppColors.ratingPopupbackground,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${getTranslated(context, "doYouLikeOurService")}",
                      // Strings.doYouLikeOurService,
                      style: TextStyle(
                          color: AppColors.white,
                          fontFamily: Fonts.dmSansMedium,
                          fontSize: size.width * 0.044),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    RatingBar.builder(
                      itemSize: size.width * 0.125,
                      initialRating: currentRating,
                      // ignoreGestures: true,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: AppColors.starUnselect,
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: AppColors.ratingYellow,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        setState(() {
                          currentRating = rating;
                        });
                      },
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: size.height * 0.02,
          ),
          InkWell(
            onTap: () {
              rating();
            },
            child: roundedBoxR(
                width: size.width * 0.7,
                height: size.height * 0.06,
                radius: size.width * 0.02,
                backgroundColor: AppColors.siginbackgrond,
                child: Center(
                  child: Text(
                    "${getTranslated(context, "submitReview")}",
                    // Strings.submitReview,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansBold,
                        fontSize: size.width * 0.04,
                        color: AppColors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Future<bool> backCall() async {
    if (widget.nav == 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Home(
                    pageIndexNum: 0,
                  )),
          (route) => false);
    } else {
      Navigator.of(context).pop();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: backCall,
      child: Scaffold(
          backgroundColor: AppColors.homeBackgroundLite,
          appBar: AppBar(
            leading: IconButton(
              onPressed: backCall,
              icon: Icon(Icons.arrow_back),
            ),
            backgroundColor: AppColors.homeBackgroundLite,
            centerTitle: true,
            title: Text(
              "${getTranslated(context, "YourOrderSummery")}",
              // "Your Order Summery",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: size.width * 0.05,
                  fontFamily: Fonts.dmSansMedium),
            ),
          ),
          body: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    color: AppColors.homeBackgroundLite,
                    padding: EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        // rating popup

                        ratting ? ratingPopup(size: size) : SizedBox(),

                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.045),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 0.02)),
                            color: AppColors.greenCont,
                          ),
                          height: SizeConfig.screenHeight * 0.08,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgicons/card.svg",
                                color: Colors.white,
                                height: size.width * 0.075,
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.03,
                              ),
                              Text(
                                "${getTranslated(context, "Paymentstatus")}",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: size.width * 0.05,
                                    fontFamily: Fonts.dmSansMedium),
                              ),
                              Spacer(),
                              Text(
                                "${getTranslated(context, "PAID")}",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: size.width * 0.05,
                                    fontFamily: Fonts.dmSansBold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.025,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.02),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 0.02)),
                            color: AppColors.homeBackground,
                          ),
                          //  height: SizeConfig.screenHeight * 0.10,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${prefiestasOrderDetailModel?.data?.parentDetail?.name}",
                                    // "${getTranslated(context, "PackLaHavana")}",
                                    //"Pack La Havana",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: size.width * 0.05,
                                        fontFamily: Fonts.dmSansBold),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: SizeConfig.screenWidth *
                                                  0.68),
                                          child: Text(
                                            "${prefiestasOrderDetailModel?.data?.parentDetail?.description ?? getTranslated(context, "description")}",
                                            // "${getTranslated(context, "lorem")}",
                                            // Strings.lorem,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color:
                                                    AppColors.itemDescription,
                                                fontSize: size.width * 0.04,
                                                fontFamily:
                                                    Fonts.dmSansRegular),
                                          )),
                                      // Spacer(),
                                      Container(
                                          height: size.height * 0.08,
                                          width: size.width * 0.18,
                                          // color: Colors.blue,
                                          child: Image.network(
                                            "${prefiestasOrderDetailModel?.data?.parentDetail?.image}",
                                            // Images.beerNetwork,
                                          ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      for (OrderItem i
                                          in prefiestasOrderDetailModel!
                                              .data!.orderDetail![0].orderItem!
                                              .toList())
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),
                                            sameItem3(
                                                size: size,
                                                topTile:
                                                    "${i.preFiesta?.categories}",
                                                title: "${i.preFiesta?.name}",
                                                decription:
                                                    "${i.preFiesta?.quantity} CL",
                                                price: "${i.price}"),
                                          ],
                                        )
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  sameItem3(
                                      size: size,
                                      topTile: "Alcohol",
                                      title: "Ron Bucanero Anejo",
                                      decription: "70 CL",
                                      price: "25.88"),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  sameItem3(
                                      size: size,
                                      topTile: "Mix",
                                      title: "Ron Bucanero Anejo",
                                      decription: "70 CL",
                                      price: "25.88"),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  sameItem3(
                                      size: size,
                                      topTile: "Extras",
                                      title: "Ron Bucanero Anejo",
                                      decription: "70 CL",
                                      price: "25.88"),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.05,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.82,
                                    child: DottedLine(
                                      dashLength: 10,
                                      dashGapLength: 13,
                                      lineThickness: 2,
                                      dashColor: Colors.grey,
                                      dashGapColor: AppColors.homeBackground,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.04,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.80,
                                    child: Row(
                                      children: [
                                        Text(
                                          "${getTranslated(context, "transferCharges")}",
                                          //   "Other Taxes",
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: size.width * 0.05,
                                              fontFamily: Fonts.dmSansMedium),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${Strings.euro} ${double.parse('${prefiestasOrderDetailModel?.data?.orderDetail?[0].transferCharge ?? 0.0}').toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: size.width * 0.05,
                                              fontFamily: Fonts.dmSansBold),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.04,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.80,
                                    child: Row(
                                      children: [
                                        Text(
                                          "${getTranslated(context, "GrandTotal")}",
                                          //   "Grand Total",
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: size.width * 0.06,
                                              fontFamily: Fonts.dmSansMedium),
                                        ),
                                        Spacer(),
                                        Text(
                                          Strings.euro + " " + grandTotal,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: size.width * 0.065,
                                              fontFamily: Fonts.dmSansBold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //Image.asset(name)
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.11,
                          child: DottedBorder(
                            radius: Radius.elliptical(100, 100),
                            color: AppColors.borderColor,
                            // gap: 3,
                            strokeWidth: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.03,
                                  ),
                                  Text(
                                    "${getTranslated(context, "DeliveryStatus")}",
                                    //"Delivery Status",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: size.width * 0.05,
                                        fontFamily: Fonts.dmSansMedium),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.02),
                                      Text(
                                        // "25 JUNE, Today",

                                        "$deliverydate",
                                        style: TextStyle(
                                            color: AppColors.itemDescription,
                                            fontSize: size.width * 0.04,
                                            fontFamily: Fonts.dmSansMedium),
                                      ),
                                      Text(
                                        "$deliveryTime",
                                        style: TextStyle(
                                            color: AppColors.itemDescription,
                                            fontSize: size.width * 0.04,
                                            fontFamily: Fonts.dmSansMedium),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.04),
                      ],
                    ),
                  ),
                )),
    );
  }
}

Widget sameItem3(
    {size, String? topTile, String? title, String? decription, String? price}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "($topTile)",
        style: TextStyle(
            color: AppColors.itemDescription,
            fontSize: size.width * 0.03,
            fontFamily: Fonts.dmSansRegular),
      ),
      SizedBox(
        height: SizeConfig.screenHeight * 0.01,
      ),
      Text(
        "$title",
        style: TextStyle(
            color: AppColors.white,
            fontSize: size.width * 0.05,
            fontFamily: Fonts.dmSansMedium),
      ),
      Container(
        width: SizeConfig.screenWidth * 0.80,
        child: Row(
          children: [
            Text(
              "$decription",
              style: TextStyle(
                  color: AppColors.itemDescription,
                  fontSize: size.width * 0.04,
                  fontFamily: Fonts.dmSansMedium),
            ),
            Spacer(),
            Text(
              Strings.euro + " " + "$price",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: size.width * 0.05,
                  fontFamily: Fonts.dmSansMedium),
            )
          ],
        ),
      )
    ],
  );
}
