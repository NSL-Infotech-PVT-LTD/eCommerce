import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/preFiestasBookingListModel.dart';
import 'package:funfy/ui/screens/Your%20order%20Summery.dart';
import 'package:funfy/ui/screens/fiestasMoreOrderDetails.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';

import 'package:internet_speed_test/internet_speed_test.dart';

final internetSpeedTest = InternetSpeedTest();

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool fiestasButton = true;

  // FiestasBookingList? fiestasBookingListModel = FiestasBookingList();

  List fiestasBookingListRes = [];

  List prifiestasBookingList = [];
  // PreFiestasBookingListModel? preFiestasBookingList;
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
          // print("here is json");

          // print(res[0]["id"]);
          // print(res.body);

          Iterable data = res.reversed.toList();

          // print(data);

          setState(() {
            fiestasBookingListRes = data.toList();
            _loading = false;
          });
        });
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
    try {
      await preFiestaBookingListApi().then((res) {
        setState(() {
          _preFiestasLoading = false;
        });

        if (res["code"] == 200 && res["status"] == true) {
          // print("res data ----------- ");
          // print("after return  ${res?.toJson().toString()}");

          var resRevData = res["data"]["data"];

          setState(() {
            prifiestasBookingList = resRevData.reversed.toList();
            _preFiestasLoading = false;
          });

          // setState(() {
          //   preFiestasBookingList = res;

          //   var rlist = preFiestasBookingList?.data?.data?.reversed.toList();
          //   preFiestasBookingList?.data?.data = rlist;
          //   _preFiestasLoading = false;
          // });
        }
      });
    } catch (e) {
      print("error --------- $e");
      setState(() {
        _preFiestasLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    bookingListget();
    priFiestasBookings();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.blackBackground,
      child: SafeArea(
        child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   child: Icon(Icons.add),
            // ),
            backgroundColor: AppColors.homeBackground,
            body: Container(
                child: Column(
              children: [
                Container(
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
                          fiestasButton
                              ? "${getTranslated(context, "mybookings")}"
                              : "${getTranslated(context, "myOrders")}",
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
                          fiestasButton
                              ? "${getTranslated(context, "checkyourticketsyouboughtforFiestas")}"
                              : "${getTranslated(context, "CheckyourordersyouboughtforPrefiestas")}",
                          // Strings.checkyourticketsyouboughtforFiestas,
                          style: TextStyle(
                              fontFamily: Fonts.dmSansRegular,
                              color: AppColors.white,
                              fontSize: size.width * 0.038),
                        )
                      ],
                    )),

                SizedBox(
                  height: size.height * 0.025,
                ),

                // fiestas && pre-fiestas button

                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.04),
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
                                      // fiestasBookingListModel?.data?.data?.length ==
                                      fiestasBookingListRes.length == 0
                                  ? Center(
                                      child: Text(
                                      "${Strings.listEmpty}",
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: size.width * 0.05),
                                    ))
                                  : ListView.builder(
                                      // itemCount: fiestasBookingListModel
                                      //         ?.data?.data?.length ??
                                      // 0,

                                      itemCount: fiestasBookingListRes.length,
                                      itemBuilder: (context, index) {
                                        return fiestasOrdersItem(
                                            context: context,
                                            index: index,
                                            model: fiestasBookingListRes);
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
                                          prifiestasBookingList.length == 0 ||
                                      prifiestasBookingList == []
                                  ? Center(
                                      child: Text(
                                      "${Strings.listEmpty}",
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: size.width * 0.05),
                                    ))
                                  : ListView.builder(
                                      // itemCount: preFiestasBookingList
                                      //         ?.data?.data?.length ??
                                      //     0,
                                      itemCount: prifiestasBookingList.length,
                                      itemBuilder: (context, index) {
                                        return preFiestasOrderItemsNew(
                                            context: context,
                                            index: index,
                                            model: prifiestasBookingList);
                                      }),
                        ],
                      ))
              ],
            ))),
      ),
    );
  }
}

Widget preFiestasOrderItemsNew({context, List? model, index}) {
  var size = MediaQuery.of(context).size;

  var modeldata = model![index];

  return InkWell(
    onTap: () {
      print("Modeldata here   $modeldata");
      navigatorPushFun(
          context,
          YourOrderSum(
              nav: 0,
              orderID: modeldata["id"]
                  .toString())); // model?.data?.data?.elementAt(index!).id.toString()));
    },
    child: Container(
        margin: EdgeInsets.only(top: size.height * 0.017),
        // color: AppColors.green,
        padding: EdgeInsets.symmetric(
            // vertical: size.height * 0.01,

            horizontal: size.width * 0.04),
        height: size.height * 0.12,
        width: size.width,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
              width: size.height * 0.001, color: AppColors.tagBorder),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.green,
              height: 20,
              width: 20,
              child: Image.asset(
                modeldata["order_statuss"] == "completed" ||
                        modeldata["orderStatus"] == "reviewed"
                    ? "assets/pngicons/activeBook.png"
                    : "assets/pngicons/pendingBook.png",

                // data?.orderStatus == "completed" ||
                //         data?.orderStatus == "reviewed"
                //     ? "assets/pngicons/activeBook.png"
                //     : "assets/pngicons/pendingBook.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${modeldata['category_detail']['name']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        // fontFamily: Fonts.dmSansBold,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                        fontSize: size.width * 0.05),
                  ),
                  SizedBox(
                    height: size.height * 0.008,
                  ),
                  Text(
                    "${modeldata['category_detail']['description']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansMedium,
                        // fontWeight: FontWeight.w900,
                        color: AppColors.itemDescription,
                        fontSize: size.width * 0.044),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.002,
            ),
            Column(
              children: [
                Spacer(),
                roundedBoxBorder(
                    context: context,
                    width: size.width * 0.32,
                    // height: size.height * 0.04,
                    radius: size.width * 0.005,
                    borderSize: size.width * 0.003,
                    borderColor: AppColors.siginbackgrond,
                    backgroundColor: AppColors.blackBackground,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.007),
                      child: Text(
                        "${getTranslated(context, "orderDetails")}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white,
                            fontSize: size.width * 0.04),
                      ),
                    )),
                Spacer(),
              ],
            )
          ],
        )),
  );
}

Widget fiestasOrdersItem(
    {context,
    index,
// FiestasBookingList?
    List? model}) {
  var size = MediaQuery.of(context).size;

  double ratingF = 0.0;

  var ratM = model![index]['fiesta_detail']['club_rating'];

  print(ratM);

  if (ratM == null || ratM == 0.0) {
    ratingF = 0.0;
  } else {
    ratingF = double.parse("$ratM");
  }

  // var data = model?.data?.data?.elementAt(index);

  // print("here is name - ${data!.fiestaDetail!.clubDetail!.name!}");

  return InkWell(
    onTap: () {
      navigatorPushFun(context,
          FiestasMoreOrderDetail(fiestaBookingId: "${model[index]['id']}"));
    },
    child: Container(
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
            // data!.fiestaDetail!.clubDetail!.name!.toString(),
            "${model[index]['fiesta_detail']['club_detail']['name']}",
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
              rating: ratingF),
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
                    "${getTranslated(context, "qty")} : ${model[index]['total_tickets']}",
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
                Strings.euro +
                    "${model[index]['total_price']}", //"${data?.totalPrice}",
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
                    context,
                    FiestasMoreOrderDetail(
                        fiestaBookingId: "${model[index]['id']}"));
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
    ),
  );
}
