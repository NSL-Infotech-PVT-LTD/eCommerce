import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funfy/apis/configuration.dart';
import 'package:funfy/apis/introApi.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/screens/intro.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/imagesIcons.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    next();
  }

  next() async {
    var net = await Internetcheck.check();
    print("net = $net");

    if (net != false) {
      var introdata = await getIntrodata();
      term();
      policy();

      if (introdata != []) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Constants.prefs?.getString("token") != null &&
                    Constants.prefs?.getString("token") != ""
                ? Home()
                : Intro()));
      } else {
        print("no intro data");
      }
    } else {
      Internetcheck.showdialog(context: context);
    }
  }

  term() async {
    await Configurations.termsofservice();
  }

  policy() async {
    await Configurations.privacypolicy();
  }

  //

  // Create AlertDialog

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.splashBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
              child: Container(
            width: size.width * 0.55,
            child: Image.asset(
              Images.appLogo,
            ),
          )),
        ]));
  }
}
