import 'package:flutter/material.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/emailvalid.dart';
import 'package:funfy/models/userModel.dart';
import 'package:funfy/ui/screens/auth/forgotpassword.dart';
import 'package:funfy/ui/screens/auth/signup.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  String devicetype = "ios";
  bool _passeye = false;
  bool _credentialsError = false;
  String _emailError = "";
  String _passwordError = "";
  bool _loading = false;

  _signinValid() {
    setState(() {
      _emailError = "";
      _passwordError = "";
      _credentialsError = false;
      if (_emailController.text == "") {
        _emailError = Strings.pleaseEnterYourEmail;
      } else if (emailvalid(_emailController.text) == false) {
        _emailError = Strings.pleaseEnterValidEmail;
      } else if (_passwordController.text == "") {
        _passwordError = Strings.pleaseEnterYourpassword;
      } else if (_passwordController.text.length < 6) {
        _passwordError = Strings.pleaseEnterValidpassword;
      } else {
        _SigninUser();
      }
    });
  }

  _SigninUser() async {
    var net = await Internetcheck.check();

    if (net != false) {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        _loading = true;
      });
      print("Sign in");

      try {
        var response = await signinUser(
            email: _emailController.text,
            password: _passwordController.text,
            devicetype: devicetype);

        if (response != false) {
          print(response["data"]["token"]);
          Constants.prefs?.setString("token", response["data"]["token"]);

          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        } else {
          setState(() {
            _credentialsError = true;
          });
        }
        setState(() {
          _loading = false;
        });
      } catch (e) {
        setState(() {
          _loading = false;
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
                    Strings.signin,
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

            // facebook signup

            roundedBox(
                width: size.width * 0.78,
                height: size.height * 0.053,
                backgroundColor: Colors.white,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Container(child: Image.asset(Images.fbIcon)),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        Strings.signinwithfacebook,
                        style: TextStyle(
                          color: AppColors.fbappletitle,
                          fontFamily: Fonts.dmSansMedium,
                          fontSize: size.width * 0.045,
                        ),
                      )
                    ],
                  ),
                )),

            SizedBox(
              height: size.height * 0.02,
            ),

            // apple signup

            roundedBox(
                width: size.width * 0.78,
                height: size.height * 0.053,
                backgroundColor: Colors.white,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Container(child: Image.asset(Images.appleIcon)),
                      SizedBox(
                        width: size.width * 0.07,
                      ),
                      Text(
                        Strings.signinwithApple,
                        style: TextStyle(
                            fontFamily: Fonts.dmSansMedium,
                            fontSize: size.width * 0.045,
                            color: AppColors.fbappletitle),
                      )
                    ],
                  ),
                )),

            SizedBox(
              height: size.height * 0.035,
            ),

            // or

            Container(
              width: size.width * 0.8,
              child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  thickness: size.height * 0.0006,
                  color: Colors.white,
                )),
                Text(
                  " OR ",
                  style: TextStyle(
                      color: AppColors.white, fontSize: size.width * 0.04),
                ),
                Expanded(
                    child: Divider(
                  thickness: size.height * 0.0006,
                  color: Colors.white,
                )),
              ]),
            ),

            SizedBox(
              height: size.height * 0.008,
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
                        controller: _emailController,
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

                  // error email

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
              height: size.height * 0.025,
            ),

            // password

            Container(
              width: size.width * 0.78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.password,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansMedium,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: AppColors.inputTitle),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Column(
                    children: [
                      roundedBox(
                        width: size.width * 0.78,
                        height: size.height * 0.058,
                        backgroundColor: AppColors.inputbackgroung,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: _passeye,
                                  style: TextStyle(
                                    fontFamily: Fonts.dmSansRegular,
                                    color: AppColors.inputHint,
                                  ),
                                  cursorColor: AppColors.white,
                                  decoration: InputDecoration(
                                    hintText: Strings.passwordhint,
                                    border: InputBorder.none,
                                    // contentPadding: EdgeInsets.only(
                                    //     left: size.width * 0.04,
                                    //     right: size.width * 0.04),

                                    hintStyle:
                                        TextStyle(color: AppColors.inputHint),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passeye == false
                                        ? _passeye = true
                                        : _passeye = false;
                                  });
                                },
                                child: Container(
                                  width: size.width * 0.07,
                                  child: Image.asset(_passeye == false
                                      ? Images.eyeclose
                                      : Images.eyeOpen),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // error email

                      _passwordError != ""
                          ? Container(
                              margin: EdgeInsets.only(top: size.height * 0.01),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _passwordError,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: Fonts.dmSansMedium,
                                    fontSize: size.width * 0.035),
                              ))
                          : SizedBox(),

                      // error password

                      _credentialsError
                          ? Container(
                              margin: EdgeInsets.only(top: size.height * 0.01),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Strings.CredentialsDoesnmatched,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: Fonts.dmSansMedium,
                                    fontSize: size.width * 0.035),
                              ))
                          : SizedBox()
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.025,
            ),

            // forgot password

            Container(
              alignment: Alignment.bottomRight,
              width: size.width * 0.78,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotPassword()));
                },
                child: Text(
                  Strings.forgotPassword,
                  style: TextStyle(
                      fontFamily: Fonts.dmSansMedium,
                      fontSize: size.width * 0.035,
                      color: AppColors.forgotpassword),
                ),
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

// signin Button
            GestureDetector(
              onTap: () {
                _signinValid();
              },
              child: roundedBox(
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
            ),

            SizedBox(
              height: size.height * 0.05,
            ),

            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.donthaveAccount,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansRegular,
                        color: AppColors.donthaveaccount,
                        fontSize: size.width * 0.04),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      Strings.signupUp,
                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          decoration: TextDecoration.underline,
                          color: AppColors.white,
                          fontSize: size.width * 0.04),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
      _loading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)))
          : SizedBox()
    ])));
  }
}
