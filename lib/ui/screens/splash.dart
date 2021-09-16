import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funfy/apis/configuration.dart';
import 'package:funfy/apis/introApi.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/screens/intro.dart';
import 'package:funfy/ui/screens/languageScreen.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';

import '../../main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  dynamic value;

  // void changeLanguage() async{
  //
  //   print("check value $value" );
  //   Locale locale = await setLocale(value);
  //   MyApp.setLocale(context, locale);
  // }
  @override
  void initState() {
    super.initState();
    value = Constants.prefs?.getString(Strings.radioValue);
    // changeLanguage();

    next();
  }

  next() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      var introdata = await getIntrodata();

      // term();
      // policy();
      if (value == null) {
        navigatorPushFun(context, TranslationPage(fromSplash: true));
      } else {
        if (introdata.length != 0 && introdata != []) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  Constants.prefs?.getString("token") != null &&
                          Constants.prefs?.getString("token") != ""
                      ? Home(pageIndexNum: 0)
                      // ? Testing()
                      // : Intro()
                      : Signin()));
        } else {
          print("no intro data");

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  Constants.prefs?.getString("token") != null &&
                          Constants.prefs?.getString("token") != ""
                      ? Home(pageIndexNum: 0)
                      // ? Testing()
                      : Signin()));
        }
      }
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
