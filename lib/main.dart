import 'package:flutter/material.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/screens/splash.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

      // theme: ThemeData.light(), // Provide light theme
      darkTheme: ThemeData.dark(), //
      // home: Splash(),
      home: Signin(),
    );
  }
}
