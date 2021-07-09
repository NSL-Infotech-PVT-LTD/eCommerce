import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/components/locationget.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/widgets/dateButton.dart';
import 'package:funfy/ui/widgets/postsitems.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/ui/widgets/tagsButton.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';
import 'package:intl/intl.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

String gradientbackgroundimage =
    "https://www.teahub.io/photos/full/2-28293_1920x1080-wallpaper-linear-orange-gradient-red-dark-red.jpg";

class FiestasPage extends StatefulWidget {
  const FiestasPage({Key? key}) : super(key: key);

  @override
  _FiestasPageState createState() => _FiestasPageState();
}

class _FiestasPageState extends State<FiestasPage> {
  bool fiestasButton = true;

  FiestasModel? fiestasdata;
  PrefiestasModel? prefiestasdata;

  bool _postLoading = false;

  fiestasgetPosts() async {
    var net = await Internetcheck.check();
    if (net == false) {
      Internetcheck.showdialog(context: context);
    }
    {
      setState(() {
        _postLoading = true;
      });
      await fiestasPostGet().then((FiestasModel? posts) {
        setState(() {
          fiestasdata = posts;
          _postLoading = false;
        });
      });

      preFiestasPostget();
    }
  }

  preFiestasPostget() async {
    setState(() {
      _postLoading = true;
    });
    await prefiestasPostGet().then((posts) {
      setState(() {
        prefiestasdata = posts;
        _postLoading = false;
      });
    });

    setState(() {
      _postLoading = false;
    });
  }

  DateTime nowdate = DateTime.now();
  ScrollController _scrollController = ScrollController();

  DateTime? selectedDate;
  Map<String, dynamic> itemSelected = {};

  var dates = [
    {
      "date": 2,
      "month": "Jun",
      "year": "2021",
      "active": false,
      "dateTime": DateTime
    }
  ];

  // Getting the total number of days of the month

  daysInMonth(DateTime date) {
    dates = [];
    print(date.toString());
    print(DateFormat('EE, d MMM, yyyy').format(date));

    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);

    int daysnum = firstDayNextMonth.difference(firstDayThisMonth).inDays;

    for (var i = 1; i <= daysnum; i++) {
      DateTime nowdate = DateTime(date.year, date.month, i);

      setState(() {
        dates.add({
          "fulldate": nowdate,
          "date": i,
          "day": DateFormat('EE').format(nowdate),
          "month": DateFormat('MMM').format(nowdate),
          "year": date.year,
          "active": false
        });
      });
    }
    print("noeDAte==>$nowdate");
    itemSelected.clear();
    itemSelected = {
      "fulldate": nowdate,
      "date": nowdate.day,
      "month": "${nowdate.month}",
      "year": "${nowdate.year}",
      "active": true
    };
    print("selectDate==>$itemSelected");

    for (var i = 0; i < daysnum; i++) {
      if (dates[i]['date'] == itemSelected['date']) {
        print("fhskhfkh-===" + dates[i].toString());
        dates[i]['active'] = true;
        _scrollController.animateTo(
            i * MediaQuery.of(context).size.width * 0.13,
            duration: new Duration(seconds: 2),
            curve: Curves.ease);
        break;
      }
    }

