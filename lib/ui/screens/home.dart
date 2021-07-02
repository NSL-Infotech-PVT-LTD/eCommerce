import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/ui/screens/pages/cartpage.dart';
import 'package:funfy/ui/screens/pages/fiestaspage.dart';
import 'package:funfy/ui/widgets/dateButton.dart';
import 'package:funfy/ui/widgets/rating.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/ui/widgets/tagsButton.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool fiestasButton = true;

  int pageIndex = 0;
  PageController? pageController;

  List<Widget> tabpages = [FiestasPage(), Cartpage(), Cartpage(), Cartpage()];

  void onpageChange(int page) {
    setState(() {
      this.pageIndex = page;
    });
  }

  void ontabTap(int page) {
    onpageChange(page);
    this.pageController?.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: tabpages,
        onPageChanged: onpageChange,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.bottomnavBackground,
        currentIndex: pageIndex,
        onTap: (i) {
          ontabTap(i);
        },
        items: [
          BottomNavigationBarItem(
            activeIcon:
                buttomIconImage(size: size, svgimage: Images.fiestasIconActSvg),
            icon: buttomIconImage(
                size: size, svgimage: Images.fiestasIconUnActSvg),
            label: Strings.bottomNavFiestas,
          ),
          BottomNavigationBarItem(
            activeIcon:
                buttomIconImage(size: size, svgimage: Images.cartIconActSvg),
            icon:
                buttomIconImage(size: size, svgimage: Images.cartIconUnActSvg),
            label: Strings.bottomNavCart,
          ),
          BottomNavigationBarItem(
            activeIcon:
                buttomIconImagePng(size: size, image: Images.bokkingIconActPng),
            icon: buttomIconImagePng(
                size: size, image: Images.bookingIconUnActPng),
            label: Strings.bottomNavBookings,
          ),
          BottomNavigationBarItem(
            activeIcon:
                buttomIconImage(size: size, svgimage: Images.profileIconActSvg),
            icon: buttomIconImage(size: size, svgimage: Images.profileUnActSvg),
            label: Strings.bottomNavMyprofile,
          ),
        ],
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