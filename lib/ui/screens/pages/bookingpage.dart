import 'package:flutter/material.dart';
import 'package:funfy/utils/imagesIcons.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.loginBackground), fit: BoxFit.cover)),
      child: Center(
        child: Text("Processing in Bookings",
            style: TextStyle(
                fontSize: size.width * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    ));
  }
}
