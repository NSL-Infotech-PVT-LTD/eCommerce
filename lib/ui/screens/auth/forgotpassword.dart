import 'package:flutter/material.dart';
import 'package:funfy/apis/forgotpasswordApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/inputvalid.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();

  String _emailError = "";
  bool _loading = false;

  emailvalider() {
    setState(() {
      _emailError = "";
      if (_emailController.text == "") {
        _emailError = "${getTranslated(context, "pleaseEnterYourEmail")}";
      } else if (emailvalid(_emailController.text) == false) {
        _emailError = "${getTranslated(context, "pleaseEnterValidEmail")}";
      } else {
        _forgotPassword();
      }
    });
  }

  _forgotPassword() async {
    setState(() {
      _loading = true;
    });

    FocusScope.of(context).requestFocus(FocusNode());
    var net = await Internetcheck.check();

    if (net != false) {
      bool response = await forgotpasswordApiCall(email: _emailController.text);
      setState(() {
        _loading = false;
      });

      if (response == true) {
        Dialogs.simpledialogshow(
            context: context,
            title: "${getTranslated(context, "Success")}",
            // Strings.Success,
            description:
                "${getTranslated(context, "wehavesentlinkonyouemail")}",
            // Strings.wehavesentlinkonyouemail,
            okfunc: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Signin()));
            });
      } else {
        setState(() {
          _emailError =
              "${getTranslated(context, "pleaseEnterValidEmail")}"; //Strings.pleaseEnterValidEmail;
        });
      }
    } else {
      Internetcheck.showdialog(context: context);
    }
  }

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
                    "${getTranslated(context, "forgotpassword")}",
                    // Strings.forgotpassword,
                    style: TextStyle(
                        fontSize: size.width * 0.085,
                        fontFamily: Fonts.abrilFatface,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    children: [
                      Text(
                        "${getTranslated(context, "welcometo")}",
                        // Strings.welcometo,
                        style: TextStyle(
                            // fontFamily: Fonts.dmSansMedium,
                            fontSize: size.width * 0.048,
                            color: AppColors.inputTitle),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        "${getTranslated(context, "funfypartyapp")}",
                        // Strings.funfypartyapp,
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
                    "${getTranslated(context, "email")}",
                    // Strings.email,
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
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: TextField(
                        controller: _emailController,
                        style: TextStyle(
                          fontFamily: Fonts.dmSansRegular,
                          color: AppColors.inputHint,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColors.white,
                        decoration: InputDecoration(
                          hintText:
                              "${getTranslated(context, "emailHint")}", //Strings.emailHint,
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.only(
                          //     left: size.width * 0.04,
                          //     right: size.width * 0.04),
                          hintStyle: TextStyle(color: AppColors.inputHint),
                        ),
                      ),
                    ),
                  ),

                  // email error

                  _emailError != ""
                      ? Container(
                          margin: EdgeInsets.only(top: size.height * 0.01),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _emailError,
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: Fonts.dmSansMedium,
                                fontSize: size.width * 0.035),
                          ))
                      : SizedBox(),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            GestureDetector(
              onTap: () {
                emailvalider();
              },
              child: roundedBox(
                  width: size.width * 0.78,
                  height: size.height * 0.058,
                  backgroundColor: AppColors.siginbackgrond,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${getTranslated(context, "submit")}",
                      // Strings.submit,
                      style: TextStyle(
                          fontFamily: Fonts.dmSansMedium,
                          fontSize: size.width * 0.05,
                          color: AppColors.white),
                    ),
                  )),
            ),

            SizedBox(
              height: size.height * 0.05,
            ),

            ///
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Signin()));
              },
              child: Container(
                // color: Colors.blue,
                alignment: Alignment.center,
                width: size.width * 0.8,
                // width: size.width,
                child: Text.rich(TextSpan(
                    text:
                        "${getTranslated(context, "rememberyourpassword")}", // Strings.byContinuingYouAgreetoOur,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansMedium,
                        color: AppColors.donthaveaccount,
                        fontSize: size.width * 0.04),
                    children: <InlineSpan>[
                      TextSpan(
                        // recognizer: _termsandConditions,
                        text:
                            "${getTranslated(context, "backToSignIn")}", //"${Strings.termsOfService}",
                        style: TextStyle(
                            fontFamily: Fonts.dmSansBold,
                            decoration: TextDecoration.underline,
                            color: AppColors.white,
                            fontSize: size.width * 0.033),
                      ),
                    ])),
              ),
            ),
          ],
        ),
      ),

// progress
      _loading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)))
          : SizedBox()
    ])));
  }
}
