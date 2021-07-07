import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import '../../../utils/strings.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({Key? key}) : super(key: key);
  @override
  _CartpageState createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 18.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        // navigatorPushFun(context,NotificationScreen());
                      },
                      child: SvgPicture.asset(
                          Strings.assetsSvgIcons + 'place_holder.svg'))),
            ),
          ],
          centerTitle: true,
          title: Container(
            width: SizeConfig.screenWidth * 0.70,
            child: Column(
              children: [
                Row(
                  children: [
                    circleImageSha(), // Image.asset(ImagePath+"avatarSample.png"),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.06,
                    ),
                    InkWell(
                      onTap: () async {
                        //   await Navigator.push(
                        //       context,
                        //       CupertinoPageRoute(
                        //           builder: (context) => EditProfile(),
                        //           fullscreenDialog:
                        //           true)); //animateNavigatorPushFun(context, ScaleRoute(page:HomePage()));
                        //   initState();
                        //   //  animateNavigatorPushFun(context, ScaleRoute(page:GoogleMaps()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: SizeConfig.screenWidth * 0.35,
                              child: Text(
                                "ef",
                                style: TextStyle(color: Colors.black),
                                softWrap: true,
                              )),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.01,
                          ),
                          Text(
                            "Edit profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 22.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: SizeConfig.screenHeight * 0.25,
        ),
        body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.loginBackground),
                    fit: BoxFit.cover)),
            child: Center(
              child: Text("Processing in Cart",
                  style: TextStyle(
                      fontSize: size.width * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            )));
  }
}
