import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
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
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
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
        controller: pageController,
        children: tabpages,
        onPageChanged: onpageChange,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        // fixedColor: AppColors.siginbackgrond,
        backgroundColor: AppColors.bottomnavBackground,
        currentIndex: pageIndex,
        onTap: (i) {
          ontabTap(i);
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: buttomIconImage(size: size, image: Images.appleIcon),
            icon: buttomIconImage(size: size, image: Images.fbIcon),
            label: Strings.bottomNavFiestas,
          ),
          BottomNavigationBarItem(
            activeIcon: buttomIconImage(size: size, image: Images.appleIcon),
            icon: buttomIconImage(size: size, image: Images.fbIcon),
            label: Strings.bottomNavCart,
          ),
          BottomNavigationBarItem(
            activeIcon: buttomIconImage(size: size, image: Images.appleIcon),
            icon: buttomIconImage(size: size, image: Images.fbIcon),
            label: Strings.bottomNavBookings,
          ),
          BottomNavigationBarItem(
            activeIcon: buttomIconImage(size: size, image: Images.appleIcon),
            icon: buttomIconImage(size: size, image: Images.fbIcon),
            label: Strings.bottomNavMyprofile,
          ),
        ],
      ),
    );
  }
}

Widget buttomIconImage({size, image}) {
  return Container(
    width: size.width * 0.08,
    child: Image.asset(image),
  );
}

Widget fiestasItem(
    {context,
    String? date,
    String? month,
    String? title,
    String? distance,
    String? star,
    String? price,
    backgroundImage}) {
  var size = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.only(top: size.width * 0.04),
    width: size.width,
    height: size.height * 0.28,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Images.intro1), fit: BoxFit.cover)),
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
                      "23",
                      style: TextStyle(
                          fontSize: size.width * 0.043,
                          fontFamily: Fonts.dmSansBold,
                          color: AppColors.white),
                    ),
                  ),
                  Text(
                    "JUN",
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
                    "Teatro Barcelo",
                    style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontFamily: Fonts.dmSansBold,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.004,
                  ),
                  Text(
                    "2.4 Miles away",
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
                    children: [
                      Text(
                        "€",
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontFamily: Fonts.dmSansBold,
                            color: AppColors.white),
                      ),
                      Text(
                        "29",
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
                  roundedBoxR(
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
                      ))
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}


//  Container(
//         color: AppColors.homeBackground,
//         width: size.width,
//         height: size.height,
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // top bar
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: size.height * 0.023,
//                     horizontal: size.width * 0.045),
//                 width: size.width,
//                 height: size.height * 0.155,
//                 color: Colors.green,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           Strings.hello,
//                           style: TextStyle(
//                               fontSize: size.width * 0.038,
//                               fontFamily: Fonts.dmSansRegular,
//                               color: AppColors.white),
//                         ),
//                         Text(
//                           // Strings.garyadams,
//                           UserData.facebookUserdata["name"] ??
//                               Strings.garyadams,
//                           style: TextStyle(
//                               fontSize: size.width * 0.048,
//                               fontFamily: Fonts.dmSansBold,
//                               color: AppColors.white),
//                         ),
//                         SizedBox(
//                           height: size.height * 0.01,
//                         ),

