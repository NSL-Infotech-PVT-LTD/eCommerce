import 'package:flutter/material.dart';
import 'package:funfy/ui/screens/notifications.dart';
import 'package:funfy/ui/screens/splash.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

DateTime date = DateTime(2007, 05, 2);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "funfy",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      darkTheme: ThemeData.dark(), //
      home: Splash(),
    );
  }
}
