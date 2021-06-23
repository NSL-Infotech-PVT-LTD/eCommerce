import 'package:flutter/material.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
        ),
      ),
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.022,
            ),

            // app logo

            Container(
              height: size.height * 0.16,
              child: Image.asset(Images.appLogo),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            // title

            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.forgotpassword,
                    style: TextStyle(
                        fontSize: size.width * 0.088,
                        fontFamily: Fonts.abrilFatface,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    children: [
                      Text(
                        Strings.welcometo,
                        style: TextStyle(
                            // fontFamily: Fonts.dmSansMedium,
                            fontSize: size.width * 0.048,
                            color: AppColors.inputTitle),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        Strings.funfypartyapp,
                        style: TextStyle(
                            // fontFamily: Fonts.dmSansMedium,
                            fontSize: size.width * 0.048,
                            color: AppColors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.047,
            ),

            // email

            Container(
              width: size.width * 0.78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.email,
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
                    width: size.width * 0.78,
                    height: size.height * 0.058,
                    backgroundColor: AppColors.inputbackgroung,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: Fonts.dmSansRegular,
                          color: AppColors.inputHint,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColors.white,
                        decoration: InputDecoration(
                          hintText: Strings.emailHint,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.04),
                          hintStyle: TextStyle(color: AppColors.inputHint),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            roundedBox(
                width: size.width * 0.78,
                height: size.height * 0.058,
                backgroundColor: AppColors.siginbackgrond,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    Strings.signin,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansMedium,
                        fontSize: size.width * 0.05,
                        color: AppColors.white),
                  ),
                )),

            SizedBox(
              height: size.height * 0.05,
            ),

            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.rememberyourpassword,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansMedium,
                        color: AppColors.donthaveaccount,
                        fontSize: size.width * 0.04),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Signin()));
                    },
                    child: Text(
                      Strings.backToSignIn,
                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          decoration: TextDecoration.underline,
                          color: AppColors.white,
                          fontSize: size.width * 0.035),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ])));
  }
}
