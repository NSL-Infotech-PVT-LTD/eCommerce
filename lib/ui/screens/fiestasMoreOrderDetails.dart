import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/fiestasBookingDetailModel.dart';
import 'package:funfy/models/fiestasBookingListModel.dart';
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

  const FiestasMoreOrderDetail({Key? key, this.fiestaBookingId})
      : super(key: key);

  @override
  _FiestasMoreOrderDetailState createState() => _FiestasMoreOrderDetailState();
}

class _FiestasMoreOrderDetailState extends State<FiestasMoreOrderDetail> {
  bool _loading = false;

  FiestasBookingDetailModel? fiestasBookingDetailModel;

  DateTime? dateTime;

  String? date;

  String? time;

  getFiestasBookingDetail() async {
    var net = await Internetcheck.check();

    setState(() {
      _loading = true;
    });

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      try {
        await fiestaBookingOrderDetailApi(fiestasId: widget.fiestaBookingId)
            .then((value) {
          setState(() {
            fiestasBookingDetailModel = value;
            _loading = false;

            dateTime = DateTime.parse(
                "${fiestasBookingDetailModel?.data![0].fiestaDetail?.timestamp}");

            date = DateFormat('dd MMM yyyy').format(dateTime!);

            time = DateFormat('hh:mm a').format(dateTime!);
          });
        });
      } catch (e) {
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // print("Look here" + "$date");

    var data = fiestasBookingDetailModel?.data![0].fiestaDetail;

    return Scaffold(
      backgroundColor: AppColors.siginbackgrond,
      appBar: AppBar(
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
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  // padding: EdgeInsets.symmetric(
                  //     vertical: size.height * 0.02, horizontal: size.width * 0.034),
                  alignment: Alignment.topCenter,
                  width: size.width,
                  height: size.height * 0.79,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0.02))),

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
                                    topRight: Radius.circular(size.width * 0.1),
                                    bottomRight:
                                        Radius.circular(size.width * 0.1))),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: size.width * 0.7,
                            height: 50,
                            child: Text(
                              "${getTranslated(context, "hyphens")}",


                              textAlign: TextAlign.center,

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
                                    topLeft: Radius.circular(size.width * 0.1),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.025,
                            horizontal: size.width * 0.034),
                        width: size.width,
                        height: size.height * 0.82 ,
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
                                            type:
                                                PageTransitionType.topToBottom,
                                            child: QrCodeZoomIn(
                                                qrId: fiestasBookingDetailModel
                                                    ?.data![0].id)));

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
                                data:
                                    "${fiestasBookingDetailModel?.data![0].id}",
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
                                  horizontal: size.width * 0.05),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      rating: 3.0),

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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          content(
                                              size: size,
                                              title: Strings.date,
                                              description: "$date"),
                                          SizedBox(
                                            height: size.height * 0.025,
                                          ),
                                          content(
                                              size: size,
                                              title: Strings.checkinType,
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
                                              title: Strings.time,
                                              description: "$time"),
                                          SizedBox(
                                            height: size.height * 0.025,
                                          ),
                                          content(
                                              size: size,
                                              title: Strings.orderId,
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
                                      title: Strings.location,
                                      description: Strings.lorem)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      roundedBoxR(
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

                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ]),
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
