import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/fiestasBookingDetailModel.dart';
import 'package:funfy/ui/screens/fiestasBook.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/screens/pages/bookingpage.dart';
import 'package:funfy/ui/screens/qrCodeZoomin.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FiestasMoreOrderDetail extends StatefulWidget {
  final fiestaBookingId;
  final nav;

  const FiestasMoreOrderDetail(
      {Key? key, @required this.fiestaBookingId, this.nav})
      : super(key: key);

  @override
  _FiestasMoreOrderDetailState createState() => _FiestasMoreOrderDetailState();
}

class _FiestasMoreOrderDetailState extends State<FiestasMoreOrderDetail> {
  bool _loading = false;
  bool ratting = false;
  double currentRating = 3.0;

  FiestasBookingDetailModel? fiestasBookingDetailModel;
  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime? dateTime;

  String? date;

  String? time;

  double ratingF = 0.0;

  getFiestasBookingDetail() async {
    var net = await Internetcheck.check();

    setState(() {
      _loading = true;
    });

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      try {
        await fiestaBookingOrderDetailApi(
            fiestasId: widget.fiestaBookingId.toString(), context: context)
            .then((value) {
          // print("here is model : ${value?.toJson()}");
          setState(() {
            fiestasBookingDetailModel = value;
            _loading = false;

            dateTime = DateTime.parse(
                "${fiestasBookingDetailModel?.data![0].fiestaDetail?.timestamp}");

            date = DateFormat('dd MMM yyyy').format(dateTime!);

            time = DateFormat('hh:mm a').format(dateTime!);

            // if (fiestasBookingDetailModel?.data![0].bookingStatus ==
            //     "completed") {
            //   showRatingBottomSheet();
            // }

            if (fiestasBookingDetailModel?.data![0].readyForReview == true) {
              showRatingBottomSheet();
            }
            var ratM =
                fiestasBookingDetailModel?.data![0].fiestaDetail?.clubRating;

            if (ratM == null || ratM == 0) {
              ratingF = 0.0;
            } else {
              ratingF = double.parse("$ratM");
            }
          });
        });
      } catch (e) {
        print("here is error $e");
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getFiestasBookingDetail();
  }

  // showRating() {
  //   Future.delayed(
  //       Duration(
  //         seconds: 2,
  //       ), () {
  //     showRatingBottomSheet();
  //   });
  // }

  // rating Api
  rating() {
    navigatePopFun(context);
    var data = fiestasBookingDetailModel?.data![0];

    int rat = currentRating.toInt();

    fiestaRatingApi(
        orderId: "${data?.id}", fiestasId: "${data?.fiestaId}", rating: rat)
        .then((value) {
      if (value == false) {
        showRatingBottomSheet();
      } else {
        // print("here is else part");
        Dialogs.showBasicsFlash(
            context: context,
            content: "${getTranslated(context, "successfullyRated")}",
            duration: Duration(seconds: 1));
      }
    });
  }

  // fiestas rating botton sheet

  void showRatingBottomSheet() {
    var size = MediaQuery.of(context).size;

    showModalBottomSheet(
        backgroundColor: AppColors.blackBackground,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            key: _scaffoldKey,
            builder: (context, setstate) {
              return Container(
                  margin: EdgeInsets.only(top: size.height * 0.008),
                  color: AppColors.blackBackground,
                  height: size.height * 0.4,
                  width: size.width,
                  child: Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                navigatePopFun(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: AppColors.white,
                              )),
                        ),
                        roundedBoxR(
                            radius: size.width * 0.02,
                            width: size.width,
                            height: size.width * 0.4,
                            backgroundColor: AppColors.blackBackground,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${getTranslated(context, "doYouLikeOurService")}",
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
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    unratedColor: AppColors.starUnselect,
                                    itemPadding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.01),
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
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        )
                      ],
                    ),
                  ));
            },
          );
        });
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
      ),
    );

    var data = fiestasBookingDetailModel?.data![0].fiestaDetail;

    return WillPopScope(
      onWillPop: backCall,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.siginbackgrond,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: backCall,
              icon: Icon(Icons.arrow_back),
            ),
            key: _keyScaffold,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "${getTranslated(context, "youreTicket")}",
              //   Strings.youreTicket,
              style: TextStyle(
                  fontFamily: Fonts.dmSansMedium, fontSize: size.width * 0.05),
            ),
          ),
          body: _loading
              ? Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          )
              : SingleChildScrollView(
            child: Stack(children: [
              Container(
                margin:
                EdgeInsets.symmetric(horizontal: size.width * 0.05),
                alignment: Alignment.topCenter,
                width: size.width,
                height: size.height * 0.79,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(size.width * 0.02))),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.06,
                          decoration: BoxDecoration(
                              color: AppColors.siginbackgrond,
                              borderRadius: BorderRadius.only(
                                  topRight:
                                  Radius.circular(size.width * 0.1),
                                  bottomRight:
                                  Radius.circular(size.width * 0.1))),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.6,
                          height: 50,
                          child: Text(
                            "${getTranslated(context, "hyphens")}",

                            //Strings.hyphens,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: size.width * 0.045,
                                color: AppColors.inputTitle),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.06,
                          decoration: BoxDecoration(
                              color: AppColors.siginbackgrond,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                  Radius.circular(size.width * 0.1),
                                  bottomLeft:
                                  Radius.circular(size.width * 0.1))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    // center box
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05),
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.025,
                          horizontal: size.width * 0.034),
                      width: size.width,
                      height: size.height * 0.79,
                      decoration: BoxDecoration(
                        // color: AppColors.white,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.02))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration:
                                          Duration(milliseconds: 500),
                                          type: PageTransitionType
                                              .topToBottom,
                                          child: QrCodeZoomIn(
                                            id: fiestasBookingDetailModel
                                                ?.data![0].fiestaId,
                                            qrId: widget.fiestaBookingId,
                                          )));

                                  // navigatorPushFun(context, QrCodeZoomIn());
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  width: size.width * 0.06,
                                  height: size.height * 0.03,
                                  child: SvgPicture.asset(
                                    Images.qrZoomIn,
                                    width: size.width * 0.055,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: size.height * 0.01,
                          ),

                          // qr code

                          Container(
                            alignment: Alignment.topRight,
                            width: size.width * 0.32,
                            height: size.height * 0.16,
                            // color: Colors.yellow,
                            child: QrImage(
                              data: "${widget.fiestaBookingId}",
                              version: QrVersions.auto,
                              size: size.width * 0.5,
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.1,
                          ),

                          // content

                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // title
                                Text(
                                  "${data?.name}",
                                  style: TextStyle(
                                      fontFamily: Fonts.dmSansBold,
                                      fontSize: size.width * 0.07,
                                      color: AppColors.blackBackground),
                                ),
                                //rating

                                ratingstars(
                                    size: size.width * 0.042,
                                    ittempading: size.width * 0.001,
                                    color: HexColor("#ffc607"),
                                    rating: ratingF),

                                SizedBox(
                                  height: size.height * 0.015,
                                ),

                                // price

                                Row(
                                  children: [
                                    Container(
                                      width: size.width * 0.072,
                                      // height: size.height * 0.025,
                                      child: SvgPicture.asset(
                                          Images.ticketWhiteImageSvg),
                                    ),
                                    SizedBox(width: size.width * 0.025),
                                    Text(
                                      Strings.euro +
                                          " " +
                                          "${fiestasBookingDetailModel?.data![0].totalPrice}",
                                      style: TextStyle(
                                          fontFamily: Fonts.dmSansMedium,
                                          fontSize: size.width * 0.055,
                                          color: AppColors.priceColor),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: size.height * 0.01,
                                ),

                                // date time

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        content(
                                            size: size,
                                            title: getTranslated(
                                                context, "date"),
                                            description: "$date"),
                                        SizedBox(
                                          height: size.height * 0.025,
                                        ),
                                        content(
                                            size: size,
                                            title: getTranslated(
                                                context, "checkinType"),
                                            description: Strings.ticket),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        content(
                                            size: size,
                                            title: getTranslated(
                                                context, "time"),
                                            description: "$time"),
                                        SizedBox(
                                          height: size.height * 0.025,
                                        ),
                                        content(
                                            size: size,
                                            title: getTranslated(
                                                context, "orderId"),
                                            description:
                                            "${fiestasBookingDetailModel?.data![0].id}")
                                      ],
                                    )
                                  ],
                                ),

                                SizedBox(
                                  height: size.height * 0.025,
                                ),

                                content(
                                    size: size,
                                    title: getTranslated(
                                        context, "location"),
                                    description:
                                    "${fiestasBookingDetailModel?.data![0].fiestaDetail?.clubDetail?.location ?? getTranslated(context, 'location')}")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.04,
                    ),

                    InkWell(
                      onTap: () {
                        navigatorPushFun(
                            context,
                            FiestasBook(
                              fiestasID: fiestasBookingDetailModel
                                  ?.data![0].fiestaId,
                            ));
                      },
                      child: roundedBoxR(
                          height: size.height * 0.065,
                          width: size.width * 0.7,
                          backgroundColor: AppColors.blackBackground,
                          radius: size.width * 0.02,
                          child: Center(
                              child: Text(
                                "${getTranslated(context, "seeClubProfile")}",
                                // Strings.seeClubProfile,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: Fonts.dmSansBold,
                                    fontSize: size.width * 0.045),
                              ))),
                    ),

                    SizedBox(
                      height: size.height * 0.04,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget content({size, String? title, String? description}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$title",
        style: TextStyle(
            fontFamily: Fonts.dmSansBold,
            fontSize: size.width * 0.05,
            color: AppColors.blackBackground),
      ),
      SizedBox(
        height: size.height * 0.005,
      ),
      Text(
        "$description",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: Fonts.dmSansMedium,
            fontSize: size.width * 0.045,
            color: AppColors.inputTitle),
      ),
    ],
  );
}
