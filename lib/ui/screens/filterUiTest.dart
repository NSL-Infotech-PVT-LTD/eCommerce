import 'package:flutter/material.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/models/filterModel.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';

class FilterUiT extends StatefulWidget {
  FilterUiT({Key? key}) : super(key: key);

  @override
  _FilterUiTState createState() => _FilterUiTState();
}

class _FilterUiTState extends State<FilterUiT> {
  FliterListModel? filterModel;
  Map<String, int> groupvalue = {};

  Map<String, String> filterData = {};

  _handleRadioValueChange(int? value, String key) {
    setState(() {
      groupvalue["$key"] = value!;
    });
  }

  getFilterData() async {
    print("Run");
    await filterList().then((value) {
      // print(value?.toJson());

      for (var i in value!.data!.toJson().keys.toList()) {
        // print(i);

        groupvalue["$i"] = -1;
        filterData["$i"] = "";
      }

      setState(() {
        filterModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getFilterData();
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: AppColors.blackBackground,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Icon(
                        Icons.clear,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontFamily: Fonts.dmSansBold,
                        color: AppColors.white),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Expanded(
                  child: Container(
                child: ListView.builder(
                    itemCount: filterModel?.data?.toJson().length ?? 0,
                    itemBuilder: (context, index) {
                      return itemFilter(
                          context,
                          filterModel?.data?.toJson().keys.toList()[index],
                          filterModel?.data?.toJson().values.toList()[index]);
                    }),
              )),
            ],
          ),
        ),
      ),
    );
  }

  itemFilter(context, key, value) {
    // print(value);
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            "${key.toUpperCase()}",
            style: TextStyle(
                fontSize: size.width * 0.06,
                fontFamily: Fonts.dmSansBold,
                color: AppColors.siginbackgrond),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Column(
            children: [
              for (int i = 0; i < value.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${key == 'ageGroup' ? value[i] : value[i]['name']}",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontFamily: Fonts.dmSansMedium,
                          color: AppColors.white),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: AppColors.white,
                      ),
                      child: Radio<int?>(
                          value: i,
                          groupValue: groupvalue["$key"],
                          onChanged: (_v) {
                            // print(filterData);
                            // print("Here is  i ${value[i]['id']}  $key");
                            // print(filterData['$key']);

                            if (key == 'ageGroup') {
                              filterData['$key'] = value[i].toString();
                            } else {
                              filterData['$key'] = value[i]['id'].toString();
                            }

                            _handleRadioValueChange(i, key);

                            print(filterData);

                            setState(() {});
                          }),
                    ),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
