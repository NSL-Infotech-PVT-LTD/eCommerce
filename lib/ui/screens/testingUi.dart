import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  TabController? controller;
  bool fiestasButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                backgroundColor: Colors.blue,
              ),
              SliverAppBar(
                backgroundColor: Colors.brown,
                actions: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.04),
                    // color: Colors.blue,
                    width: size.width,
                    height: size.height * 0.08,
                    child: roundedBox(
                        width: size.width * 0.8,
                        height: size.height * 0.06,
                        backgroundColor: AppColors.homeTopbuttonbackground,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01,
                              horizontal: size.width * 0.022),
                          child: Row(
                            children: [
                              // fiestas button

                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      fiestasButton = true;
                                    });
                                  },
                                  child: roundedBox(
                                      backgroundColor: fiestasButton
                                          ? AppColors.siginbackgrond
                                          : AppColors.homeTopbuttonbackground,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${getTranslated(context, "fiestas")}",
                                          //    Strings.fiestas,
                                          style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontFamily: Fonts.dmSansMedium,
                                              color: AppColors.white),
                                        ),
                                      )),
                                ),
                              ),

                              SizedBox(
                                width: size.width * 0.01,
                              ),

                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      fiestasButton = false;
                                      // changeLanguage();
                                    });
                                  },
                                  child: roundedBox(
                                      // width: size.width * 0.44,
                                      backgroundColor: fiestasButton
                                          ? AppColors.homeTopbuttonbackground
                                          : AppColors.siginbackgrond,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${getTranslated(context, "preFiestas")}",
                                          //   Strings.preFiestas,
                                          style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontFamily: Fonts.dmSansMedium,
                                              color: AppColors.white),
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],

                // bottom: TabBar(
                //   tabs: [
                //     Tab(icon: Icon(Icons.call), text: "Call"),
                //     Tab(icon: Icon(Icons.message), text: "Message"),
                //   ],
                // ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.pink,
              )
            ],
          ),
        ),
      ),
    );

    //  Scaffold(
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       SliverAppBar(
    //         snap: false,
    //         pinned: false,
    //         floating: false,
    //         // flexibleSpace: FlexibleSpaceBar(
    //         //     centerTitle: true,
    //         //     title: Text("$title",
    //         //         style: TextStyle(
    //         //           color: Colors.white,
    //         //           fontSize: 16.0,
    //         //         ) //TextStyle
    //         //         ), //Text
    //         //     background: Image.network(
    //         //       "https://i.ibb.co/QpWGK5j/Geeksfor-Geeks.png",
    //         //       fit: BoxFit.cover,
    //         //     ) //Images.network
    //         //     ), //FlexibleSpaceBar
    //         expandedHeight: 150,
    //         backgroundColor: Colors.greenAccent[400],
    //         leading: IconButton(
    //           icon: Icon(Icons.menu),
    //           tooltip: 'Menu',
    //           onPressed: () {},
    //         ), //IconButton
    //         actions: <Widget>[
    //           IconButton(
    //             icon: Icon(Icons.comment),
    //             tooltip: 'Comment Icon',
    //             onPressed: () {},
    //           ), //IconButton
    //           IconButton(
    //             icon: Icon(Icons.settings),
    //             tooltip: 'Setting Icon',
    //             onPressed: () {},
    //           ), //IconButton
    //         ], //<Widget>[]
    //       ), //SliverAppBar

    //       SliverAppBar(
    //         backgroundColor: Colors.green,
    //         title: Text('Have a nice day'),
    //         floating: true,
    //       ),
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate(
    //           (context, index) => ListTile(
    //             tileColor: (index % 2 == 0) ? Colors.white : Colors.green[50],
    //             title: Center(
    //               child: Text('$index',
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.normal,
    //                       fontSize: 50,
    //                       color: Colors.greenAccent[400]) //TextStyle
    //                   ), //Text
    //             ), //Center
    //           ), //ListTile
    //           childCount: 51,
    //         ), //SliverChildBuildDelegate
    //       ) //SliverList
    //     ], //<Widget>[]
    //     //CustonScrollView
    //   ), //Scaffold

    //   // Remove debug banner for proper
    //   // view of setting icon
    // );
  }
}