    //
  }

  checkDateSelected(date) {
    print(date);

    for (var i in dates) {
      // print(i["fulldate"]);
      if (i["active"] == true) {
        setState(() {
          i["active"] = false;
          return;
        });
      } else {
        setState(() {
          i["active"] = true;
          return;
        });
      }
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: nowdate,
      firstDate: DateTime(1950, 12),
      currentDate: selectedDate,
      lastDate: DateTime(2022, 12),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        print(picked.toString());
        nowdate = picked;
        daysInMonth(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fiestasgetPosts();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    daysInMonth(nowdate);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors.homeBackground,
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // top bar
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.hello,
                          style: TextStyle(
                              fontSize: size.width * 0.038,
                              fontFamily: Fonts.dmSansRegular,
                              color: AppColors.white),
                        ),
                        Text(
                          // Strings.garyadams,
                          "${Constants.prefs?.getString("name")}",
                          style: TextStyle(
                              fontSize: size.width * 0.048,
                              fontFamily: Fonts.dmSansBold,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        // location choose

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Icon(
                            //   // Icons.fmd_good,
                            //   Icons.error,
                            //   size: size.width * 0.04,
                            //   color: AppColors.white,
                            // ),

                            Container(
                              width: size.width * 0.03,
                              child: Image.asset(Images.locationspng),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.2,
                              ),
                              child: Text(
                                Constants.prefs?.getString("addres") != null
                                    ? "${Constants.prefs?.getString("addres")}"
                                    : Strings.location,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: size.width * 0.034,
                                    fontFamily: Fonts.dmSansMedium,
                                    color: AppColors.white),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Icon(
                              Icons.expand_more,
                              size: size.width * 0.042,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // notification icon
                    Container(
                      margin: EdgeInsets.only(right: size.width * 0.03),
                      child: Icon(
                        Icons.notifications,
                        size: size.width * 0.08,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              // body

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
                                      Strings.fiestas,
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
                                      Strings.preFiestas,
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

              SizedBox(
                height: size.width * 0.015,
              ),

              // body fiestas

              fiestasButton
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01,
                              horizontal: size.width * 0.04),
                          width: size.width,
                          height: size.height * 0.055,
                          child:
                              // tags
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return tagbutton(
                                              context: context,
                                              text: Strings.club,
                                              borderColor: AppColors.white,
                                              borderwidth: size.width * 0.001);
                                        })),

                                SizedBox(
                                  width: size.width * 0.02,
                                ),

                                // right button
                                Container(
                                    margin: EdgeInsets.only(
                                        right: size.width * 0.01),
                                    alignment: Alignment.centerRight,
                                    child:
                                        // SvgPicture.asset(Images.filterSvg)

                                        Image.asset(Images.filterPng)
                                    //     Icon(
                                    //   Icons.grid_view,
                                    //   color: Colors.white,
                                    // ),
                                    )
                              ]),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),

                        // pick fiesta's day

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01,
                                  horizontal: size.width * 0.04),
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Strings.pickfiestasday,
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        fontFamily: Fonts.dmSansMedium,
                                        color: AppColors.white),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  Container(
                                      // color: Colors.blue,
                                      width: size.width,
                                      height: size.height * 0.07,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 12,
                                            child: ListView.builder(
                                                controller: _scrollController,
                                                itemCount: dates.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      String pic = dates[index]
                                                              ["fulldate"]
                                                          .toString();
                                                      DateTime picked =
                                                          DateTime.parse(pic);

                                                      print(picked);
                                                      setState(() {
                                                        nowdate = picked;
                                                        daysInMonth(picked);
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: size.width *
                                                              0.01),
                                                      child: dateButton(
                                                          context: context,
                                                          text: dates[index]
                                                                  ["date"]
                                                              .toString(),
                                                          textColor: dates[index]
                                                                      [
                                                                      "active"] ==
                                                                  true
                                                              ? AppColors
                                                                  .homeBackground
                                                              : AppColors.white,
                                                          month: dates[index]
                                                                  ["month"]
                                                              .toString(),
                                                          borderColor:
                                                              AppColors.white,
                                                          borderwidth: size.width *
                                                              0.003,
                                                          backgroundColor:
                                                              dates[index]["active"] ==
                                                                      true
                                                                  ? AppColors
                                                                      .tagBorder
                                                                  : AppColors
                                                                      .homeBackground),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectDate(context);
                                              },
                                              child: SvgPicture.asset(
                                                Images.calenderSvg,
                                                height: size.height * 0.1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: size.height * 0.04,
                        ),
                      ],
                    )
                  : SizedBox(),

              // POSTS

              fiestasButton
                  ? Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01,
                              horizontal: size.width * 0.04),
                          // height: size.height,
                          width: size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Strings.nearbyfiestas,
                                    style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontFamily: Fonts.dmSansBold,
                                        color: AppColors.white),
                                  ),
                                  Text(
                                    Strings.seeall,
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        fontFamily: Fonts.dmSansBold,
                                        color: AppColors.siginbackgrond),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Expanded(
                                  child: _postLoading == true
                                      ? Center(
                                          child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      AppColors.white)))
                                      : fiestasdata?.data?.data?.length == 0 &&
                                              _postLoading == false
                                          ? Center(
                                              child: Text(
                                                Strings.PostsEmpty,
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize:
                                                        size.width * 0.04),
                                              ),
                                            )
                                          : ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: fiestasdata
                                                      ?.data?.data?.length ??
                                                  0,
                                              itemBuilder: (context, index) {
                                                return fiestasItem(
                                                    context: context,
                                                    postModeldata: fiestasdata
                                                        ?.data?.data
                                                        ?.elementAt(index));
                                              })),
                            ],
                          )),

                      //
                    )
                  : SizedBox(),

              // pre fiestas

              fiestasButton == false
                  ? preFiestas(context, prefiestasdata, _postLoading)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

Widget preFiestas(context, PrefiestasModel? prefiestasdata, _postLoading) {
  var size = MediaQuery.of(context).size;
  return Column(
    children: [
      Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.01),
          width: size.width,
          height: size.height * 0.17,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(bannerImage), fit: BoxFit.cover))),

      // posts

      Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
        ),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              Strings.preFiestasOffers,
              style: TextStyle(
                  fontSize: size.width * 0.043,
                  fontFamily: Fonts.dmSansBold,
                  color: AppColors.white),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
                height: size.height * 0.35,
                child: prefiestasdata?.data?.data?.length != 0 &&
                        _postLoading == false
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: prefiestasdata?.data?.data?.length,
                        itemBuilder: (context, index) {
                          return preFiestasItem(
                              context, prefiestasdata?.data?.data?[index]);
                        })
                    : prefiestasdata?.data?.data?.length == 0 &&
                            _postLoading == false
                        ? Center(
                            child: Text(
                              Strings.PostsEmpty,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: size.width * 0.04),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white)))),
          ],
        ),
      )
    ],
  );
}
