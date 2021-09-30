import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/shortPrices.dart';
import 'package:funfy/models/favourite/fiestasFavouriteModel.dart';
import 'package:funfy/models/favourite/preFiestasFavModel.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/ui/screens/fiestasBook.dart';
import 'package:funfy/ui/screens/preFistaOrderMix.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:intl/intl.dart';

class Favourite extends StatefulWidget {
  Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool fiestasButton = true;
  bool _loading = false;
  bool prifestasLoading = false;

  FiestasFavouriteModel? fiestasFavModel;
  PrefiestasFavouriteModel? preFiestasFavModel;

  ScrollController _fiestasScrollController = ScrollController();
  bool fiestasPageLoading = false;
  int fiestasPage = 1;

  @override
  void initState() {
    _fiestasScrollController.addListener(() {
      double maxScroll = _fiestasScrollController.position.maxScrollExtent;
      double currentScroll = _fiestasScrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        print("Fiestas page ...............");
        fiestasPagination();
      }
    });
    super.initState();
    prifiestaFavList();

    getFavouriteList();
  }

  getFavouriteList() async {
    fiestasPage = 1;
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });

      try {
        fiestasFavouriteListApi().then((res) {
          setState(() {
            fiestasFavModel = res;
            _loading = false;
          });
        });
      } catch (e) {
        setState(() {
          _loading = false;
        });

        print("error in fiestas - $e");
      }
    }
  }

  prifiestaFavList() {
    setState(() {
      prifestasLoading = true;
    });
    try {
      prefiestasFavouriteListApi().then((res) {
        setState(() {
          preFiestasFavModel = res;
          prifestasLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        prifestasLoading = false;
      });

      print("error in prefiestas - $e");
    }
  }

  // fiestas pagination

  //pagination
  fiestasPagination() async {
    var net = await Internetcheck.check();

    if (net == false) {
      Internetcheck.showdialog(context: context);
    } else {
      if (fiestasPageLoading) {
        return;
      }

      if (fiestasPage > (fiestasFavModel?.data?.lastPage ?? 1)) {
        print('No More Products');

        return;
      }

      try {
        setState(() {
          fiestasPageLoading = true;
        });

        fiestasPage = fiestasPage + 1;

        fiestasFavouriteListApi(pageCount: fiestasPage).then((res) {
          setState(() {
            var data = res?.data?.data?.toList();
            // fiestasFavModel = res;
            fiestasFavModel?.data?.data?.addAll(data!);
            fiestasPageLoading = false;
          });
        });
      } catch (e) {
        print("fiestasbooking page Error $e");
        setState(() {
          fiestasPageLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _fiestasScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blackBackground,
      appBar: AppBar(
        backgroundColor: AppColors.blackBackground,
        centerTitle: true,
        title: Text(
          "${getTranslated(context, "favourite")}",
          style: TextStyle(
              color: AppColors.white,
              fontFamily: Fonts.dmSansBold,
              fontSize: size.width * 0.05),
        ),
      ),
      body: Column(
        children: [
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

          // fiestas and prefiestas

          fiestasButton
              ? Expanded(
                  child: Stack(
                    children: [
                      // loading
                      _loading
                          ? Center(child: CircularProgressIndicator())
                          : (_loading == false &&
                                      fiestasFavModel?.data?.data?.length ==
                                          0) ||
                                  (_loading == false && fiestasFavModel == null)
                              ? Center(
                                  child: Text(
                                  "${getTranslated(context, 'listisEmpty')}",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: size.width * 0.05),
                                ))
                              : ListView.builder(
                                  controller: _fiestasScrollController,
                                  itemCount:
                                      fiestasFavModel?.data?.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    // fiestasPageLoading

                                    if ((index ==
                                            int.parse(
                                                    "${fiestasFavModel?.data?.data?.length}") -
                                                1) &&
                                        fiestasPageLoading) {
                                      return Container(
                                        height: size.height * 0.08,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                    return fiestasItemFav(
                                      context: context,
                                      index: index,
                                      model: fiestasFavModel,
                                      funcRun: getFavouriteList,
                                    );
                                  }),
                    ],
                  ),
                )
              : Expanded(
                  child: Stack(
                    children: [
                      prifestasLoading
                          ? Center(child: CircularProgressIndicator())
                          : (_loading == false &&
                                      preFiestasFavModel?.data?.data?.length ==
                                          0) ||
                                  (_loading == false &&
                                      preFiestasFavModel == null)
                              ? Center(
                                  child: Text(
                                  "${getTranslated(context, 'listisEmpty')}",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: size.width * 0.05),
                                ))
                              : ListView.builder(
                                  itemCount:
                                      preFiestasFavModel?.data?.data?.length,
                                  itemBuilder: (context, index) {
                                    return preFiestasItem(
                                      context: context,
                                      index: index,
                                      prefiestasdata: preFiestasFavModel,
                                      funcRunPre: getFavouriteList,
                                    );
                                  }),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}

// favorItem fiestas

fiestasItemFav({context, int? index, FiestasFavouriteModel? model, funcRun}) {
  var size = MediaQuery.of(context).size;

  var data = model?.data?.data?.elementAt(index!);

  DateTime? date = DateTime.parse("${data?.timestamp}");

  String month = DateFormat('MMM').format(date);

  String price = k_m_b_generator(double.parse("${data?.ticketPriceNormal}"));

  return InkWell(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => FiestasBook(fiestasID: data?.id)))
          .then((value) {
        funcRun();
      });
    },
    child: Container(
      margin: EdgeInsets.only(top: size.width * 0.04),
      width: size.width,
      height: size.height * 0.28,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                Images.beerNetwork,
              ),
              // "${data?.image}"),

              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.0035),
              color: AppColors.homeBackground.withOpacity(0.4),
              width: size.width * 0.1,
              height: size.height * 0.055,
              child: Container(
                height: size.height * 0.047,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "${date.day}",
                        style: TextStyle(
                            fontSize: size.width * 0.043,
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white),
                      ),
                    ),
                    Text(
                      "${month.toUpperCase()}",
                      style: TextStyle(
                          fontSize: size.width * 0.027,
                          fontFamily: Fonts.dmSansMedium,
                          color: AppColors.white),
                    ),
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.01),
            height: size.height * 0.15,
            decoration: BoxDecoration(
                color: AppColors.homeBackground,
                border: Border(
                  left: BorderSide(
                      width: size.height * 0.001, color: AppColors.tagBorder),
                  right: BorderSide(
                      width: size.height * 0.001, color: AppColors.tagBorder),
                  bottom: BorderSide(
                      width: size.height * 0.001, color: AppColors.tagBorder),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data?.name}",
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontFamily: Fonts.dmSansBold,
                          color: AppColors.white),
                    ),
                    SizedBox(
                      height: size.height * 0.004,
                    ),
                    Text(
                      "${data?.distanceMiles}",
                      style: TextStyle(
                          fontSize: size.width * 0.03,
                          fontFamily: Fonts.dmSansMedium,
                          color: AppColors.white),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Container(
                        // width: size.width * 0.3,
                        child: ratingstars(
                            size: size.width * 0.05,
                            ittempading: size.width * 0.0001,
                            color: AppColors.tagBorder,
                            rating: 4))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Strings.startingfrom,
                      style: TextStyle(
                          fontSize: size.width * 0.025,
                          fontFamily: Fonts.dmSansMedium,
                          color: AppColors.white),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Strings.euro,
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontFamily: Fonts.dmSansBold,
                              color: AppColors.white),
                        ),
                        Text(
                          // data?.fiestaDetail?.ticketPrice?.length > 9
                          //     ? "${postModeldata.ticketPrice?.substring(0, 9)}"
                          //     : "${postModeldata.ticketPrice}",

                          "$price",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: size.width * 0.068,
                              fontFamily: Fonts.dmSansBold,
                              color: AppColors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    FiestasBook(fiestasID: data?.id)))
                            .then((value) {
                          funcRun();
                        });

                        // navigatorPushFun(
                        //     context, BookNowBeta(fiestasModel: data));
                      },
                      child: roundedBoxR(
                          width: size.width * 0.23,
                          height: size.height * 0.033,
                          radius: 3.0,
                          backgroundColor: AppColors.siginbackgrond,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              Strings.booknow,
                              style: TextStyle(
                                  fontSize: size.width * 0.03,
                                  fontFamily: Fonts.dmSansBold,
                                  color: AppColors.white),
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

// pre
Widget preFiestasItem(
    {context,
    int? index,
    PrefiestasFavouriteModel? prefiestasdata,
    funcRunPre}) {
  var data = prefiestasdata?.data?.data?.elementAt(index!);
  var size = MediaQuery.of(context).size;

  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) =>
                  PreFistaOrder(preFiestasID: data?.preFiestaDetail?.id)))
          .then((value) {
        funcRunPre();
      });
    },
    child: Container(
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
                //left Image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: SvgPicture.asset(
                        Images.offeryellowBackgroundSvg,
                        fit: BoxFit.cover,
                        width: size.width * 0.11,
                      ),
                    ),
                    Container(
                      height: size.height * 0.055,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              Strings.from,
                              style: TextStyle(
                                  fontSize: size.width * 0.027,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  Strings.euro,
                                  style: TextStyle(
                                      fontSize: size.width * 0.03,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "29",
                                  style: TextStyle(
                                      fontSize: size.width * 0.06,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                // center content
                Container(
                    width: size.width * 0.5,
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data?.preFiestaDetail?.name}",
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

                        // description
                        Text(
                          "${data?.preFiestaDetail?.description}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.itemDescription,
                              fontSize: size.width * 0.03,
                              fontFamily: Fonts.dmSansRegular),
                        ),

                        SizedBox(
                          height: size.height * 0.013,
                        ),

                        // order Now
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => PreFistaOrder(
                                        preFiestasID:
                                            data?.preFiestaDetail?.id)))
                                .then((value) {
                              funcRunPre();
                            });
                          },
                          child: roundedBoxR(
                              radius: size.width * 0.005,
                              width: size.width * 0.2,
                              height: size.height * 0.04,
                              backgroundColor: AppColors.siginbackgrond,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Strings.orderNow,
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: size.width * 0.03,
                                      fontFamily: Fonts.dmSansBold),
                                ),
                              )),
                        )
                      ],
                    )),

                // right image

                Container(
                  margin: EdgeInsets.only(right: size.width * 0.01),
                  padding: EdgeInsets.only(
                      top: size.height * 0.02, bottom: size.height * 0.013),
                  width: size.width * 0.25,
                  decoration: BoxDecoration(),
                  child: Image.network(
                      "${data?.preFiestaDetail?.image ?? Images.beerNetwork}"

                      // fit: BoxFit.cover,
                      ),
                )
              ],
            ),
          )),
    ),
  );
}
