import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/fiestasBookingListModel.dart';
import 'package:funfy/models/preFiestasBookingListModel.dart';
import 'package:funfy/ui/screens/Your%20order%20Summery.dart';
import 'package:funfy/ui/screens/fiestasMoreOrderDetails.dart';
import 'package:funfy/ui/widgets/postsitems.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool fiestasButton = true;

  FiestasBookingList? fiestasBookingListModel = FiestasBookingList();
  PreFiestasBookingListModel? preFiestasBookingList =
      PreFiestasBookingListModel();
  bool _loading = false;

  bool _preFiestasLoading = false;

  bookingListget() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
        _preFiestasLoading = true;
      });
      try {
        await fiestasBookingList().then((res) {
          if (res?.code == 200 && res?.status == true) {
            // print("after return  ${res?.toJson().toString()}");

            setState(() {
              fiestasBookingListModel = res;
              _loading = false;
            });
          }
        });

        priFiestasBookings();
      } catch (e) {
        setState(() {
          _loading = false;
          _preFiestasLoading = false;
        });
        print("error in booking list $e");
      }
    }
  }

  priFiestasBookings() async {
    print("run 2 ---------------- ");
    await preFiestaBookingListApi().then((res) {
      setState(() {
        _preFiestasLoading = false;
      });

      if (res?.code == 200 && res?.status == true) {
        print("res data ----------- ");
        print("after return  ${res?.toJson().toString()}");

        setState(() {
          preFiestasBookingList = res;
          _preFiestasLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bookingListget();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        body: Container(
            child: Column(
          children: [
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
                        "${getTranslated(context, "mybookings")}",
                        // Strings.mybookings,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white,
                            fontSize: size.width * 0.065),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "${getTranslated(context, "checkyourticketsyouboughtforFiestas")}",
                        // Strings.checkyourticketsyouboughtforFiestas,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansRegular,
                            color: AppColors.white,
                            fontSize: size.width * 0.038),
                      )
                    ],
                  )),
            ),

            SizedBox(
              height: size.height * 0.025,
            ),

            // fiestas && pre-fiestas button

            Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.04),
              // color: Colors.blue,
              width: size.width,
              height: size.height * 0.08,
              child: roundedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  backgroundColor: AppColors.homeTopbuttonbackground,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.022),
                    child: Row(
                      children: [
                        // fiestas button

                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                fiestasButton = true;
                              });
                            },
                            child: roundedBox(
                                backgroundColor: fiestasButton
                                    ? AppColors.siginbackgrond
                                    : AppColors.homeTopbuttonbackground,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${getTranslated(context, "fiestas")}",
                                    //Strings.fiestas,
                                    style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        fontFamily: Fonts.dmSansMedium,
                                        color: AppColors.white),
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
                              setState(() {
                                fiestasButton = false;
                              });
                            },
                            child: roundedBox(
                                // width: size.width * 0.44,
                                backgroundColor: fiestasButton
                                    ? AppColors.homeTopbuttonbackground
                                    : AppColors.siginbackgrond,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${getTranslated(context, "preFiestas")}",
                                    //  Strings.preFiestas,
                                    style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        fontFamily: Fonts.dmSansMedium,
                                        color: AppColors.white),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  )),
            ),

            // fiestas orders list

            fiestasButton
                ? Expanded(
                    child: Stack(
                    children: [
                      // loading
                      _loading
                          ? Center(child: CircularProgressIndicator())
                          : _loading == false &&
                                  fiestasBookingListModel?.data?.data?.length ==
                                      0
                              ? Center(
                                  child: Text(
                                  "${Strings.listEmpty}",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: size.width * 0.05),
                                ))
                              : ListView.builder(
                                  itemCount: fiestasBookingListModel
                                          ?.data?.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return fiestasOrdersItem(
                                        context: context,
                                        index: index,
                                        model: fiestasBookingListModel);
                                  }),
                    ],
                  ))
                : Expanded(
                    child: Stack(
                    children: [
                      // loading
                      _preFiestasLoading
                          ? Center(child: CircularProgressIndicator())
                          : _preFiestasLoading == false &&
                                  preFiestasBookingList?.data?.data?.length == 0
                              ? Center(
                                  child: Text(
                                  "${Strings.listEmpty}",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: size.width * 0.05),
                                ))
                              : ListView.builder(
                                  itemCount: preFiestasBookingList
                                          ?.data?.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return preFiestasOrderItem(
                                        context: context,
                                        index: index,
                                        model: preFiestasBookingList);
                                  }),
                    ],
                  ))
          ],
        )));
  }
}

