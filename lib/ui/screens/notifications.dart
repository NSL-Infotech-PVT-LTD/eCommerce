import 'package:flutter/material.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/main.dart';
import 'package:funfy/models/notificationListModel.dart';
import 'package:funfy/ui/screens/Your%20order%20Summery.dart';
import 'package:funfy/ui/screens/fiestasMoreOrderDetails.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationListModel? notificationListModel;
  var notificationData;
  bool _loading = false;
  int _today = -1;
  int _earlier = -1;

  DateTime dateTime = DateTime.now();

  getNotificationList() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    }
    {
      try {
        setState(() {
          setState(() {
            _loading = true;
          });
        });
        notificatiListApi().then((value) {
          setState(() {
            // for (var i = 0;
            //     i > int.parse("${value?.data?.data?.length}");
            //     i++) {
            //   DateTime dateCreated = DateTime.parse(
            //       "${notificationListModel?.data?.data?.elementAt(i).createdAt}");

            //   if (_today == -1 && dateCreated.day == dateTime.day) {
            //     _today = i;
            //   }
            //   if (_earlier == -1 && dateCreated.day != dateTime.day) {
            //     _earlier = i;
            //     print("here is er $_earlier");
            //   }
            // }

            // notificationListModel = value;
            notificationData = value['data']['data'];

            _loading = false;
          });
        });
      } catch (e) {
        print(e);

        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print(_today);
      //     print(_earlier);
      //   },
      //   child: Icon(Icons.add),
      // ),
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
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            )
          : _loading == false && notificationListModel?.data?.data?.length == 0
              ? Center(
                  child: Text(
                    "${getTranslated(context, "noNotification")}",
                    style: TextStyle(
                        color: AppColors.white, fontSize: size.width * 0.045),
                  ),
                )
              : Column(
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
                          itemCount: notificationData.length ?? 0,
                          // notificationListModel?.data?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            DateTime dateCreated = DateTime.parse(
                                "${notificationData[index]['created_at']}"
                                // "${notificationListModel?.data?.data?.elementAt(index).createdAt}"

                                );

                            if (_today != -0 && index == _today) {
                              // _today = true;
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

                            if (_earlier != -0 && index == _earlier) {
                              // _earlier = true;

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
                                imageUrl:

                                    //  notificationListModel?.data?.data
                                    //         ?.elementAt(index)
                                    //         .targetByDetail
                                    //         ?.image ??

                                    notificationData[index]['booking_detail']
                                            ['image'] ??
                                        Images.beerNetwork,
                                title:
                                    notificationData[index]['body'].toString(),
                                // "${notificationListModel?.data?.data?.elementAt(index).body}",
                                time:
                                    "${DateFormat.yMd().add_jm().format(dateCreated)}",
                                jsonData: notificationData[index],
                                active: true);
                          }),
                    ),
                  ],
                ),
    );
  }
}

Widget notificationItem(
    {context,
    String? imageUrl,
    String? title,
    String? time,
    bool? active,
    jsonData}) {
  var size = MediaQuery.of(context).size;
  return InkWell(
    onTap: () {
      print(jsonData);

      if (jsonData["booking_detail"]["data_type"] == "order") {
        navigatorPushFun(
            context,
            YourOrderSum(
                orderID: jsonData["booking_detail"]["target_id"].toString()));
      }
      if (jsonData["booking_detail"]["data_type"] == "Booking") {
        print(jsonData["booking_detail"]["target_id"]);
        navigatorPushFun(
            context,
            FiestasMoreOrderDetail(
              fiestaBookingId:
                  jsonData["booking_detail"]["target_id"].toString(),
            ));
      }
    },
    child: Container(
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
    ),
  );
}
