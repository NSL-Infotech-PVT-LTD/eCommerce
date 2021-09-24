import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/locationget.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/zeroadd.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/filterModel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/ui/screens/address/addressList.dart';
import 'package:funfy/ui/screens/fiestasAll.dart';
import 'package:funfy/ui/screens/notifications.dart';
import 'package:funfy/ui/widgets/dateButton.dart';
import 'package:funfy/ui/widgets/postsitems.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:intl/intl.dart';

class HomeMPage extends StatefulWidget {
  @override
  _HomeMPageState createState() => _HomeMPageState();
}

class _HomeMPageState extends State<HomeMPage> {
  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  TabController? controller;
  bool fiestasButton = true;

  PrefiestasModel? prefiestasdata;
  FliterListModel? filterModel;
  // FiestasModel? fiestasdata;

  bool _postLoading = false;

  bool _fiestasPostLoading = false;

  bool _prefiestasPostLoading = false;

  String tagType = "";
  String dateFilterFiestas = "";

  DateTime nowdate = DateTime.now();
  String? filterDate = "";

  Map<String, int> groupvalue = {};

  Map<String, String> filterData = {
    "local": "",
    "environment": "",
    "schedule": "",
    "music": "",
    "clothing": "",
    "ageGroup": ""
  };

  // pagination

  bool fiestasLoadingPage = false;
  bool prefiestasLoadingPage = false;

  ScrollController _fiestasScrollController = ScrollController();
  int limitCount = 5;
  int fiestasPageCount = 1;
  int prefiestasPageCount = 1;

  _handleRadioValueChange(int? value, String key) {
    setState(() {
      groupvalue["$key"] = value!;
    });
  }

  getFilterData() async {
    print("Run");
    await filterList().then((value) {
      // print(value?.toJson());

      for (var i in value!.data!.toJson().keys.toList()) {
        // print(i);

        groupvalue["$i"] = -1;
        filterData["$i"] = "";
      }

      setState(() {
        filterModel = value;
      });
    });
  }

  fiestasgetPosts({
    String? date,
  }) async {
    var net = await Internetcheck.check();
    if (net == false) {
      Internetcheck.showdialog(context: context);
    }
    {
      try {
        setState(() {
          UserData.fiestasdata = FiestasModel();
          _fiestasPostLoading = true;
        });
        await fiestasPostGet(
                limitCount: limitCount.toString(),
                pageCount: "1",
                context: context,
                type: tagType,
                dateFilter: date.toString(),
                filterDataF: filterData)
            .then((FiestasModel? posts) {
          setState(() {
            // print(posts?.toJson());
            UserData.fiestasdata = posts;
            _fiestasPostLoading = false;
          });
        });
      } catch (e) {
        print("fiestas Error $e");
      }
    }
  }

