import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // box
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 8,
              ),
              child: SwipeButton(
                thumb: SvgPicture.asset(
                  Images.swipeButtonSvg,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
                activeTrackColor: AppColors.siginbackgrond,
                height: 60,
                child: Text("Swipe to Pay",
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: Fonts.dmSansBold,
                        fontSize: size.width * 0.05)),
                onSwipeEnd: () {
                  print("End to swipe");
                },
              ),
            ),

            ///
          ],
        ),
      ),
    );
  }
}
