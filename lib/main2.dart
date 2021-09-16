// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:funfy/apis/userdataM.dart';
// import 'package:funfy/ui/screens/fiestasMoreOrderDetails.dart';
// import 'package:funfy/ui/screens/home.dart';
// import 'package:funfy/ui/screens/splash.dart';
// import 'package:funfy/utils/Constants.dart';
// import 'package:funfy/utils/langauge_constant.dart';
// import 'package:funfy/utils/localizing.dart';
// import 'package:funfy/utils/strings.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import 'dart:async';

// final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// DateTime date = DateTime(2007, 05, 2);
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   // print(message.data);
// }

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   Constants.prefs = await SharedPreferences.getInstance();

//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   static void setLocale(BuildContext context, Locale newLocale) {
//     _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
//     state!.setLocale(newLocale);
//   }

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// var initializationSettings;

// class _MyAppState extends State<MyApp> {
//   Locale? _locale;
//   setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     getLocale().then((locale) {
//       setState(() {
//         this._locale = locale;
//       });
//     });
//     super.didChangeDependencies();
//   }

//   getToken() async {
//     var token = await firebaseMessaging.getToken();

//     print('here is F token $token');

//     UserData.deviceToken = "$token";

//     Constants.prefs?.setString("fToken", "$token");
//   }

//   @override
//   void initState() {
//     getToken();

//     getMe();
//     initializePlatformSpecifics();
//     getMeLocal();

//     var initialzationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//         InitializationSettings(android: initialzationSettingsAndroid);

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // print('A new onMessageOpenedApp event was published!');
//       RemoteNotification? notification = message.notification;

//       AndroidNotification? android = message.notification?.android;

//       print("Here is on tap notification-----------");
//     });

//     /// on tap code

//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       // onSelectNotificationL(payload!);
//       var payloadJson = json.decode(payload!);

//       print(payloadJson);

//       var data = json.decode(payloadJson["data"]);

//       if (data["data_type"] == "Booking") {
//         print("under-------------");

//         try {
//           // Navigator.pushNamed(context, '/home');
//           // Navigator.of(context).push(MaterialPageRoute(
//           //     builder: (context) => FiestasMoreOrderDetail(
//           //           fiestaBookingId: 36,
//           //           nav: 1,
//           //         )));

//           Get.to(FiestasMoreOrderDetail(
//             fiestaBookingId: 36,
//             nav: 1,
//           ));
//         } catch (e) {
//           print("here is error $e--------------");
//         }
//       }
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       Map<String, dynamic> notification = message.data;
//       if (notification.isNotEmpty) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification['title'],
//           notification['body'],
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channel.description,
//               color: Colors.blue,
//               playSound: true,
//               icon: '@mipmap/ic_launcher',
//             ),
//           ),
//           payload: json.encode(message.data),
//         );
//         if (message.data["data_type"] != null &&
//             message.data["data_type"] == "Message") {}

//         print("==============> yashu gautam ${message.data}");
//       }
//     });
//     // TODO: implement initState

//     super.initState();
//   }

//   getMe() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//   }

//   initializePlatformSpecifics() {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification: (id, title, body, payload) async {
//         // your call back to the UI
//       },
//     );
//     initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   }

//   getMeLocal() async {
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (v) async {
//       // print("Here is on select notification --- $v");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // runApp(GetMaterialApp(home: Home()));
//     return GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: "funfy",
//         theme: ThemeData(
//           primarySwatch: Colors.red,
//         ),
//         locale: _locale,
//         localizationsDelegates: const [
//           MyLocalization.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         supportedLocales: [
//           const Locale('en', 'US'), // English, no country code
//           const Locale('es', 'ES'), // Arabic, no country code
//         ],
//         localeResolutionCallback: (locale, supportedLocales) {
//           for (var supportedLocale in supportedLocales) {
//             if (supportedLocale.languageCode == locale!.languageCode &&
//                 supportedLocale.countryCode == locale.countryCode) {
//               return supportedLocale;
//             }
//           }
//           print("hello + ${supportedLocales.first}");
//           return supportedLocales.first;
//         },
//         // initialRoute: '/',
//         // routes: <String, WidgetBuilder>{
//         //   '/': (BuildContext context) => new Splash(),
//         //   '/home': (BuildContext context) => new Home(),
//         // },
//         darkTheme: ThemeData.dark(), //
//         // home: TranslateTest());
//         home: Splash());
//     // home: PickerDemo());
//     // home: FilterUiT());
//     // home: Home(
//     //   pageIndexNum: 0,
//     // ));
//   }
// }
