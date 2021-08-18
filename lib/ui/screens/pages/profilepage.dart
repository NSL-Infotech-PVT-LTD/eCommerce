import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/ui/screens/aboutScreen.dart';
import 'package:funfy/ui/screens/favourite.dart';
import 'package:funfy/ui/screens/helpScreen.dart';
import 'package:funfy/ui/screens/languageScreen.dart';
import 'package:funfy/ui/screens/notifications.dart';
import 'package:funfy/ui/screens/profileEdit.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:hexcolor/hexcolor.dart';

class Profilepage extends StatefulWidget {
  Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  bool toggleBool = false;
  bool notiLoading = false;
  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  void showNotificationBottomSheet() {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            key: _keyScaffold,
            builder: (context, setstate) {
              return Container(
                margin: EdgeInsets.only(top: size.height * 0.008),
                // color: Colors.white,
                height: size.height * 0.5,
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.008,
                    ),

                    roundedBoxR(
                        height: size.height * 0.012,
                        width: size.width * 0.4,
                        radius: size.width * 0.2,
                        backgroundColor: Colors.grey[100]),

                    SizedBox(
                      height: size.height * 0.04,
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.15,
                      // width: size.width * 0.1,
                      child: SvgPicture.asset(Images.notificationBellRed),
                    ),

                    SizedBox(
                      height: size.height * 0.05,
                    ),

                    // toggle

                    // StatefulBuilder()

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notification Alerts",
                                style: TextStyle(
                                  color: HexColor("#4e4e4e"),
                                  fontSize: size.width * 0.065,
                                  fontFamily: Fonts.dmSansMedium,
                                ),
                              ),
                              Text(
                                "${toggleBool ? getTranslated(context, "switchOn") : getTranslated(context, "switchoff")}",
                                style: TextStyle(
                                  color: HexColor("#aeaeae"),
                                  fontSize: size.width * 0.045,
                                  fontFamily: Fonts.dmSansMedium,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          notiLoading
                              ? Container(
                            margin: EdgeInsets.only(top: size.height * 0.02),
                                child: Row(
                                    children: [
                                      Container(
                                          // height: size.height * 0.033,
                                          // width: size.width * 0.06,
                                        height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator()),
                                      SizedBox(
                                        width: size.width * 0.04,
                                      )
                                    ],
                                  ),
                              )
                              : Switch(
                                  onChanged: (v) async {
                                    setstate(() {
                                      notiLoading = true;
                                    });

                                    await notificationOffApi(
                                            notificationNum: v ? 1 : 0)
                                        .then((value) {
                                      print("res value $value");
                                      setstate(() {
                                        notiLoading = false;
                                        toggleBool = value!;
                                      });
                                    });

                                    setstate(() {
                                      notiLoading = false;
                                    });
                                  },
                                  value: toggleBool,
                                  activeColor: AppColors.white,
                                  activeTrackColor: AppColors.siginbackgrond,
                                  inactiveThumbColor: AppColors.white,
                                  inactiveTrackColor: Colors.grey[300],
                                )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.06,
                    ),

                    InkWell(
                      onTap: () {
                        navigatePopFun(context);
                        navigatorPushFun(context, Notifications());
                      },
                      child: Text(
                        "${getTranslated(context, "SeeAllNotifications")}",
                        style: TextStyle(
                          color: HexColor("#2f2c2c"),
                          fontSize: size.width * 0.05,
                          fontFamily: Fonts.dmSansBold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    toggleBool = Constants.prefs!.getBool("notif") == null
        ? false
        : Constants.prefs!.getBool("notif")!;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.profileBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.035),
            child: Column(
              children: [
                // top content
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    CircleAvatar(
                      radius: size.width * 0.085,
                      backgroundImage: NetworkImage(
                          "${Constants.prefs?.getString('profileImage')}"),
                      backgroundColor: Colors.white,
                    ),

                    SizedBox(
                      width: size.width * 0.02,
                    ),

                    // name email
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Constants.prefs?.getString('name')}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansBold,
                                    color: AppColors.white,
                                    fontSize: size.width * 0.058),
                              ),
                              Text(
                                "${Constants.prefs?.getString('email')}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansRegular,
                                    color: AppColors.profileEmail,
                                    fontSize: size.width * 0.046),
                              ),
                            ]),
                      ),
                    ),

                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()))
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Container(
                          height: size.height * 0.03,
                          child: Image.asset(Images.editpen)),
                    ))
                  ],
                  // edit
                ),

                SizedBox(height: size.height * 0.05),

                // centerlistItem(
                //     context: context,
                //     title: "${getTranslated(context, "orders")}",
                //     //Strings.orders,
                //     leftIconImage: Images.orderIIconpng,
                //     onTapfunc: () {}),

                centerlistItem(
                    context: context,
                    title: "${getTranslated(context, "deliveryAddress")}",
                    //  Strings.deliveryAddress,
                    leftIconImage: Images.locationspng,
                    onTapfunc: () {}),

                centerlistItem(
                    context: context,
                    title: "${getTranslated(context, "favourite")}",
                    //  Strings.deliveryAddress,
                    leftIconImage: "assets/pngicons/hearticonbig.png",
                    onTapfunc: () {
                      navigatorPushFun(context, Favourite());
                    }),

                centerlistItem(
                    context: context,
                    title: "${getTranslated(context, "language")}",
                    //  Strings.deliveryAddress,
                    leftIconImage: Images.locationspng,
                    onTapfunc: () {
                      navigatorPushFun(
                          context, TranslationPage(fromSplash: false));
                    }),

                centerlistItem(
                    context: context,
                    title: "${getTranslated(context, "paymentMethods")}",
                    //    Strings.paymentMethods,
                    leftIconImage: Images.paymentIconpng,
                    onTapfunc: () {}),

                centerlistItem(
                    context: context,
                    title: "${getTranslated(context, "notification")}",
                    // Strings.notification,
                    leftIconImage: Images.notificationspng,
                    onTapfunc: () {
                      showNotificationBottomSheet();
                    }),

                centerlistItem(
                    context: context,
                    title: "${getTranslated(context, "help")}",
                    //  Strings.help,
                    leftIconImage: Images.helppng,
                    onTapfunc: () {
                      navigatorPushFun(context, HelpScreen());
                    }),

                centerlistItem(
                    context: context,
                    title: "${getTranslated(context, "about")}",
                    //Strings.about,
                    leftIconImage: Images.aboutpng,
                    onTapfunc: () {
                      navigatorPushFun(context, AboutScreen());
                    }),

                SizedBox(
                  height: size.height * 0.04,
                ),

                // logout

                GestureDetector(
                  onTap: () {
                    logout(context);
                  },
                  child: roundedBox(
                      height: size.height * 0.065,
                      width: size.width * 0.6,
                      backgroundColor: AppColors.logoutBackground,
                      child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(width: size.width * 0.045),
                              Container(
                                  // color: Colors.green,
                                  height: size.height * 0.031,
                                  width: size.width * 0.06,
                                  child: Image.asset(Images.logout)),
                              SizedBox(
                                width: size.width * 0.12,
                              ),
                              Text(
                                "${getTranslated(context, "logout")}",
                                //   Strings.logout,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: Fonts.dmSansBold,
                                    fontSize: size.width * 0.045),
                              ),
                            ],
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget centerlistItem(
    {context,
    String? leftIconImage,
    String? title,
    String? rightIconImage,
    onTapfunc}) {
  var size = MediaQuery.of(context).size;

  return InkWell(
    onTap: () {
      onTapfunc();
    },
    child: Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                      alignment: Alignment.center,
                      width: size.width * 0.045,
                      child: Image.asset("$leftIconImage")),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    title.toString(),
                    style: TextStyle(
                        fontFamily: Fonts.dmSansRegular,
                        color: AppColors.white,
                        fontSize: size.width * 0.04),
                  ),
                ]),
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.06,
                  child: Icon(
                    Icons.chevron_right,
                    color: AppColors.white,
                    size: size.width * 0.07,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Divider(
            color: Colors.white,
            thickness: size.height * 0.0003,
          )
        ],
      ),
    ),
  );
}