Widget fiestasOrdersItem({context, index, FiestasBookingList? model}) {
  var size = MediaQuery.of(context).size;

  var data = model?.data?.data?.elementAt(index);

  return Container(
    // color: AppColors.brownLite,

    margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01, horizontal: size.width * 0.03),
    padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02, horizontal: size.width * 0.04),
    alignment: Alignment.topLeft,

    decoration: BoxDecoration(
        //  color: HexColor("#38332f"),
        // color: Colors.blue,
        image: DecorationImage(
            image: AssetImage("assets/pngicons/fiestasBackground.png"),
            fit: BoxFit.cover)),

    child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        roundedBoxR(
            width: size.width * 0.16,
            height: size.height * 0.03,
            backgroundColor: AppColors.green,
            radius: size.width * 0.01,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${getTranslated(context, "open")}",
                // Strings.open,
                style: TextStyle(
                    fontFamily: Fonts.dmSansBold,
                    color: AppColors.white,
                    fontSize: size.width * 0.035),
              ),
            )),
        SizedBox(
          height: size.height * 0.003,
        ),
        Text(
          "${data?.fiestaDetail?.name}",
          style: TextStyle(
              fontFamily: Fonts.dmSansBold,
              color: AppColors.white,
              fontSize: size.width * 0.072),
        ),
        SizedBox(
          height: size.height * 0.003,
        ),
        ratingstars(
            size: size.width * 0.052,
            ittempading: size.width * 0.001,
            color: AppColors.tagBorder,
            rating: 3.5),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: size.width * 0.1,
                child: SvgPicture.asset(Images.ticketImageSvg)),
            SizedBox(
              width: size.width * 0.042,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated(context, "ticket")}",
                  // Strings.ticket,
                  style: TextStyle(
                      fontFamily: Fonts.dmSansBold,
                      color: AppColors.white,
                      fontSize: size.width * 0.05),
                ),
                Text(
                  "${getTranslated(context, "qty")} :2",
                  //   Strings.qty + ":2",
                  style: TextStyle(
                      fontFamily: Fonts.dmSansBold,
                      color: AppColors.white,
                      fontSize: size.width * 0.03),
                ),
              ],
            ),
            Spacer(),
            Text(
              Strings.euro + "${data?.totalPrice}",
              style: TextStyle(
                  fontFamily: Fonts.dmSansMedium,
                  color: AppColors.white,
                  fontSize: size.width * 0.08),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              navigatorPushFun(
                  context, FiestasMoreOrderDetail(fiestaData: data));
            },
            child: Text(
              "${getTranslated(context, "moreDetails")}",
              //Strings.moreDetails,
              style: TextStyle(
                  fontFamily: Fonts.dmSansBold,
                  color: AppColors.siginbackgrond,
                  fontSize: size.width * 0.05),
            ),
          ),
        ),
      ],
    ),
  );
}

//
Widget preFiestasOrderItem(
    {context, int? index, PreFiestasBookingListModel? model}) {
  var size = MediaQuery.of(context).size;

  var data =
      model?.data?.data?.elementAt(index!).orderItem?.elementAt(0).preFiesta;
  String orderid =
      "${model?.data?.data?.elementAt(index!).orderItem?.elementAt(index).orderId}";

  return Container(
    margin: EdgeInsets.only(top: size.height * 0.02),
    child: roundedBoxBorder(
        context: context,
        height: size.height * 0.21,
        width: size.width,
        backgroundColor: AppColors.itemBackground,
        borderColor: AppColors.tagBorder,
        borderSize: size.width * 0.0025,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // center content
              Container(
                  padding: EdgeInsets.only(
                      top: size.height * 0.025, left: size.width * 0.05),
                  width: size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data?.name}",
                        // "${data?.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: size.width * 0.054,
                            fontFamily: Fonts.dmSansBold),
                      ),
                      SizedBox(
                        height: size.height * 0.008,
                      ),
                      Text(
                        "${data?.description}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.itemDescription,
                            fontSize: size.width * 0.033,
                            fontFamily: Fonts.dmSansRegular),
                      ),

                      SizedBox(
                        height: size.height * 0.016,
                      ),

                      // order Now
                      GestureDetector(
                        onTap: () {
                          navigatorPushFun(
                              context, YourOrderSum(orderID: orderid));
                        },
                        child: roundedBoxR(
                            radius: size.width * 0.005,
                            width: size.width * 0.3,
                            height: size.height * 0.04,
                            backgroundColor: AppColors.siginbackgrond,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${getTranslated(context, "orderDetails")}",
                                // Strings.orderDetails,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: size.width * 0.034,
                                    fontFamily: Fonts.dmSansBold),
                              ),
                            )),
                      )
                    ],
                  )),

              // right image

              Container(
                padding: EdgeInsets.only(
                    top: size.height * 0.02, bottom: size.height * 0.013),
                width: size.width * 0.25,
                // decoration: BoxDecoration(),
                child: Image.network(
                  "${data?.image ?? Images.beerNetwork}",

                  // fit: BoxFit.fill,
                ),
              )
            ],
          ),
        )),
  );
}
