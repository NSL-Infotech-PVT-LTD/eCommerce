import 'package:flutter/material.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blackBackground,
      appBar: AppBar(
        elevation: 2,
        shadowColor: AppColors.tagBorder,
        iconTheme: IconThemeData(color: AppColors.white),
        centerTitle: true,
        backgroundColor: AppColors.blackBackground,
        title: Text(
          "${getTranslated(context, "notifications")}",
          // Strings.notifications,
          style: TextStyle(
              color: AppColors.white,
              fontFamily: Fonts.dmSansMedium,
              fontSize: size.width * 0.05),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // today
          // Container(
          //   margin: EdgeInsets.only(
          //       left: size.width * 0.05,
          //       top: size.height * 0.02,
          //       bottom: size.height * 0.01),
          //   child: Text(
          //     "${getTranslated(context, "today")}",
          //     // Strings.today,
          //     style: TextStyle(
          //         color: AppColors.white,
          //         fontFamily: Fonts.dmSansMedium,
          //         fontSize: size.width * 0.045),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.05,
                          top: size.height * 0.02,
                          bottom: size.height * 0.01),
                      child: Text(
                        "${getTranslated(context, "today")}",
                        // Strings.today,
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Fonts.dmSansMedium,
                            fontSize: size.width * 0.045),
                      ),
                    );
                  }

                  if (index == 5) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.05,
                          top: size.height * 0.02,
                          bottom: size.height * 0.01),
                      child: Text(
                        "${getTranslated(context, "earlier")}",
                        // Strings.today,
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Fonts.dmSansMedium,
                            fontSize: size.width * 0.045),
                      ),
                    );
                  }
                  return notificationItem(
                      context: context,
                      imageUrl: Images.beerNetwork,
                      title: Strings.lorem,
                      time: "30 Min",
                      active: true);
                }),
          ),

          /// earlier
          // Container(
          //   margin: EdgeInsets.only(
          //       left: size.width * 0.05,
          //       top: size.height * 0.02,
          //       bottom: size.height * 0.01),
          //   child: Text(
          //     "${getTranslated(context, "earlier")}",
          //     // Strings.earlier,
          //     style: TextStyle(
          //         color: AppColors.white,
          //         fontFamily: Fonts.dmSansMedium,
          //         fontSize: size.width * 0.045),
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: 5,
          //       itemBuilder: (context, indxe) {
          //         return notificationItem(
          //             context: context,
          //             imageUrl: Images.beerNetwork,
          //             title: Strings.lorem,
          //             time: "30 Min",
          //             active: true);
          //       }),
          // )
        ],
      ),
    );
  }
}

Widget notificationItem(
    {context, String? imageUrl, String? title, String? time, bool? active}) {
  var size = MediaQuery.of(context).size;
  return Container(
    color: active == true
        ? AppColors.notificatonActive
        : AppColors.blackBackground,
    padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02, horizontal: size.width * 0.03),
    margin: EdgeInsets.only(top: size.height * 0.005),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: size.width * 0.08,
          backgroundImage: NetworkImage(
            "$imageUrl",
          ),
        ),
        SizedBox(
          width: size.width * 0.03,
        ),
        Container(
          width: size.width * 0.73,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: Fonts.dmSansBold,
                    fontSize: size.width * 0.036),
              ),
              SizedBox(
                height: size.height * 0.008,
              ),
              Text(
                "$time",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.descriptionfirst,
                    fontFamily: Fonts.dmSansMedium,
                    fontSize: size.width * 0.036),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
