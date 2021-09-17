import 'package:flutter/material.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/notificationListModel.dart';
import 'package:funfy/ui/screens/yourOrderSummery.dart';
import 'package:funfy/ui/screens/fiestasMoreOrderDetails.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // NotificationListModel? notificationListModel;

  List notificationDataList = [];
  Map? notificationData;
  bool _loading = false;
  int _today = -1;
  int _earlier = -1;

  DateTime dateTime = DateTime.now();

  // pagination
  ScrollController notificationScrollController = ScrollController();
  bool pageLoading = false;
  int page = 1;

  getNotificationList() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    }
    {
      try {
        setState(() {
          page = 1;
          setState(() {
            _loading = true;
          });
        });
        notificatiListApi().then((value) {
          setState(() {
            notificationDataList = value['data']['data'];
            notificationData = value;

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

  //pagination
  notificationPagination() async {
    var net = await Internetcheck.check();

    print("notification data ${notificationData!["data"]["total"]}  $page");

    if (net == false) {
      Internetcheck.showdialog(context: context);
    }
    {
      if (pageLoading) {
        return;
      }

      if (page > int.parse('${notificationData!["data"]["last_page"]}')) {
        print('No More Products');

        return;
      }

      try {
        setState(() {
          pageLoading = true;
        });
        print("get data ........");
        page = page + 1;

        notificatiListApi(pageCount: page).then((value) {
          setState(() {
            notificationDataList.addAll(value['data']['data']);
            notificationData = value;

            pageLoading = false;
          });
        });
      } catch (e) {
        print("noti page Error $e");
        setState(() {
          pageLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    notificationScrollController.addListener(() {
      double maxScroll = notificationScrollController.position.maxScrollExtent;
      double currentScroll = notificationScrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        print("page ...............");
        notificationPagination();
      }
    });
    super.initState();
    getNotificationList();
  }

  @override
  void dispose() {
    notificationScrollController.dispose();
    super.dispose();
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
          : _loading == false && notificationDataList.length == 0
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
                    Expanded(
                      child: ListView.builder(
                          controller: notificationScrollController,
                          itemCount: notificationDataList.length,
                          itemBuilder: (context, index) {
                            DateTime dateCreated = DateTime.parse(
                                "${notificationDataList[index]['created_at']}"
                                // "${notificationListModel?.data?.data?.elementAt(index).createdAt}"

                                );

                            // if (_today != -0 && index == _today) {
                            //   // _today = true;
                            //   return Container(
                            //     margin: EdgeInsets.only(
                            //         left: size.width * 0.05,
                            //         top: size.height * 0.02,
                            //         bottom: size.height * 0.01),
                            //     child: Text(
                            //       "${getTranslated(context, "today")}",
                            //       // Strings.today,
                            //       style: TextStyle(
                            //           color: AppColors.white,
                            //           fontFamily: Fonts.dmSansMedium,
                            //           fontSize: size.width * 0.045),
                            //     ),
                            //   );
                            // }

                            return notificationItem(
                                context: context,
                                imageUrl:

                                    //  notificationListModel?.data?.data
                                    //         ?.elementAt(index)
                                    //         .targetByDetail
                                    //         ?.image ??

                                    notificationDataList[index]
                                            ['booking_detail']['image'] ??
                                        Images.beerNetwork,
                                title: notificationDataList[index]['body']
                                    .toString(),
                                // "${notificationListModel?.data?.data?.elementAt(index).body}",
                                time:
                                    "${DateFormat.yMd().add_jm().format(dateCreated)}",
                                jsonData: notificationDataList[index],
                                active: true);
                          }),
                    ),
                    pageLoading
                        ? Container(
                            height: size.height * 0.08,
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
                          )
                        : SizedBox()
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
      print(jsonData["booking_detail"]["target_id"]);

      if (jsonData["booking_detail"]["target_model"] == "PreFiestaOrder") {
        navigatorPushFun(
            context,
            YourOrderSum(
                orderID: jsonData["booking_detail"]["target_id"].toString()));
      }
      if (jsonData["booking_detail"]["target_model"] == "FiestaBooking") {
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
