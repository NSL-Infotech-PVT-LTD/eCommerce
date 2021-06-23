import 'package:flutter/material.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(
          decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.loginBackground),
          fit: BoxFit.cover,
        ),
      )),

      Positioned(
        bottom: 0,
        child: Container(
          width: size.width,
          height: size.height * 0.68,
          decoration: BoxDecoration(
              color: AppColors.blackBackground,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        ),
      ),

      // top right content

      Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(right: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              Strings.alreadyhaveaccount,
              style: TextStyle(
                fontSize: size.width * 0.035,
                fontFamily: Fonts.dmSansRegular,
                color: AppColors.inputTitle,
              ),
            ),
            SizedBox(
              height: size.height * 0.008,
            ),
            Text(
              Strings.backtoSignin,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontFamily: Fonts.dmSansBold,
                  color: AppColors.white),
            ),
          ],
        ),
      ),

      SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                // title

                Text(
                  Strings.signup,
                  style: TextStyle(
                      fontSize: size.width * 0.088,
                      fontFamily: Fonts.abrilFatface,
                      color: Colors.white),
                ),

                SizedBox(
                  height: size.height * 0.015,
                ),

                // description

                Row(
                  children: [
                    Text(
                      Strings.quicklyOnboardto,
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: AppColors.descriptionfirst),
                    ),
                    SizedBox(
                      width: size.width * 0.015,
                    ),
                    Text(
                      Strings.funfypartyApp,
                      style: TextStyle(
                          fontSize: size.width * 0.045, color: Colors.white),
                    ),
                  ],
                ),

                // inputs

                SizedBox(
                  height: size.height * 0.05,
                ),

                // full name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    inputs(
                      context: context,
                      controller: "cont",
                      type: "type",
                      titletxt: Strings.fullname,
                      hinttxt: Strings.fullnamehint,
                    ),
                    inputs(
                      context: context,
                      controller: "cont",
                      type: "type",
                      titletxt: Strings.email,
                      hinttxt: Strings.emailHint,
                    ),
                    inputs(
                      context: context,
                      controller: "cont",
                      type: "type",
                      titletxt: Strings.password,
                      hinttxt: Strings.passwordhint,
                    ),
                    inputs(
                      context: context,
                      controller: "cont",
                      type: "type",
                      titletxt: Strings.dateofbirth,
                      hinttxt: Strings.dateofbirthhint,
                    ),
                    inputs(
                      context: context,
                      controller: "cont",
                      type: "type",
                      titletxt: Strings.gender,
                      hinttxt: Strings.genderHint,
                    ),

                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    // bottom content
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Strings.byContinuingYouAgreetoOur,
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansMedium,
                                    color: AppColors.donthaveaccount,
                                    fontSize: size.width * 0.04),
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(
                                Strings.termsOfService,
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansBold,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.white,
                                    fontSize: size.width * 0.033),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.and,
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansMedium,
                                    color: AppColors.donthaveaccount,
                                    fontSize: size.width * 0.04),
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(
                                Strings.privacypolicy,
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansBold,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.white,
                                    fontSize: size.width * 0.033),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),

                    // signup button
                    roundedBox(
                        // width: size.width * 0.78,
                        height: size.height * 0.058,
                        backgroundColor: AppColors.siginbackgrond,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Strings.signup,
                            style: TextStyle(
                                fontFamily: Fonts.dmSansMedium,
                                fontSize: size.width * 0.05,
                                color: AppColors.white),
                          ),
                        )),

                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ],
            )),

        //
      ),
    ])));
  }
}

Widget inputs({
  context,
  controller,
  type,
  titletxt,
  hinttxt,
}) {
  var size = MediaQuery.of(context).size;

  return Container(
    // width: size.width * 0.78,
    margin: EdgeInsets.only(top: size.height * 0.015),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titletxt,
          style: TextStyle(
              fontFamily: Fonts.dmSansMedium,
              fontSize: size.width * 0.04,
              // fontWeight: FontWeight.w500,
              color: AppColors.inputTitle),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        roundedBox(
          // width: size.width * 0.78,
          width: size.width,
          height: size.height * 0.058,
          backgroundColor: AppColors.inputbackgroung,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: TextField(
              style: TextStyle(
                fontFamily: Fonts.dmSansRegular,
                color: AppColors.inputHint,
              ),
              keyboardType: TextInputType.emailAddress,
              cursorColor: AppColors.white,
              decoration: InputDecoration(
                hintText: hinttxt,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    left: size.width * 0.04, right: size.width * 0.04),
                hintStyle: TextStyle(color: AppColors.inputHint),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
