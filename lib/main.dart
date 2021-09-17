import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/screens/splash.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/localizing.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:async';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('IN THE ON Background ===============>>>>>>>>>>> ${message.data}');

  Get.to(Home(
    pageIndexNum: 2,
  ));
}

String fcmToken = " ";
// Future<String> getToken() async {
//   return
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken().then((value) {
    fcmToken = value!;
  });
  print("====================> $fcmToken");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

var initializationSettings;

class _MyAppState extends State<MyApp> {
  var token;
  var initializationSettings;

  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  initializePlatformSpecifics() {
    // var initializationSettingsAndroid =
    //     AndroidInitializationSett  ings('app_notf_icon');
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  getToken() async {
    // var token = await firebaseMessaging.getToken();

    // print('here is F token $token');

    // print('here is F token ${}');

    UserData.deviceToken = "$fcmToken";

    Constants.prefs?.setString("fToken", "$fcmToken");
  }

  getMe() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print("======LOCAL NOTIFICATION======> $payload");
      print("======TOKEN======> $token");
    });
  }

  @override
  void initState() {
    getToken();
    initializePlatformSpecifics();
    getMe();
    getMeLocal();

    FirebaseMessaging.instance.requestPermission();
    print("CHECK $token");
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // print("IN THE ON MESSAGE ===============>>>>>>>>>>> ${message.data}");
        // print(
        //     "IN THE ON MESSAGE ===============>>>>>>>>>>> ${message.notification}");
        // print(
        //     "IN THE ON MESSAGE ===============>>>>>>>>>>> ${message.data["screen"]}");
        // print("noti ${message.notification}");

        // print("message $message");
        // var jsonData = json.decode(message.data['data']);
        // var mid = jsonData['target_id'];
        // print("message ${message.notification?.android}");

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        print("message data ${message.data.entries}");

        print("notification - $notification");
        print("android - $android");
        if (notification != null && android != null)

        // if (message.data.length != 0)
        {
          flutterLocalNotificationsPlugin.show(
              // mid,
              // message.data['title'],
              // message.data['body'],

              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  // color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
              payload: json.encode(message.data));

          print(
              "======IN onMessage ========> YYYYYYYYYYYYYYYY ${message.data}");
        } else if (message.data.isNotEmpty) {
          flutterLocalNotificationsPlugin.show(
              // mid,
              // message.data['title'],
              // message.data['body'],

              notification.hashCode,
              message.data['title'],
              message.data['body'],
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  // color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
              payload: json.encode(message.data));
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("IN THE OPEN MESSAGE  ============>>>>>>>>>>>");

      // on background notification on tap

      print(message.data);

      // if(message.)
      Get.to(Home(
        pageIndexNum: 1,
      ));

      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => Home(
      //           pageIndexNum: 1,
      //         )));

      // on message
    });

    super.initState();
  }

  getMeLocal() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (v) async {
      print("Here is on select notification --- $v");

      var messageData = json.decode(v!);

      var messageData2 = json.decode(messageData["data"]!);

      print("model ${messageData2["target_model"]}");

      // on fourground notification on tap

      if (messageData2["target_model"] == "FiestaBooking") {
        Get.to(Home(
          pageIndexNum: 1,
        ));

        // Get.off(NextScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // runApp(GetMaterialApp(home: Home()));
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "funfy",
        theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.red,
            primaryColor: Colors.red),
        locale: _locale,
        localizationsDelegates: const [
          MyLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English, no country code
          const Locale('es', 'ES'), // Arabic, no country code
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          print("hello + ${supportedLocales.first}");
          return supportedLocales.first;
        },
        darkTheme: ThemeData.dark(), //

        home: Splash());
  }
}
