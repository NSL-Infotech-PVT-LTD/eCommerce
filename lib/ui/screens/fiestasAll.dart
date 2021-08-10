import 'package:flutter/material.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/ui/widgets/postsitems.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';

class FiestasAll extends StatefulWidget {
  @override
  _FiestasAllState createState() => _FiestasAllState();
}

class _FiestasAllState extends State<FiestasAll> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.blackBackground,
        appBar: AppBar(
          backgroundColor: AppColors.blackBackground,
          centerTitle: true,
          title: Text("Fiestas"),
        ),
        body: Column(
          children: [
            Expanded(
                child:

                    //  _fiestasPostLoading == true
                    //     ? Center(
                    //         child: CircularProgressIndicator(
                    //             valueColor:
                    //                 AlwaysStoppedAnimation<Color>(AppColors.white)))
                    //     :

                    UserData.fiestasdata?.data?.data?.length == 0
                        //  && _postLoading == false
                        ? Center(
                            child: Text(
                              "${getTranslated(context, "PostsEmpty")}",
                              //     Strings.PostsEmpty,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: size.width * 0.04),
                            ),
                          )
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount:
                                UserData.fiestasdata?.data?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return fiestasItem(
                                  context: context,
                                  postModeldata: UserData
                                      .fiestasdata?.data?.data
                                      ?.elementAt(index));
                            })),
          ],
        ));
  }
}