//                         // location choose
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Icon(
//                               Icons.fmd_good,
//                               size: size.width * 0.04,
//                               color: AppColors.white,
//                             ),
//                             SizedBox(
//                               width: size.width * 0.01,
//                             ),
//                             Text(
//                               Strings.madridspain,
//                               style: TextStyle(
//                                   fontSize: size.width * 0.034,
//                                   fontFamily: Fonts.dmSansMedium,
//                                   color: AppColors.white),
//                             ),
//                             SizedBox(
//                               width: size.width * 0.01,
//                             ),
//                             Icon(
//                               Icons.expand_more,
//                               size: size.width * 0.042,
//                               color: AppColors.white,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),

//                     // notification icon
//                     Container(
//                       margin: EdgeInsets.only(right: size.width * 0.03),
//                       child: Icon(
//                         Icons.notifications,
//                         size: size.width * 0.08,
//                         color: AppColors.white,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: size.height * 0.01,
//               ),

//               // body

//               // fiestas && pre-fiestas

//               Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: size.height * 0.01,
//                     horizontal: size.width * 0.04),
//                 // color: Colors.blue,
//                 width: size.width,
//                 height: size.height * 0.08,
//                 child: roundedBox(
//                     width: size.width * 0.8,
//                     height: size.height * 0.06,
//                     backgroundColor: AppColors.homeTopbuttonbackground,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: size.height * 0.01,
//                           horizontal: size.width * 0.022),
//                       child: Row(
//                         children: [
//                           // fiestas button

//                           Expanded(
//                             flex: 1,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   fiestasButton = true;
//                                 });
//                               },
//                               child: roundedBox(
//                                   backgroundColor: fiestasButton
//                                       ? AppColors.siginbackgrond
//                                       : AppColors.homeTopbuttonbackground,
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       Strings.fiestas,
//                                       style: TextStyle(
//                                           fontSize: size.width * 0.035,
//                                           fontFamily: Fonts.dmSansMedium,
//                                           color: AppColors.white),
//                                     ),
//                                   )),
//                             ),
//                           ),

//                           SizedBox(
//                             width: size.width * 0.01,
//                           ),

//                           Expanded(
//                             flex: 1,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   fiestasButton = false;
//                                 });
//                               },
//                               child: roundedBox(
//                                   // width: size.width * 0.44,
//                                   backgroundColor: fiestasButton
//                                       ? AppColors.homeTopbuttonbackground
//                                       : AppColors.siginbackgrond,
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       Strings.preFiestas,
//                                       style: TextStyle(
//                                           fontSize: size.width * 0.035,
//                                           fontFamily: Fonts.dmSansMedium,
//                                           color: AppColors.white),
//                                     ),
//                                   )),
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//               ),

//               SizedBox(
//                 height: size.width * 0.015,
//               ),

//               Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: size.height * 0.01,
//                     horizontal: size.width * 0.04),
//                 width: size.width,
//                 height: size.height * 0.055,
//                 child:
//                     // tags
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                       Expanded(
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return tagbutton(
//                                     context: context,
//                                     text: Strings.club,
//                                     borderColor: AppColors.white,
//                                     borderwidth: size.width * 0.001);
//                               })),

//                       SizedBox(
//                         width: size.width * 0.02,
//                       ),

//                       // right button
//                       Container(
//                         margin: EdgeInsets.only(right: size.width * 0.01),
//                         alignment: Alignment.centerRight,
//                         child: Icon(
//                           Icons.grid_view,
//                           color: Colors.white,
//                         ),
//                       )
//                     ]),
//               ),

//               SizedBox(
//                 height: size.height * 0.015,
//               ),

//               // pick fiesta's day

//               Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: size.height * 0.01,
//                     horizontal: size.width * 0.04),
//                 width: size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       Strings.pickfiestasday,
//                       style: TextStyle(
//                           fontSize: size.width * 0.04,
//                           fontFamily: Fonts.dmSansMedium,
//                           color: AppColors.white),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.015,
//                     ),
//                     Container(
//                         // color: Colors.blue,
//                         width: size.width,
//                         height: size.height * 0.07,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 12,
//                               child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemBuilder: (context, index) {
//                                     return Container(
//                                       margin: EdgeInsets.only(
//                                           left: size.width * 0.01),
//                                       child: dateButton(
//                                           context: context,
//                                           text: "22",
//                                           textColor: AppColors.white,
//                                           month: "JUN",
//                                           borderColor: AppColors.white,
//                                           borderwidth: size.width * 0.003,
//                                           backgroundColor:
//                                               AppColors.homeBackground),
//                                     );
//                                   }),
//                             ),
//                             SizedBox(
//                               width: size.width * 0.01,
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: GestureDetector(
//                                 onTap: () {},
//                                 child: roundedBox(
//                                     backgroundColor: AppColors.siginbackgrond,
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Icon(
//                                         Icons.date_range,
//                                         color: Colors.white,
//                                         size: size.width * 0.07,
//                                       ),
//                                     )),
//                               ),
//                             )
//                           ],
//                         ))
//                   ],
//                 ),
//               ),

//               SizedBox(
//                 height: size.height * 0.04,
//               ),

//               // POSTS

//               Expanded(
//                 child: Container(
//                     padding: EdgeInsets.symmetric(
//                         vertical: size.height * 0.01,
//                         horizontal: size.width * 0.04),
//                     // height: size.height,
//                     width: size.width,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               Strings.nearbyfiestas,
//                               style: TextStyle(
//                                   fontSize: size.width * 0.045,
//                                   fontFamily: Fonts.dmSansBold,
//                                   color: AppColors.white),
//                             ),
//                             Text(
//                               Strings.seeall,
//                               style: TextStyle(
//                                   fontSize: size.width * 0.04,
//                                   fontFamily: Fonts.dmSansBold,
//                                   color: AppColors.siginbackgrond),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: size.height * 0.015,
//                         ),
//                         Expanded(
//                           child: ListView.builder(
//                               itemCount: 10,
//                               itemBuilder: (context, index) {
//                                 return fiestasItem(context: context);
//                               }),
//                         ),
//                       ],
//                     )),
//               )
//             ],
//           ),
//         ),
//       ),