import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funfy/ui/screens/intro.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() { 
    super.initState();
    // startTime();
    
  }

  // startTime() async {
  //   var duration = new Duration(seconds: 6);
  //   return new Timer(duration, route());
  // }

  // route() {
  //   Navigator.pushReplacement(context, MaterialPageRoute(
  //       builder: (context) => Intro()
  //     )
  //   ); 
  // }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
    child:  Container(
     width: size.width * 0.3,
      child: Image.asset("assets/images/logo.png",),)
    ),);
  }
}