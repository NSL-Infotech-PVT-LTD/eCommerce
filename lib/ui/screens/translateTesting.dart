import 'package:flutter/material.dart';

class TranslateTest extends StatefulWidget {
  TranslateTest({Key? key}) : super(key: key);

  @override
  _TranslateTestState createState() => _TranslateTestState();
}

class _TranslateTestState extends State<TranslateTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("${translate(lang: "es", key: "hello")}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          translate(lang: "en", key: "hello");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Map en = {"hello": "Hello"};

Map es = {"hello": "Hola"};

translate({String lang = "en", String? key}) {
  if (lang == "en") {
    print(en["$key"]);

    return en["$key"];
  }
  if (lang == "es") {
    print(es["$key"]);
    return es["$key"];
  }
}
