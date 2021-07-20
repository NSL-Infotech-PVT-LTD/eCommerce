import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/models/prifiestasAlMxEx.dart';
import 'package:funfy/ui/screens/pages/BookNow.dart';
import 'package:funfy/ui/widgets/basic%20function.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';

String bannerImage =
    "https://png.pngtree.com/thumb_back/fw800/back_our/20190621/ourmid/pngtree-tmall-beer-festival-e-commerce-carnival-banner-image_193689.jpg";

class PreFistaOrder extends StatefulWidget {
  final ProductInfo? prefiestasModel;

  const PreFistaOrder({Key? key, this.prefiestasModel}) : super(key: key);

  // const PreFistaOrder({Key? key, this.fiestasModel}) : super(key: key);

  @override
  _PreFistaOrderState createState() => _PreFistaOrderState();
}

class _PreFistaOrderState extends State<PreFistaOrder> {
  int? groupValue = 4;
  int? initvalue = 1;

  void _handleRadioValueChange(int? value) {
    setState(() {
      print(value);
      groupValue = value;
    });
  }

  CarouselController _carouselController = CarouselController();
  List<Widget> cardList = [];
  double _initialRating = 2.0;
  bool _isVertical = false;
  String name = "Loading...";
  String description = "Loading...";
  String freeDeliveryReturn = "Loading...";
  String price = "Loading...";
  List<Widget> alcoholList = [];

// model data
  PrefiestasAlMxExModel? alcohol;
  PrefiestasAlMxExModel? mix;
  PrefiestasAlMxExModel? extras;
  bool _loading = false;

  @override
  void initState() {
    cardList = List<SlidingBannerProviderDetails>.generate(
        3, (index) => SlidingBannerProviderDetails());
    super.initState();
    preFiestadatagetFromApi();
  }

