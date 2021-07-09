import 'package:flutter/material.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/ui/screens/profileEdit.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';
import 'package:funfy/utils/Constants.dart';

class Profilepage extends StatefulWidget {
  Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
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
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansBold,
                                    color: AppColors.white,
                                    fontSize: size.width * 0.058),
                              ),
                              Text(
                                "${Constants.prefs?.getString('email')}",
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
                                builder: (context) => EditProfile()));
                      },
                      child: Container(
                          height: size.height * 0.03,
                          child: Image.asset(Images.editpen)),
                    ))
                  ],
                  // edit
                ),

                SizedBox(height: size.height * 0.05),

                centerlistItem(
                    context: context,
                    title: Strings.orders,
                    leftIconImage: Images.orderIIconpng),

                centerlistItem(
                    context: context,
                    title: Strings.deliveryAddress,
                    leftIconImage: Images.locationspng),

                centerlistItem(
                    context: context,
                    title: Strings.paymentMethods,
                    leftIconImage: Images.paymentIconpng),

                centerlistItem(
                    context: context,
                    title: Strings.notification,
                    leftIconImage: Images.notificationspng),

                centerlistItem(
                    context: context,
                    title: Strings.help,
                    leftIconImage: Images.helppng),

                centerlistItem(
                    context: context,
                    title: Strings.about,
                    leftIconImage: Images.aboutpng),

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
                                Strings.logout,
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
    {context, String? leftIconImage, String? title, String? rightIconImage}) {
  var size = MediaQuery.of(context).size;

  return Container(
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
  );
}
