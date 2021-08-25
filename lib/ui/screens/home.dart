import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/ui/screens/pages/bookingpage.dart';
import 'package:funfy/ui/screens/pages/cartpage.dart';
import 'package:funfy/ui/screens/pages/fiestaspage.dart';
import 'package:funfy/ui/screens/pages/profilepage.dart';
import 'package:funfy/ui/screens/testingUi.dart';
import 'package:funfy/ui/widgets/dateButton.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/ui/widgets/scrollTohideWidget.dart';
import 'package:funfy/ui/widgets/tagsButton.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  final pageIndexNum;

  const Home({Key? key, this.pageIndexNum}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool fiestasButton = true;

  int pageIndex = 0;
  PageController? pageController;

  List<Widget> tabpages = [
    FiestasPage(),
    // Testing(),
    Cartpage(),
    BookingPage(),
    Profilepage()
  ];

  void onpageChange(int page) {
    setState(() {
      this.pageIndex = page;
    });
  }

  void ontabTap({int page = 0}) {
    onpageChange(page);
    this.pageController?.animateToPage(pageIndex,
        duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();

    ontabTap(page: widget.pageIndexNum);
    // token
    UserData.userToken = Constants.prefs?.getString("token");
    pageController = PageController(initialPage: pageIndex);
  }

  Future<bool> backPress() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "${getTranslated(context, "exit")}",
            //Strings.exit
          ),
          content: new Text(
            "${getTranslated(context, "doYouWantTOExit")}",
            //Strings.doYouWantTOExit
          ),
          actions: <Widget>[
            TextButton(
              child: new Text(
                "${getTranslated(context, "no")}",
                //Strings.no
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: new Text(
                "${getTranslated(context, "yes")}",
                //Strings.yes
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );

    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: backPress,
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: tabpages,
          onPageChanged: onpageChange,
        ),
        bottomNavigationBar:
            // ScrollTohideWidget(
            // controller: UserData.sControlller!,
            // child:

            BottomNavigationBar(
          unselectedItemColor: AppColors.white,
          selectedItemColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.bottomnavBackground,
          currentIndex: pageIndex,
          onTap: (i) {
            ontabTap(page: i);
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: buttomIconImage(
                  size: size, svgimage: Images.fiestasIconActSvg),
              icon: buttomIconImage(
                  size: size, svgimage: Images.fiestasIconUnActSvg),
              label: "${getTranslated(context, "home")}",
              //  Strings.bottomNavFiestas,
            ),
            BottomNavigationBarItem(
              activeIcon:
                  buttomIconImage(size: size, svgimage: Images.cartIconActSvg),
              icon: buttomIconImage(
                  size: size, svgimage: Images.cartIconUnActSvg),
              label: "${getTranslated(context, "bottomNavCart")}",
              //Strings.bottomNavCart,
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                padding: EdgeInsets.only(bottom: 2.5),
                child: buttomIconImage(
                    size: size, svgimage: Images.bookingIconActSvg),
              ),
              icon: Container(
                padding: EdgeInsets.only(bottom: 2.5),
                child: buttomIconImage(
                    size: size,
                    // image: Images.bookingIconUnActPng
                    svgimage: Images.bookingIconUnActSvg),
              ),
              label: "${getTranslated(context, "bottomNavBookings")}",
              //Strings.bottomNavBookings,
            ),
            BottomNavigationBarItem(
              activeIcon: buttomIconImage(
                  size: size, svgimage: Images.profileIconActSvg),
              icon:
                  buttomIconImage(size: size, svgimage: Images.profileUnActSvg),
              label: "${getTranslated(context, "bottomNavMyprofile")}",
              //  Strings.bottomNavMyprofile,
            ),
          ],
        ),
        // ),
      ),
    );
  }
}

Widget buttomIconImagePng({size, image}) {
  return Container(
    width: size.width * 0.08,
    child: Image.asset(image),
  );
}

Widget buttomIconImage({size, svgimage}) {
  return Container(
      width: size.width * 0.08,
      child: SvgPicture.asset(
        svgimage,
      ));
}