  // + - count button
  Widget insdecButton() {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.white),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 0.01)),
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
            "0",
            style: TextStyle(
                fontFamily: "DM Sans Medium",
                fontSize: size.width * 0.04,
                color: AppColors.white),
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.03,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.skin,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 0.01)),
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
    );
  }

  ListTile alcoholGradientFunction(
      {index,
      String? title,
      String? subtitle,
      PrefiestasAlMxExModel? model,
      bool? numCount}) {
    var size = MediaQuery.of(context).size;
    var data = model?.data?.data;
    return ListTile(
        title: Text("${data![index].name}",
            style: TextStyle(
                color: AppColors.white,
                fontFamily: Fonts.dmSansBold,
                fontSize: SizeConfig.screenWidth * 0.045)),
        subtitle: Text("70 CL",
            style: TextStyle(
                color: AppColors.grayFont,
                fontFamily: Fonts.dmSansBold,
                fontSize: SizeConfig.screenWidth * 0.040)),
        trailing: numCount != true
            ? Radio<int?>(
                value: index,
                groupValue: groupValue,
                onChanged: _handleRadioValueChange)
            : Container(
                width: size.width * 0.25,
                child: insdecButton(),
              ));
  }

  // get data from api

  preFiestadatagetFromApi() async {
    var net = await Internetcheck.check();
    print("net = $net");

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });

      try {
        alcohollistget();
        mixlistget();
        extraslistget();
      } catch (e) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  // alcohol

  alcohollistget() async {
    await prefiestasAlMxExApi(
            id: widget.prefiestasModel?.id.toString(),
            categoriesName: Strings.alcohols)
        .then((res) {
      setState(() {
        alcohol = res;
        _loading = false;
      });
    });
  }

  // mixes

  mixlistget() async {
    await prefiestasAlMxExApi(
            id: widget.prefiestasModel?.id.toString(),
            categoriesName: Strings.mixs)
        .then((res) {
      setState(() {
        mix = res;
        _loading = false;
      });
    });
  }

  // extras

  extraslistget() async {
    await prefiestasAlMxExApi(
            id: widget.prefiestasModel?.id.toString(),
            categoriesName: Strings.extrass)
        .then((res) {
      setState(() {
        extras = res;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // inner heading
    Widget richText(
      String textStart,
      String textMiddle,
      String textEnd,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: size.width * 0.04),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.045,
                    fontFamily: Fonts.dmSansRegular,
                    color: AppColors.white),
                children: <TextSpan>[
                  TextSpan(
                      text: textStart,
                      style: TextStyle(color: AppColors.descriptionfirst)),
                  TextSpan(
                      text: textMiddle,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: textEnd,
                      style: TextStyle(color: AppColors.descriptionfirst)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          DottedLine(
            dashGapLength: size.width * 0.005,
            dashLength: size.width * 0.004,
            dashColor: AppColors.descriptionfirst,
          )
        ],
      );
    }

    // top heading
    Widget topHeadingContent({
      String? description,
      String? textEnd,
    }) {
      return RichText(
        maxLines: 3,
        text: TextSpan(
          style: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.04,
              fontFamily: Fonts.dmSansMedium,
              color: AppColors.white),
          children: <TextSpan>[
            TextSpan(
                text: description,
                style: TextStyle(color: AppColors.descriptionfirst)),
            TextSpan(
                text: textEnd, style: TextStyle(fontFamily: Fonts.dmSansBold)),
          ],
        ),
      );
    }

    // alcoholList =
    //     List<Widget>.generate(10, (index) => alcoholGradientFunction(index));

    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  collapsedHeight: 150.0,
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actions: [
                    SvgPicture.asset(
                      "assets/svgicons/hearticon.svg",
                      color: Colors.white,
                    )
                  ],
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          width: SizeConfig.screenWidth,
                          child: CarouselSlider(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                height: SizeConfig.screenHeight * 0.30,
                                autoPlay: false,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 2.0,
                                enableInfiniteScroll: false,
                                onPageChanged: (index, reason) {},
                              ),
                              items: cardList //cardList
                              ),
                        ),
                      ),
                      Positioned(bottom: 0.0, child: Text(""))
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        color: AppColors.homeBackground,
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // cvfbgtkl;./
                                  width: SizeConfig.screenWidth * 0.60,
                                  //   height: SizeConfig.screenHeight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        // left: SizeConfig.screenWidth * 0.02,
                                        top: size.width * 0.01),
                                    child: Text(
                                      "${widget.prefiestasModel?.name ?? "Name"}",
                                      style: TextStyle(
                                          fontSize: size.width * 0.058,
                                          fontFamily: "DM Sans Bold",
                                          color: AppColors.white),
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Container(
                                  // cvfbgtkl;./
                                  width: SizeConfig.screenWidth * 0.85,
                                  //   height: SizeConfig.screenHeight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        // left: SizeConfig.screenWidth * 0.02,
                                        top: size.width * 0.01),
                                    child: topHeadingContent(
                                        description:
                                            widget.prefiestasModel?.description,
                                        textEnd: " ${Strings.muchMore}"),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.005),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: AppColors.siginbackgrond,
                        // labelColor: Colors.black87,
                        // unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            icon: Text(Strings.alcohol),
                          ),
                          Tab(
                            icon: Text(Strings.mixes),
                          ),
                          Tab(
                            icon: Text(Strings.extras),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              _loading == true
                  ? Center(child: CircularProgressIndicator())
                  : _loading == false && alcohol?.data?.data == []
                      ? Center(
                          child: Text(
                            Strings.nodataFound,
                            style: TextStyle(
                                color: AppColors.descriptionfirst,
                                fontFamily: Fonts.dmSansBold,
                                fontSize: size.width * 0.045),
                          ),
                        )
                      : Container(
                          color: AppColors.homeBackgroundLite,
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.03,
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.95,
                                child: richText(
                                    "Select at most ", "One", " from Alcohols"),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: alcohol?.data?.data?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return alcoholGradientFunction(
                                        index: index,
                                        numCount: false,
                                        model: alcohol);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
              _loading == true
                  ? Center(child: CircularProgressIndicator())
                  : _loading == false && mix?.data?.data == []
                      ? Center(
                          child: Text(
                            Strings.nodataFound,
                            style: TextStyle(
                                color: AppColors.descriptionfirst,
                                fontFamily: Fonts.dmSansBold,
                                fontSize: size.width * 0.045),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(8.0),
                          color: AppColors.homeBackgroundLite,
                          child: Column(
                            children: [
                              SizedBox(
                                  width: SizeConfig.screenWidth * 0.95,
                                  child: richText(
                                      "Select at most ", "Two", " from Mixes")),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: mix?.data?.data?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return alcoholGradientFunction(
                                        index: index,
                                        model: mix,
                                        numCount: true);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
              _loading == true
                  ? Center(child: CircularProgressIndicator())
                  : _loading == false && extras?.data?.data == []
                      ? Center(
                          child: Text(
                            Strings.nodataFound,
                            style: TextStyle(
                                color: AppColors.descriptionfirst,
                                fontFamily: Fonts.dmSansBold,
                                fontSize: size.width * 0.045),
                          ),
                        )
                      : Container(
                          color: AppColors.homeBackgroundLite,
                          child: Column(
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.95,
                                child: richText(
                                    "Select at most ", "One", " from Mixes"),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: extras?.data?.data?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return alcoholGradientFunction(
                                        index: index,
                                        model: extras,
                                        numCount: true);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
            ]),
          ),
        ));
  }
}
