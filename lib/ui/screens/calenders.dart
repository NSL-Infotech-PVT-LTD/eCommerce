// import 'package:flutter/material.dart';
// import 'package:calendar_timeline/calendar_timeline.dart';
// import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';

// class Hcalender extends StatefulWidget {
//   const Hcalender({Key? key}) : super(key: key);

//   @override
//   _HcalenderState createState() => _HcalenderState();
// }

// class _HcalenderState extends State<Hcalender> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//               child: Container(
//             // color: Colors.green,
//             // height: 60,
//             width: 500,
//             child: CalendarTimeline(
//               initialDate: DateTime(2020, 4, 20),
//               firstDate: DateTime(2019, 1, 15),
//               lastDate: DateTime(2020, 11, 20),
//               onDateSelected: (date) => print(date),
//               leftMargin: 20,
//               monthColor: Colors.yellow,
//               dayColor: Colors.teal[200],
//               activeDayColor: Colors.blue,
//               activeBackgroundDayColor: Colors.redAccent[100],
//               dotsColor: Colors.transparent,
//               selectableDayPredicate: (date) => date.day != 23,
//               locale: 'en_ISO',
//             ),
//           )),
//           Container(
//             height: 100,
//             child: AnimatedHorizontalCalendar(
//                 tableCalenderIcon: Icon(
//                   Icons.calendar_today,
//                   color: Colors.white,
//                 ),
//                 date: DateTime.now(),
//                 textColor: Colors.black45,
//                 backgroundColor: Colors.white,
//                 tableCalenderThemeData: ThemeData.light().copyWith(
//                   primaryColor: Colors.green,
//                   accentColor: Colors.red,
//                   colorScheme: ColorScheme.light(primary: Colors.green),
//                   buttonTheme:
//                       ButtonThemeData(textTheme: ButtonTextTheme.primary),
//                 ),
//                 selectedColor: Colors.redAccent,
//                 onDateSelected: (date) {
//                   print(date);
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:horizontal_calendar/horizontal_calendar.dart';

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("title"),
//       ),
//       body: HorizontalCalendar(
//         date: DateTime.now(),
//         textColor: Colors.black45,
//         backgroundColor: Colors.white,
//         selectedColor: Colors.blue,
//         onDateSelected: (date) => print(
//           date.toString(),
//         ),
//       ),
//     );
//   }
// }
