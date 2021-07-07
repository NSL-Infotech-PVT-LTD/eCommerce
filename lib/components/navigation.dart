import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

pushAndRemoveUntilFun(context, Widget goTo) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => goTo),
          (route) => false);
}

navigatorPushFun(context, goTo) {
  Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => goTo,));
}

settingNavigatorPushFun(context,  goTo,setting) {
  Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => goTo,settings: setting));
}
animateNavigatorPushFun(context,  goTo) {
  Navigator.push(context,goTo); ///only for ScaleRoute
}
navigatorPushReplacedFun(context, Widget goTo) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => goTo));
}

navigatePopFun(context) {
  Navigator.pop(context);
}