  preFiestasPostget() async {
    var net = await Internetcheck.check();

    if (net == false) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _prefiestasPostLoading = true;
      });
      await prefiestasPostGet(
              context: context,
              pageCount: prefiestasPageCount.toString(),
              limitCount: limitCount.toString())
          .then((posts) {
        // print(posts?.toJson());
        setState(() {
          prefiestasdata = PrefiestasModel();
          prefiestasdata = posts;
          _prefiestasPostLoading = false;
        });
      });
    }
  }

  fiestasFilterListGet() async {
    var net = await Internetcheck.check();
    if (net == false) {
      Internetcheck.showdialog(context: context);
    }
    {
      try {
        setState(() {
          _fiestasPostLoading = true;
        });
        await filterList().then((res) {
          setState(() {
            filterModel = res;
            _fiestasPostLoading = false;
          });
        });
      } catch (e) {
        print("fiestas Error $e");
      }
    }
  }

  ScrollController _scrollController = ScrollController();

  DateTime? selectedDate;
  Map<String, dynamic> itemSelected = {};

  var dates = [
    {
      "date": 1,
      "month": "Jun",
      "year": "2021",
      "active": false,
      "dateTime": DateTime
    },
  ];

  // Getting the total number of days of the month

  daysInMonth(DateTime date) async {
    dates = [];
    // print(date.toString());
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
    // print("noeDAte==>$nowdate");

    itemSelected.clear();
    itemSelected = {
      "fulldate": nowdate,
      "date": nowdate.day,
      "month": "${nowdate.month}",
      "year": "${nowdate.year}",
      "active": filterDate == "" ? false : true
    };

    // print("selectDate==>$itemSelected");

    for (var i = 0; i < daysnum; i++) {
      if (dates[i]['date'] == itemSelected['date']) {
        // print("fhskhfkh-===" + dates[i].toString());
        dates[i]['active'] = filterDate == "" ? false : true;
        if (_scrollController.hasClients)
          _scrollController.animateTo(
              i * MediaQuery.of(context).size.width * 0.13,
              duration: new Duration(seconds: 2),
              curve: Curves.ease);

        break;
      }
    }

    //
  }

  clearFilter() {
    setState(() {
      // filterDate = "";
      tagType = "";
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: nowdate,
      firstDate: DateTime.now(),
      currentDate: selectedDate,
      lastDate: DateTime(2050, 12),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        // print(picked.toString());
        nowdate = picked;
        daysInMonth(picked);
      });

      // get fiestast post

      String? fomatDate = await dateFormat(date: picked);

      setState(() {
        filterDate = fomatDate;
      });
      // print("Date :- $fomatDate");

      fiestasgetPosts(date: fomatDate);
    }
  }

  @override
  void initState() {
    // page

    _fiestasScrollController.addListener(() {
      double maxScroll = _fiestasScrollController.position.maxScrollExtent;
      double currentScroll = _fiestasScrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        fiestasPagination();
        prefiestasPagination();
      }
    });

    super.initState();
    paymentconfigApi(context: context);
    fiestasgetPosts(date: filterDate);

    preFiestasPostget();
    determinePosition();
    getFilterData();
  }

  //pagination
  fiestasPagination() async {
    var net = await Internetcheck.check();

    if (net == false) {
      Internetcheck.showdialog(context: context);
    }
    {
      if (fiestasLoadingPage) {
        return;
      }

      if (fiestasPageCount >
          int.parse('${UserData.fiestasdata?.data?.lastPage ?? 0}')) {
        print('No More Products');

        return;
      }

      if (UserData.fiestasdata != null) {
        try {
          setState(() {
            fiestasLoadingPage = true;
          });
          // print("get data ........");
          fiestasPageCount = fiestasPageCount + 1;
          await fiestasPostGet(
                  limitCount: limitCount.toString(),
                  pageCount: fiestasPageCount.toString(),
                  context: context,
                  type: tagType,
                  dateFilter: filterDate,
                  filterDataF: filterData)
              .then((FiestasModel? posts) {
            setState(() {
              var fdata = posts?.data?.data;
              UserData.fiestasdata?.data?.data?.addAll(fdata!);
              fiestasLoadingPage = false;
            });
          });
        } catch (e) {
          print("fiestas Error $e");
          setState(() {
            fiestasLoadingPage = false;
          });
        }
      }
    }
  }

  prefiestasPagination() async {
    var net = await Internetcheck.check();

    if (net == false) {
      Internetcheck.showdialog(context: context);
    }
    {
      if (prefiestasLoadingPage) {
        return;
      }

      if (prefiestasPageCount >
          int.parse('${prefiestasdata?.data?.lastPage ?? 0}')) {
        print('No More Products');

        return;
      }

      if (prefiestasdata != null) {
        try {
          print("get data pre ........");
          prefiestasPageCount = prefiestasPageCount + 1;
          setState(() {
            prefiestasLoadingPage = true;
          });
          await prefiestasPostGet(
                  context: context,
                  pageCount: prefiestasPageCount.toString(),
                  limitCount: limitCount.toString())
              .then((posts) {
            // print(posts?.toJson());
            setState(() {
              var preData = posts?.data?.data;
              prefiestasdata?.data?.data?.addAll(preData!); // = posts;
              prefiestasLoadingPage = false;
            });
          });
        } catch (e) {
          print("fiestas Error $e");
          setState(() {
            prefiestasLoadingPage = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _fiestasScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // int number = 0;

  // bottom bar ---------- //

  @override
  Widget build(BuildContext context) {
    daysInMonth(nowdate);
    var size = MediaQuery.of(context).size;

    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => Home(pageIndexNum: 0)));

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        // systemNavigationBarIconBrightness: Brightness.dark,
        // systemNavigationBarColor: Colors.blue,
        // statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.black, // Note RED here
      ),
    );

    return SafeArea(
      child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //     onPressed: () {
          //       print(Constants.prefs?.getString("language"));
          //     },
          //     child: Icon(Icons.add)),
          backgroundColor: AppColors.blackBackground,
          body: CustomScrollView(
            controller: _fiestasScrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: size.height * 0.15,
                backgroundColor: AppColors.blackBackground,
                actions: [
                  InkWell(
                    onTap: () {
                      navigatorPushFun(context, AddressList(navNum: 0));
                    },
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context, "hello")}",
                                //  Strings.hello,
                                style: TextStyle(
                                    fontSize: size.width * 0.038,
                                    fontFamily: Fonts.dmSansRegular,
                                    color: AppColors.white),
                              ),
                              Container(
                                width: size.width * 0.6,
                                child: Text(
                                  // Strings.garyadams,
                                  "${Constants.prefs?.getString("name")}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: size.width * 0.048,
                                      fontFamily: Fonts.dmSansBold,
                                      color: AppColors.white),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),

                              // location choose

                              InkWell(
                                onTap: () {
                                  navigatorPushFun(
                                      context, AddressList(navNum: 0));
                                },
                                child: Row(
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
                                        maxWidth: size.width * 0.3,
                                      ),
                                      child: Text(
                                        Constants.prefs?.getString("addres") !=
                                                    null &&
                                                Constants.prefs
                                                        ?.getString("addres") !=
                                                    ''
                                            ? "${Constants.prefs?.getString("addres")}"
                                            : "${getTranslated(context, "addLoacation")}", // Strings.location,
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
                              ),
                            ],
                          ),

                          // notification icon
                          InkWell(
                            onTap: () {
                              navigatorPushFun(context, Notifications());
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: size.width * 0.03),
                              child: Icon(
                                Icons.notifications,
                                size: size.width * 0.08,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              SliverAppBar(
                floating: true,
                backgroundColor: AppColors.blackBackground,
                toolbarHeight: size.height * 0.01,
              ),
              SliverAppBar(
                forceElevated: true,
                floating: true,
                // pinned: true,
                // backgroundColor: Colors.brown,
                toolbarHeight: size.height * 0.085,
                backgroundColor: AppColors.blackBackground,
                actions: [
                  //fp
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.04),
                    // color: Colors.blue,
                    width: size.width,
                    // height: size.height * 0.09,
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
                                          //    Strings.fiestas,
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
                                          //   Strings.preFiestas,
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
                ],
              ),

              // Fiestas filter ------------ //

              fiestasButton == false
                  ? SliverToBoxAdapter(
                      child: SizedBox(),
                    )
                  : SliverToBoxAdapter(
                      child: Column(
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
                                      child: Container(
                                    // color: Colors.blue,
                                    child: Text(
                                      "${getTranslated(context, 'filter')}",
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: Fonts.dmSansBold,
                                          fontSize: size.width * 0.055),
                                    ),
                                  )),

                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),

                                  // right button -------------- //
                                  InkWell(
                                    onTap: () {
                                      filterBottomSheet();
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right: size.width * 0.01),
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                            "assets/pngicons/filter.png")),
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
                                      "${getTranslated(context, "pickfiestasday")}",
                                      // Strings.pickfiestasday,
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontFamily: Fonts.dmSansMedium,
                                          color: AppColors.white),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    Container(
                                        width: size.width,
                                        height: size.height * 0.06,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 12,
                                              child: ListView.builder(
                                                  controller: _scrollController,
                                                  itemCount: dates.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DateTime date =
                                                        DateTime.now();

                                                    DateTime mapDate =
                                                        DateTime.parse(
                                                            "${dates[index]['fulldate']}");

                                                    // date work only future date show

                                                    if ((int.parse(
                                                                "${mapDate.day}") >=
                                                            int.parse(
                                                                "${date.day}")) ||
                                                        (int.parse("${mapDate.month}") >
                                                                int.parse(
                                                                    "${date.month}") &&
                                                            int.parse(
                                                                    "${mapDate.year}") ==
                                                                int.parse(
                                                                    "${date.year}")) ||
                                                        (int.parse(
                                                                "${mapDate.year}") >
                                                            int.parse(
                                                                "${date.year}"))) {
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          String pic = dates[
                                                                      index]
                                                                  ["fulldate"]
                                                              .toString();
                                                          DateTime picked =
                                                              DateTime.parse(
                                                                  pic);
                                                          DateTime currentDate =
                                                              DateTime.now();

                                                          setState(() {
                                                            nowdate = picked;
                                                            daysInMonth(picked);
                                                          });

                                                          // get fiestast post

                                                          String? fomatDate =
                                                              await dateFormat(
                                                                  date: picked);

                                                          setState(() {
                                                            filterDate =
                                                                fomatDate;
                                                          });

                                                          fiestasgetPosts(
                                                              date: fomatDate);

                                                          print(
                                                              "date is here - $fomatDate");
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
                                                              textColor: dates[index]["active"] ==
                                                                      true
                                                                  ? AppColors
                                                                      .homeBackground
                                                                  : AppColors
                                                                      .white,
                                                              month: dates[index]
                                                                      ["month"]
                                                                  .toString(),
                                                              borderColor:
                                                                  AppColors
                                                                      .white,
                                                              borderwidth:
                                                                  size.width *
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
                                                    }

                                                    // hide date

                                                    return GestureDetector(
                                                      onTap: () async {
                                                        Dialogs.showBasicsFlash(
                                                            context: context,
                                                            duration: Duration(
                                                                seconds: 1),
                                                            color: AppColors
                                                                .siginbackgrond,
                                                            content: getTranslated(
                                                                context,
                                                                "youcantselectpastdate"));
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
                                                            textColor:
                                                                Colors.grey,
                                                            month: dates[index]
                                                                    ["month"]
                                                                .toString(),
                                                            borderColor:
                                                                Colors.grey,
                                                            borderwidth:
                                                                size.width *
                                                                    0.003,
                                                            backgroundColor: dates[
                                                                            index]
                                                                        [
                                                                        "active"] ==
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
                      ),
                    ),

              fiestasButton
                  ? SliverToBoxAdapter(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${getTranslated(context, "nearbyfiestas")}",
                                  style: TextStyle(
                                      fontSize: size.width * 0.045,
                                      fontFamily: Fonts.dmSansBold,
                                      color: AppColors.white),
                                ),
                                (UserData.fiestasdata?.data?.data?.length ==
                                            0 &&
                                        _postLoading == false)
                                    ? SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          if (_postLoading) {
                                            Dialogs.showBasicsFlash(
                                                context: context,
                                                duration: Duration(seconds: 1),
                                                content:
                                                    "${getTranslated(context, 'pleaseWait')}");
                                          } else {
                                            navigatorPushFun(
                                                context, FiestasAll());
                                          }
                                        },
                                        child: Container(
                                          // color: Colors.blue,
                                          child: Text(
                                            "${getTranslated(context, "seeall")}",
                                            //   Strings.seeall,
                                            style: TextStyle(
                                                fontSize: size.width * 0.04,
                                                fontFamily: Fonts.dmSansBold,
                                                color:
                                                    AppColors.siginbackgrond),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: SizedBox(),
                    ),

              // fiestasPost List

              fiestasButton
                  ? _fiestasPostLoading == true
                      ? SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(top: size.height * 0.16),
                            child: Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.white))),
                          ),
                        )
                      : UserData.fiestasdata?.data?.data?.length == 0 &&
                                  _postLoading == false ||
                              UserData.fiestasdata == null
                          ? SliverToBoxAdapter(
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.16),
                                child: Center(
                                  child: Text(
                                    "${getTranslated(context, "PostsEmpty")}",
                                    //     Strings.PostsEmpty,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: size.width * 0.04),
                                  ),
                                ),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index ==
                                        int.parse(
                                            '${UserData.fiestasdata?.data?.data?.length ?? 0}') &&
                                    fiestasLoadingPage) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                  child: fiestasItem(
                                      context: context,
                                      postModeldata: UserData
                                          .fiestasdata?.data?.data
                                          ?.elementAt(index)),
                                );
                              },
                              childCount: fiestasLoadingPage
                                  ? int.parse(
                                          '${UserData.fiestasdata?.data?.data?.length ?? 0}') +
                                      1
                                  : int.parse(
                                      '${UserData.fiestasdata?.data?.data?.length ?? 0}'),
                            ))
                  : SliverToBoxAdapter(
                      child: SizedBox(),
                    ),

              // Prefiestas -------------------- //

              fiestasButton == false
                  ? SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03,
                                  vertical: size.height * 0.01),
                              width: size.width,
                              height: size.height * 0.17,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      // image: NetworkImage(bannerImage),
                                      image: AssetImage(
                                          'assets/pngicons/banner.png'),
                                      fit: BoxFit.cover))),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                            ),
                            child: Text(
                              "${getTranslated(context, "preFiestasOffers")}",
                              //  Strings.preFiestasOffers,
                              style: TextStyle(
                                  fontSize: size.width * 0.043,
                                  fontFamily: Fonts.dmSansBold,
                                  color: AppColors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                        ],
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: SizedBox(),
                    ),

              fiestasButton == false
                  ? _prefiestasPostLoading == true
                      ? SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(top: size.height * 0.16),
                            child: Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.white))),
                          ),
                        )
                      : prefiestasdata?.data?.data?.length == 0 &&
                                  _prefiestasPostLoading == false ||
                              prefiestasdata == null
                          ? SliverToBoxAdapter(
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.16),
                                child: Center(
                                  child: Text(
                                    "${getTranslated(context, "PostsEmpty")}",
                                    //     Strings.PostsEmpty,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: size.width * 0.04),
                                  ),
                                ),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index ==
                                        int.parse(
                                            "${prefiestasdata?.data?.data?.length ?? 0}") &&
                                    prefiestasLoadingPage) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                  child: preFiestasItem(
                                      context: context,
                                      index: index,
                                      prefiestasdata:
                                          prefiestasdata?.data?.data?[index]),
                                );
                              },
                              childCount: prefiestasLoadingPage
                                  ? int.parse(
                                          "${prefiestasdata?.data?.data?.length ?? 0}") +
                                      1
                                  : int.parse(
                                      "${prefiestasdata?.data?.data?.length ?? 0}"),
                            ))
                  : SliverToBoxAdapter(
                      child: SizedBox(),
                    ),
            ],
          )),
    );
  }

  // filter box

  filterBottomSheet() {
    var size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: AppColors.blackBackground,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              key: _keyScaffold,
              builder: (context, setstate) {
                return Container(
                  // margin: EdgeInsets.only(top: size.height * 0.04),
                  height: size.height * 0.98,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.034),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              navigatePopFun(context);

                              setstate(() {
                                for (var i in filterData.keys.toList()) {
                                  groupvalue["$i"] = -1;
                                }

                                filterData = {
                                  "local": "",
                                  "environment": "",
                                  "schedule": "",
                                  "music": "",
                                  "clothing": "",
                                  "ageGroup": ""
                                };
                              });
                            },
                            child: Container(
                              child: Icon(
                                Icons.clear,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          // Text(
                          //   "${getTranslated(context, 'clear')}",
                          //   style: TextStyle(
                          //       fontSize: size.width * 0.05,
                          //       fontFamily: Fonts.dmSansBold,
                          //       color: AppColors.white),
                          // ),

                          SizedBox(
                            // width: size.width * 0.22,
                            child: MaterialButton(
                              onPressed: () {
                                setstate(() {
                                  for (var i in filterData.keys.toList()) {
                                    groupvalue["$i"] = -1;
                                  }

                                  filterData = {
                                    "local": "",
                                    "environment": "",
                                    "schedule": "",
                                    "music": "",
                                    "clothing": "",
                                    "ageGroup": ""
                                  };
                                });

                                Dialogs.showBasicsFlash(
                                    duration: Duration(seconds: 1),
                                    context: context,
                                    content:
                                        "${getTranslated(context, 'filterSuccessfullycleared')}",
                                    color: Colors.green);

                                fiestasgetPosts(date: filterDate);

                                navigatePopFun(context);
                              },
                              child: Text(
                                "${getTranslated(context, 'reset')}",
                                style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontFamily: Fonts.dmSansBold,
                                    color: AppColors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Expanded(
                          child: Container(
                        child: ListView.builder(
                            itemCount: filterModel?.data?.toJson().length ?? 0,
                            itemBuilder: (context, index) {
                              return itemFilter(
                                  context,
                                  filterModel?.data
                                      ?.toJson()
                                      .keys
                                      .toList()[index],
                                  filterModel?.data
                                      ?.toJson()
                                      .values
                                      .toList()[index],
                                  setstate);
                            }),
                      )),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            color: AppColors.siginbackgrond,
                            textColor: AppColors.white,
                            onPressed: () {
                              navigatePopFun(context);
                              fiestasgetPosts(date: filterDate);
                            },
                            child: Text(
                                "${getTranslated(context, 'applyFilter')}"),
                          )
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }

  itemFilter(context, key, value, state) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            "${key.toUpperCase()}",
            style: TextStyle(
                fontSize: size.width * 0.06,
                fontFamily: Fonts.dmSansBold,
                color: AppColors.siginbackgrond),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Column(
            children: [
              for (int i = 0; i < value.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${key == 'ageGroup' ? value[i] : value[i]['name']}",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontFamily: Fonts.dmSansMedium,
                          color: AppColors.white),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: AppColors.white,
                      ),
                      child: Radio<int?>(
                          value: i,
                          groupValue: groupvalue["$key"],
                          onChanged: (_v) {
                            if (key == 'ageGroup') {
                              filterData['$key'] = value[i].toString();
                            } else {
                              filterData['$key'] = value[i]['id'].toString();
                            }

                            _handleRadioValueChange(i, key);

                            // print(filterData);
                            state(() {});

                            // setState(() {});
                          }),
                    ),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
