import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:flutter_html/flutter_html.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.blackBackground,
        appBar: AppBar(
          backgroundColor: AppColors.blackBackground,
          centerTitle: true,
          title: Text("${getTranslated(context, "help")}"),
        ),

        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Html(data: Strings.htmlS)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
