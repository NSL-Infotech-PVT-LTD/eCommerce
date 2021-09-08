// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('IN THE ON Background ===============>>>>>>>>>>> ${message.data}');
// }

// //check kri
// //ok
// String fcmToken = " ";

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   fcmToken = await FirebaseMessaging.instance.getToken().toString();
//   print("====================> $fcmToken");

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   var token;
//   var initializationSettings;

//   initializePlatformSpecifics() {
//     // var initializationSettingsAndroid =
//     //     AndroidInitializationSett  ings('app_notf_icon');
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

//   getMe() async {
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       print("======LOCAL NOTIFICATION======> $payload");
//       print("======TOKEN======> $token");

//       Map myMap = jsonDecode(payload);

//       if (myMap["data_type"] == "Job" && token != null) {
//         print("$myMap");

//         Get.to(MissionRequest(id: myMap["target_id"]),
//             transition: Transition.leftToRightWithFade,
//             duration: Duration(milliseconds: 400));
//       } else if (myMap["data_type"] == "Message") {
//         Get.to(
//             ChatScreen(
//                 reciverName: "${myMap["sender_name"]}",
//                 image: "${myMap["profile_img"]}",
//                 receiverId: "${myMap["target_id"]}",
//                 channel:
//                     IOWebSocketChannel.connect("ws://23.20.179.178:8080/")),
//             transition: Transition.leftToRightWithFade,
//             duration: Duration(milliseconds: 400));
//       } else {
//         if (token != null)
//           Get.to(MissionRequest(id: myMap["target_id"]),
//               transition: Transition.leftToRightWithFade,
//               duration: Duration(milliseconds: 400));
//       }
//     });
//   }

//   @override
//   void initState() {
//     getString(sharedPref.userToken).then((value) {
//       if (value != null) {
//         token = value;
//         print("======token==============> $value");
//       } else {
//         print("ELSE =============>$token");
//       }
//     }).whenComplete(() {
//       initializePlatformSpecifics();
//       getMe();
//     });

//     FirebaseMessaging.instance.requestPermission();
//     print("CHECK $token");
//     FirebaseMessaging.onMessage.listen(
//       (RemoteMessage message) {
//         print("IN THE ON MESSAGE ===============>>>>>>>>>>>");
//         RemoteNotification notification = message.notification;
//         AndroidNotification android = message.notification?.android;
//         if (notification != null && android != null) {
//           flutterLocalNotificationsPlugin.show(
//               notification.hashCode,
//               notification.title,
//               notification.body,
//               NotificationDetails(
//                 android: AndroidNotificationDetails(
//                   channel.id,
//                   channel.name,
//                   channel.description,
//                   // color: Colors.blue,
//                   playSound: true,
//                   icon: '@mipmap/ic_launcher',
//                 ),
//               ),
//               payload: json.encode(message.data));

//           print(
//               "======IN onMessage ========> YYYYYYYYYYYYYYYY ${message.data}");
//         }
//       },
//     );

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("IN THE OPEN MESSAGE  ============>>>>>>>>>>>");

//       // on message
//     });

//     super.initState();
//   }

//   // void _showNotification() {
//   //   flutterLocalNotificationsPlugin.show(
//   //       0,
//   //       "Testing",
//   //       "How you doin ?",
//   //       NotificationDetails(
//   //           android: AndroidNotificationDetails(
//   //         channel.id,
//   //         channel.name,
//   //         channel.description,
//   //         importance: Importance.high,
//   //         color: Colors.blue,
//   //         playSound: true,
//   //         icon: '@mipmap/ic_launcher',
//   //       )));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         statusBarColor: CColors.missonNormalWhiteColor,
//         systemNavigationBarColor: CColors.missonNormalWhiteColor,
//         systemNavigationBarIconBrightness: Brightness.dark,
//         statusBarIconBrightness: Brightness.dark));
//     return GetMaterialApp(
//       title: 'Mission Tasker',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ).copyWith(
//         pageTransitionsTheme: const PageTransitionsTheme(
//           builders: <TargetPlatform, PageTransitionsBuilder>{
//             TargetPlatform.android: ZoomPageTransitionsBuilder(),
//           },
//         ),
//       ),
//       home: SplashScreen(),
//     );
//   }
// }
