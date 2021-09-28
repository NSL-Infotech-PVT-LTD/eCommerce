import 'package:flutter/material.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/inputvalid.dart';
import 'package:funfy/ui/screens/auth/forgotpassword.dart';
import 'package:funfy/ui/screens/auth/signup.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/inputtype.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  String devicetype = "ios";
  bool _passeye = true;
  bool _credentialsError = false;
  String _emailError = "";

  // String _emailError = "";
  String _passwordError = "";
  bool _loading = false;
  Map facebookdata = {};
  TextEditingController facebookEmailController = TextEditingController();
  String facebookEmailError = "";

  _signinValid() {
    setState(() {
      _emailError = "";
      _passwordError = "";
      _credentialsError = false;
      if (_emailController.text == "") {
        _emailError =
            "${getTranslated(context, "pleaseEnterYourEmail")}"; // Strings.pleaseEnterYourEmail;
      } else if (emailvalid(_emailController.text) == false) {
        _emailError =
            "${getTranslated(context, "pleaseEnterValidEmail")}"; //Strings.pleaseEnterValidEmail;
      } else if (_passwordController.text == "") {
        _passwordError =
            "${getTranslated(context, "pleaseEnterYourpassword")}"; // Strings.pleaseEnterYourpassword;
      } else if (_passwordController.text.length < 6) {
        _passwordError =
            "${getTranslated(context, "pleaseEnterValidpassword")}"; //Strings.pleaseEnterValidpassword;
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

      try {
        await signinUser(
                context: context,
                email: _emailController.text,
                password: _passwordController.text,
                devicetype: Platform.isAndroid ? "android" : "ios")
            .then((response) {
          if (response?.status == true) {
            saveDataInshareP(
                name: response?.data?.user?.name,
                email: response?.data?.user?.email,
                token: response?.data?.token,
                mobile: response?.data?.user?.mobile,
                dob: response?.data?.user?.dob.toString(),
                profileImage: response?.data?.user?.image,
                gender: response?.data?.user?.gender,
                social: "false");

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home(pageIndexNum: 0)));
          } else {
            setState(() {
              _credentialsError = true;
            });
          }
          setState(() {
            _loading = false;
          });
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

  // facebook login

  _facebookSignin() async {
    var net = await Internetcheck.check();

    if (net != false) {
      setState(() {
        _loading = true;
      });

      print("facebook signin");

      try {
        FacebookAuth.instance.login(
          permissions: ['email', 'public_profile'],
        ).then((value) {
          setState(() {
            _loading = false;
          });

          FacebookAuth.instance.getUserData().then((userdata) {
            setState(() {
              _loading = false;
              facebookdata = userdata;
            });

            print(userdata);

            if (userdata["email"] != null) {
              facebooksignWithApi(
                  name: userdata["name"].toString(),
                  email: userdata["email"].toString(),
                  fbId: userdata["picture"]["data"]["id"].toString(),
                  profileImage: userdata["picture"]["data"]["url"].toString(),
                  deviceToken: "${UserData.deviceToken}",
                  deviceType: Platform.isAndroid ? "android" : "ios");

              print(userdata["email"]);
            } else {
              _showBottomSheetEmail();
              print("no email");
            }
          });
        }).onError((error, stackTrace) {
          setState(() {
            _loading = false;
          });

          return;
        });
      } catch (e) {
        print("no data in error");
      }
    } else {
      Internetcheck.showdialog(context: context);
    }
  }

  facebooksignWithApi(
      {String? name,
      String? email,
      String? fbId,
      String? deviceType,
      String? deviceToken,
      String? profileImage}) async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        _loading = true;
      });

      // print("$name $email $fbId $devicetype $profileImage");
      await facebookLogin(
              context: context,
              name: name,
              email: email,
              fbId: fbId,
              deviceToken: deviceToken,
              deviceType: deviceType,
              phoneBody: null,
              profileImage: profileImage)
          .then((response) {
        setState(() {
          _loading = false;
        });
        if (response?.status == true) {
          // print(response?.data?.toString());

          print(response.toJson());
          // print(response?.data?.user?.mobile);
          saveDataInshareP(
              name: response?.data?.user?.name,
              email: response?.data?.user?.email,
              token: response?.data?.token,
              mobile: response?.data?.user?.mobile ?? "",
              gender: response?.data?.user?.gender ?? "",
              profileImage: response?.data?.user?.image ?? "",
              social: "true");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home(pageIndexNum: 0)));
        }
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });

      print("Error in facebook login");
    }
  }

  _showBottomSheetEmail() {
    setState(() {
      facebookEmailError = "";
    });
    var size = MediaQuery.of(context).size;
    // showMaterialModalBottomSheet(
    showModalBottomSheet(
        isScrollControlled: true,
        // enableDrag: true,
        // expand: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: size.height * 0.45,
                child: Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //     right: size.width * 0.04, top: size.height * 0.02),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.035),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getTranslated(context, "pleaseEnterYourEmailToSignin")}",
                              // Strings.pleaseEnterYourEmailToSignin,
                              style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  fontFamily: Fonts.dmSansMedium),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            inputstype2(
                                context: context,
                                controller: facebookEmailController,
                                obscureTextBool: false,
                                titletxt: "${getTranslated(context, "email")}",
                                // Strings.email,
                                hinttxt:
                                    "${getTranslated(context, "emailHint")}",
                                // Strings.emailHint,
                                inputError: facebookEmailError,
                                ontapFun: null,
                                height: size.height * 0.06,
                                readonly: false),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            GestureDetector(
                              onTap: () {
                                // check valid email

                                setState(() {
                                  if (facebookEmailController.text == "") {
                                    facebookEmailError =
                                        "${getTranslated(context, "pleaseEnterYourEmail")}"; //  Strings.pleaseEnterYourEmail;
                                  } else if (emailvalid(
                                          facebookEmailController.text) ==
                                      false) {
                                    print("email is not valid");
                                    facebookEmailError =
                                        "${getTranslated(context, "pleaseEnterValidEmail")}"; //    Strings.pleaseEnterValidEmail;
                                  } else {
                                    print(
                                        "email is ok ${facebookEmailController.text}");
                                    facebooksignWithApi(
                                        name: facebookdata["name"].toString(),
                                        email: facebookEmailController.text
                                            .toString(),
                                        fbId: facebookdata["id"].toString(),
                                        profileImage: facebookdata["picture"]
                                                ["data"]["url"]
                                            .toString(),
                                        deviceToken: facebookdata["id"],
                                        deviceType: Platform.isAndroid
                                            ? "android"
                                            : "ios");

                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                              child: roundedBox(
                                  // width: size.width * 0.78,
                                  height: size.height * 0.06,
                                  backgroundColor: AppColors.siginbackgrond,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${getTranslated(context, "signin")}",
                                      // Strings.signin,
                                      style: TextStyle(
                                          fontFamily: Fonts.dmSansBold,
                                          fontSize: size.width * 0.045,
                                          color: AppColors.white),
                                    ),
                                  )),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  // apple Signin --------------- //

  appleSignin() async {
    final acc = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(acc);
    try {
      setState(() {
        _loading = true;
      });
      appleLogin(
              context: context,
              name: acc.givenName ?? "",
              email: acc.email ?? "",
              googleid: acc.identityToken ?? "",
              deviceType: Platform.isAndroid ? "android" : "ios",
              profileImage: "")
          .then((res) {
        if (res?.code == 200 || res?.code == 201) {
          print("userToken google - ${res?.data?.token}");
          saveDataInshareP(
              name: res?.data?.user?.name,
              email: res?.data?.user?.email,
              token: res?.data?.token,
              mobile: res?.data?.user?.mobile,
              profileImage: res?.data?.user?.image,
              social: "true");

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Home(pageIndexNum: 0)),
              (route) => false);
        } else {
          setState(() {
            _loading = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  // google sigin

  Future _googleSignin() async {
    setState(() {
      _loading = true;
    });
    // print("google signin ---------------------");
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    _googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
      setState(() {
        _loading = false;
      });

      setState(() {
        _loading = false;
      });

      try {
        setState(() {
          _loading = true;
        });
        googleLogin(
                context: context,
                name: acc?.displayName ?? "",
                email: acc?.email ?? "",
                googleid: acc?.id ?? "",
                deviceType: Platform.isAndroid ? "android" : "ios",
                deviceToken: acc?.id ?? "",
                profileImage: acc?.photoUrl ?? "")
            .then((res) {
          if (res?.code == 200 || res?.code == 201) {
            print("userToken google - ${res?.data?.token}");
            saveDataInshareP(
                name: res?.data?.user?.name,
                email: res?.data?.user?.email,
                mobile: res?.data?.user?.mobile,
                token: res?.data?.token,
                profileImage: res?.data?.user?.image,
                social: "true");

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Home(pageIndexNum: 0)),
                (route) => false);
          } else {
            setState(() {
              _loading = false;
            });
          }
        });
      } catch (e) {
        setState(() {
          _loading = false;
        });
      }

      acc?.authentication.then((GoogleSignInAuthentication auth) async {
        print(auth.idToken);
        print(auth.accessToken);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            key: _scaffoldKey,
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
                      width: size.width,
                      child: Center(
                        child: Container(
                          height: size.height * 0.16,
                          child: Image.asset(Images.appLogo),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    // title

                    Container(
                      width: size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getTranslated(context, "signin")}",
                            //  Strings.signin,
                            style: TextStyle(
                                fontSize: size.width * 0.088,
                                fontFamily: Fonts.abrilFatface,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          //

                          Text.rich(TextSpan(
                              text: "${getTranslated(context, "welcometo")}",
                              // Strings.byContinuingYouAgreetoOur,
                              style: TextStyle(
                                  fontSize: size.width * 0.048,
                                  color: AppColors.inputTitle),
                              children: <InlineSpan>[
                                TextSpan(
                                  text:
                                      " ${getTranslated(context, "funfypartyapp")} ",
                                  //"${Strings.termsOfService}",
                                  style: TextStyle(
                                      fontSize: size.width * 0.048,
                                      color: AppColors.white),
                                ),
                              ])),

                          ///
                          // Row(
                          //   children: [
                          //     Text(
                          //       "${getTranslated(context, "welcometo")}",
                          //       // Strings.welcometo,
                          //       style: TextStyle(
                          //           // fontFamily: Fonts.dmSansMedium,
                          //           fontSize: size.width * 0.048,
                          //           color: AppColors.inputTitle),
                          //     ),
                          //     SizedBox(
                          //       width: size.width * 0.02,
                          //     ),
                          //     Text(
                          //       "${getTranslated(context, "funfypartyapp")}",
                          //       // Strings.funfypartyapp,
                          //       style: TextStyle(
                          //           // fontFamily: Fonts.dmSansMedium,
                          //           fontSize: size.width * 0.048,
                          //           color: AppColors.white),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.047,
                    ),

                    // facebook signup

                    socialSigninButton(
                        context: context,
                        title:
                            "${getTranslated(context, "signinwithfacebook")}",
                        //Strings.signinwithfacebook,
                        iconImage: Images.fbIcon,
                        func: _facebookSignin),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    // Google signup
                    socialSigninButton(
                        context: context,
                        title: "${getTranslated(context, "signinwithgoogle")}",
                        // Strings.signinwithgoogle,
                        iconImage: Images.googleIconActPng,
                        func: _googleSignin),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    // apple signup

                    Platform.isIOS
                        ? socialSigninButton(
                            context: context,
                            title:
                                "${getTranslated(context, "signinwithApple")}",
                            // Strings.signinwithApple,
                            iconImage: Images.appleIcon,
                            func: () async {
                              appleSignin();
                            })
                        : SizedBox(),

                    SizedBox(
                      height: size.height * 0.035,
                    ),

                    // or

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                  color: AppColors.white,
                                  fontSize: size.width * 0.04),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: size.height * 0.0006,
                              color: Colors.white,
                            )),
                          ]),
                        ),
                      ],
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
                            // width: size.width * 0.78,
                            height: size.height * 0.058,
                            backgroundColor: AppColors.inputbackgroung,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04),
                              child: Row(
                                children: [
                                  Expanded(
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
                                            "${getTranslated(context, "emailHint")}",
                                        //Strings.emailHint,
                                        border: InputBorder.none,
                                        // contentPadding: EdgeInsets.only(
                                        //     left: size.width * 0.04,
                                        //     right: size.width * 0.04),
                                        hintStyle: TextStyle(
                                            color: AppColors.inputHint,
                                            fontSize: size.width * 0.04),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // error email

                          _emailError != ""
                              ? Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.01),
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
                            "${getTranslated(context, "password")}",
                            // Strings.password,
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
                                            hintText:
                                                "${getTranslated(context, "passwordhint")}",
                                            //Strings.passwordhint,
                                            border: InputBorder.none,
                                            // contentPadding: EdgeInsets.only(
                                            //     left: size.width * 0.04,
                                            //     right: size.width * 0.04),

                                            hintStyle: TextStyle(
                                                color: AppColors.inputHint,
                                                fontSize: size.width * 0.04),
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
                                          child: Image.asset(_passeye != false
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
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.01),
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
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${getTranslated(context, "CredentialsDoesnmatched")}",
                                        // Strings.CredentialsDoesnmatched,
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
                          "${getTranslated(context, "forgotPassword")}",
                          // Strings.forgotPassword,
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
                              "${getTranslated(context, "signin")}",
                              // Strings.signin,
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
                            "${getTranslated(context, "donthaveAccount")}",
                            // Strings.donthaveAccount,
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
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUp()));
                            },
                            child: Text(
                              "${getTranslated(context, "signupUp")}",
                              // Strings.signupUp,
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.siginbackgrond)))
                  : SizedBox()
            ])));
  }
}

socialSigninButton({context, String? title, String? iconImage, func}) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: func,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        roundedBox(
            width: size.width * 0.78,
            height: size.height * 0.053,
            backgroundColor: Colors.white,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                // "${getTranslated(context, "title")}",
                title.toString(),
                style: TextStyle(
                  color: AppColors.fbappletitle,
                  fontFamily: Fonts.dmSansMedium,
                  // fontSize: size.width * 0.045,
                  fontSize: size.width * 0.04,
                ),
              ),
            )),
        Positioned(
          left: size.width * 0.05,
          child: Container(
              width: size.width * 0.05,
              child: Image.asset(
                iconImage.toString(),
                // height: size.height * 0.02,
                width: size.width * 0.07,
                fit: BoxFit.cover,
              )),
        ),
      ],
    ),
  );
}
