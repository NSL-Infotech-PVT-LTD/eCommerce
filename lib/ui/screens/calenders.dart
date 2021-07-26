import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/dateButton.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:intl/intl.dart';

class Hcalender extends StatefulWidget {
  const Hcalender({Key? key}) : super(key: key);

  @override
  _HcalenderState createState() => _HcalenderState();
}

class _HcalenderState extends State<Hcalender> {
  DateTime nowdate = DateTime.now();
  var _scrollController = ScrollController();

  DateTime? selectedDate;
  Map<String, dynamic> itemSelected = {};

  var dates = [
    {
      "date": 2,
      "month": "Jun",
      "year": "2021",
      "active": false,
      "dateTime": DateTime
    }
  ];

  // Getting the total number of days of the month

  daysInMonth(DateTime date) {
    dates = [];
    print(date.toString());
    print(DateFormat('EE, d MMM, yyyy').format(date));

    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);

    int daysnum = firstDayNextMonth.difference(firstDayThisMonth).inDays;

    for (var i = 1; i <= daysnum; i++) {
      DateTime nowdate = DateTime(date.year, date.month, i);

      setState(() {
        dates.add({
          "fulldate": nowdate,
          "date": i,
          "day": DateFormat('EE').format(nowdate),
          "month": DateFormat('MMM').format(nowdate),
          "year": date.year,
          "active": false
        });
      });
    }
    print("noeDAte==>$nowdate");
    itemSelected.clear();
    itemSelected = {
      "fulldate": nowdate,
      "date": nowdate.day,
      "month": "${nowdate.month}",
      "year": "${nowdate.year}",
      "active": true
    };
    print("selectDate==>$itemSelected");

    for (var i = 0; i < daysnum; i++) {
      if (dates[i]['date'] == itemSelected['date']) {
        print("fhskhfkh-===" + dates[i].toString());
        dates[i]['active'] = true;
        _scrollController.animateTo(
            i * MediaQuery.of(context).size.width * 0.13,
            duration: new Duration(seconds: 2),
            curve: Curves.ease);
        break;
      }
    }

    //
  }

  checkDateSelected(date) {
    print(date);

    for (var i in dates) {
      // print(i["fulldate"]);
      if (i["active"] == true) {
        setState(() {
          i["active"] = false;
          return;
        });
      }
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: nowdate,
      firstDate: DateTime(1950, 12),
      currentDate: selectedDate,
      lastDate: DateTime(2022, 12),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        print(picked.toString());
        nowdate = picked;
        daysInMonth(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          daysInMonth(nowdate);
        },
        child: Icon(Icons.alarm),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.04),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated(context, "pickfiestasday")}",
                  // Strings.pickfiestasday,
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontFamily: Fonts.dmSansMedium,
                      color: AppColors.white),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Container(
                    // color: Colors.blue,
                    width: size.width,
                    height: size.height * 0.07,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 12,
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: dates.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(dates[index]["fulldate"]);
                                    checkDateSelected(dates[index]["fulldate"]);
                                    setState(() {
                                      dates[index]["active"] = true;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.01),
                                    child: dateButton(
                                        context: context,
                                        text: dates[index]["date"].toString(),
                                        textColor:
                                            dates[index]["active"] == true
                                                ? AppColors.homeBackground
                                                : AppColors.white,
                                        month: dates[index]["month"].toString(),
                                        borderColor: AppColors.white,
                                        borderwidth: size.width * 0.003,
                                        backgroundColor:
                                            dates[index]["active"] == true
                                                ? AppColors.tagBorder
                                                : AppColors.homeBackground),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              selectDate(context);
                            },
                            child: roundedBox(
                                backgroundColor: AppColors.siginbackgrond,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                    size: size.width * 0.07,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
