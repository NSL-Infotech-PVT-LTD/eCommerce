import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  String imageb = "assets/images/introimage.jpg";
  //Lorem Ipsum is simply dummy text of the printing and.

  List<Map<String, String>> introlist = [
    {
      "img": Images.intro1,
      "titletxt": "Lorem Ipsum is simply dummy text of the printing and.",
      "description":
          "when an unknown printer took a galley of type and scrambled it"
    },
    {
      "img": Images.intro2,
      "titletxt": "It has survived not only five centuries.",
      "description":
          "the release of Letraset sheets containing Lorem Ipsum passages."
    },
  ];

  List<String> images = [Images.intro1, Images.intro2];

  int pageCount = 3;

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildFullscrenImage(imagename) {
    return Image.asset(
      imagename,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    List<PageViewModel> pages = [];

    for (var introdata in introlist) {
      pages.add(PageViewModel(
          title: "1",
          // body: "with some customizations possibilities",
          image: _buildFullscrenImage(introdata["img"]),
          bodyWidget: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  introdata["titletxt"].toString(),
                  // introdata["tittletxt"],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(introdata["description"].toString(),
                    // introdata["description"],
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: size.width * 0.05,
                    )),
              ],
            ),
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            bodyTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            pageColor: Colors.transparent,
            imageFlex: 3,
          )));
    }

    return IntroductionScreen(
      key: introKey,
      color: Colors.green,

      pages: pages,

      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      showNextButton: true,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),

      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Colors.green,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
