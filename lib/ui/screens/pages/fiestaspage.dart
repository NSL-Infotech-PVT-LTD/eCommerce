import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/dateButton.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/ui/widgets/tagsButton.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/strings.dart';

class FiestasPage extends StatefulWidget {
  const FiestasPage({Key? key}) : super(key: key);

  @override
  _FiestasPageState createState() => _FiestasPageState();
}

class _FiestasPageState extends State<FiestasPage> {
  bool fiestasButton = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors.homeBackground,
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // top bar
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.023,
                    horizontal: size.width * 0.045),
                width: size.width,
                height: size.height * 0.155,
                color: Colors.green,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.hello,
                          style: TextStyle(
                              fontSize: size.width * 0.038,
                              fontFamily: Fonts.dmSansRegular,
                              color: AppColors.white),
                        ),
                        Text(
                          // Strings.garyadams,
                          UserData.facebookUserdata["name"] ??
                              Strings.garyadams,
                          style: TextStyle(
                              fontSize: size.width * 0.048,
                              fontFamily: Fonts.dmSansBold,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        // location choose
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.fmd_good,
                              size: size.width * 0.04,
                              color: AppColors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              Strings.madridspain,
                              style: TextStyle(
                                  fontSize: size.width * 0.034,
                                  fontFamily: Fonts.dmSansMedium,
                                  color: AppColors.white),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Icon(
                              Icons.expand_more,
                              size: size.width * 0.042,
                              color: AppColors.white,
                            ),
                          ],
                        )
                      ],
                    ),

                    // notification icon
                    Container(
                      margin: EdgeInsets.only(right: size.width * 0.03),
                      child: Icon(
                        Icons.notifications,
                        size: size.width * 0.08,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              // body

              // fiestas && pre-fiestas

              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
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

              SizedBox(
                height: size.width * 0.015,
              ),

              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
                width: size.width,
                height: size.height * 0.055,
                child:
                    // tags
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return tagbutton(
                                    context: context,
                                    text: Strings.club,
                                    borderColor: AppColors.white,
                                    borderwidth: size.width * 0.001);
                              })),

                      SizedBox(
                        width: size.width * 0.02,
                      ),

                      // right button
                      Container(
                        margin: EdgeInsets.only(right: size.width * 0.01),
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.grid_view,
                          color: Colors.white,
                        ),
                      )
                    ]),
              ),

              SizedBox(
                height: size.height * 0.015,
              ),

              // pick fiesta's day

              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.pickfiestasday,
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontFamily: Fonts.dmSansMedium,
                          color: AppColors.white),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Container(
                        // color: Colors.blue,
                        width: size.width,
                        height: size.height * 0.07,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 12,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.01),
                                      child: dateButton(
                                          context: context,
                                          text: "22",
                                          textColor: AppColors.white,
                                          month: "JUN",
                                          borderColor: AppColors.white,
                                          borderwidth: size.width * 0.003,
                                          backgroundColor:
                                              AppColors.homeBackground),
                                    );
                                  }),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {},
                                child: roundedBox(
                                    backgroundColor: AppColors.siginbackgrond,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.date_range,
                                        color: Colors.white,
                                        size: size.width * 0.07,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),

              // POSTS

              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.04),
                    // height: size.height,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.nearbyfiestas,
                              style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  fontFamily: Fonts.dmSansBold,
                                  color: AppColors.white),
                            ),
                            Text(
                              Strings.seeall,
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontFamily: Fonts.dmSansBold,
                                  color: AppColors.siginbackgrond),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return fiestasItem(context: context);
                              }),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
