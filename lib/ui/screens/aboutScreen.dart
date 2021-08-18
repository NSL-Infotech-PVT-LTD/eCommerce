import 'package:flutter/material.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool _loading = false;
  String htmlHelpData = "";

  aboutApiCall() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      try {
        setState(() {
          _loading = true;
        });
        aboutApi().then((htmlString) {
          setState(() {
            _loading = false;
            htmlHelpData = htmlString!;

            print("here is html = $htmlHelpData");
          });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    aboutApiCall();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.blackBackground,
        appBar: AppBar(
          backgroundColor: AppColors.blackBackground,
          centerTitle: true,
          title: Text("${getTranslated(context, "about")}"),
        ),

        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.blackBackground,
                ),
              )
            : _loading == false && htmlHelpData == ""
                ? Center(
                    child: Text(
                    "${getTranslated(context, "nodataFound")}",
                    style: TextStyle(
                        color: AppColors.blackBackground,
                        fontSize: size.width * 0.043),
                  ))
                : Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Html(data: htmlHelpData)),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
