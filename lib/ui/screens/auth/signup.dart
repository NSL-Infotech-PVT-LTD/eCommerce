import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:funfy/apis/homeApis.dart';
import 'package:funfy/apis/signupApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/inputvalid.dart';
import 'package:funfy/components/zeroadd.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/inputtype.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io' show Platform;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  String lorem =
      "<p style=\"text-align: center; \"><span style=\"font-size: 1rem;\"><b>Terms and Conditions</b></span></p><div id=\"Content\" style=\"margin: 0px; padding: 0px; position: relative; font-family: \" open=\"\" sans\",=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" text-align:=\"\" center;\"=\"\"><div id=\"Translation\" style=\"margin: 0px 28.7969px; padding: 0px; text-align: left;\"><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify;\">On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammeled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.\"</p><div><br></div></div></div><p><br></p><p><br></p><p><br></p>";
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  String dob = "";
  DateTime dobDateTime = DateTime.now();
  String gender = "";
  bool _loading = false;
  bool _passeye = true;

  String _fullnameError = "";
  String _emailError = "";
  String _passwordError = "";
  String _dobError = "";
  String _genderError = "";
  String _signupError = "";

  signupUser() {
// input validation ----------- //
    setState(() {
      _fullnameError = "";
      _emailError = "";
      _passwordError = "";
      _dobError = "";
      _genderError = "";

// fullname
      if (_fullnameController.text == "") {
        _fullnameError = Strings.pleaseEnterYourfullname;
      } else if (_fullnameController.text.length < 3) {
        _fullnameError = Strings.yourNameMustBeAbove3Characters;
      } else if (validateName(_fullnameController.text) != "") {
        _fullnameError = validateName(_fullnameController.text);
      }
// email
      if (_emailController.text == "") {
        _emailError = Strings.pleaseEnterYourEmail;
      } else if (emailvalid(_emailController.text) == false) {
        _emailError = Strings.pleaseEnterValidEmail;
      }

// password
      if (_passwordController.text == "") {
        _passwordError = Strings.pleaseEnterYourpassword;
      } else if (_passwordController.text.length < 8) {
        _passwordError = Strings.yourPasswordMustBeAbove8Characters;
      }

// dob
      if (_dobController.text == "") {
        _dobError = Strings.dateofbirthhint;
      } else if (calculateAge(dobDateTime) != "") {
        _dobError = Strings.agemustbe18;
      }

// gender
      if (_genderController.text == "") {
        _genderError = Strings.pleaseEnterYourGender;
      }
      if (_fullnameError == "" &&
          _emailError == "" &&
          _passwordError == "" &&
          dob != "" &&
          _genderError == "") {
        _signupApicall();
      }
    });
  }

  // sign up api call

  _signupApicall() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _loading = true;
    });

    var net = await Internetcheck.check();

    if (net == false) {
      Internetcheck.showdialog(context: context);
    } else {
      try {
        setState(() {
          _loading = true;
        });

        await signApiCall(
          fullname: _fullnameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          dob: dob,
          gender: gender.toLowerCase(),
          devicetype: Platform.isAndroid ? "android" : "ios",
        ).then((value) {
          if (value["bool"] == true) {
            // Dialogs.simpleOkAlertDialog(
            //     context: context,
            //     title: "${getTranslated(context, 'success')}",
            //     content:
            //         "${getTranslated(context, 'yourAccountisSuccessfullyregistered')}",
            //     func: () {
            //       Navigator.of(context).pushReplacement(
            //           MaterialPageRoute(builder: (context) => Signin()));
            //     });
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Home(
                      pageIndexNum: 0,
                    )));
          } else {
            print(value["res"]["error"]);

            setState(() {
              if (value["res"]["error"] == Strings.emailError) {
                _emailError = Strings.emailError;
              } else if (value["res"]["error"] == Strings.dobError) {
                _dobError = Strings.dobError;
              }
            });
          }
        });

        setState(() {
          _loading = false;
        });
      } catch (e) {
        print("signup error $e");
        setState(() {
          _loading = false;
        });
      }
    }
  }

  // date picker

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950, 12),
      currentDate: selectedDate,
      lastDate: selectedDate,
    );

    if (picked != null && picked != selectedDate) {
      String month = await zeroAdd(picked.month);
      String day = await zeroAdd(picked.day);
      setState(() {
        // selectedDate = picked.;
        dobDateTime = picked;
        dob = "${picked.year}-$month-$day";
        _dobController.text = dob;

        print(dob);
      });
    }
  }

  bool termLoading = false;

  String termHtml = "";

  String privacyHtml = "";

  // api call
  tersConditions() async {
    var net = await Internetcheck.check();

    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      try {
        setState(() {
          _loading = true;
        });
        helpApi().then((htmlString) {
          setState(() {
            _loading = false;
            termHtml = htmlString!;

            // print("here is html = $termHtml");
          });
        });

        privacypol().then((htmlString2) {
          setState(() {
            _loading = false;
            privacyHtml = htmlString2!;

            // print("here is html = $privacyHtml");
          });
        });
      } catch (e) {
        print(e);
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _showBottomSheet({context, String? titletext, String? description}) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              key: _keyScaffold,
              builder: (context, setstate) {
                return Container(
                  margin: EdgeInsets.only(top: size.height * 0.008),
                  color: Colors.white,
                  height: size.height * 08,
                  width: size.width,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.cancel_outlined),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${getTranslated(context, "$titletext")}",
                          // titletext.toString(),
                          style: TextStyle(
                            fontFamily: Fonts.dmSansBold,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Html(data: description),
                      ))
                    ],
                  ),
                );
              });
        });
  }

  // gender bottom list

  void _showBottomSheetgender(context) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: size.height * 0.25,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      gender = "male";
                      _genderController.text =
                          "${getTranslated(context, "male")}";
                    });
                    Navigator.of(context).pop();
                  },
                  leading: Icon(
                    Icons.male,
                    // color: AppColors.siginbackgrond,
                  ),
                  title: Text(
                    "${getTranslated(context, "male")}",
                    // Strings.male,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansBold,
                        fontSize: size.width * 0.042),
                  ),
                ),

                ListTile(
                  onTap: () {
                    setState(() {
                      gender = "female";
                      //Strings.female;
                      _genderController.text =
                          "${getTranslated(context, "female")}";
                    });
                    Navigator.of(context).pop();
                  },
                  // leading: Icon(Icons.female),
                  leading: Icon(Icons.female),
                  title: Text("${getTranslated(context, "female")}",
                      // Strings.female,

                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.042)),
                ),

                ListTile(
                  onTap: () {
                    setState(() {
                      gender = "other";
                      _genderController.text =
                          "${getTranslated(context, "other")}";
                    });
                    Navigator.of(context).pop();
                  },
                  // leading: Icon(Icons.female),
                  leading: Icon(Icons.transgender),
                  title: Text("${getTranslated(context, "other")}",
                      // Strings.other,

                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.042)),
                )
                //  Container(child: Text(Strings.))
              ],
            ),
          );
        });
  }

  TapGestureRecognizer? _termsandConditions;
  TapGestureRecognizer? _policy;

  @override
  void initState() {
    super.initState();
    tersConditions();

    _termsandConditions = TapGestureRecognizer()
      ..onTap = () {
        if (_loading == false) {
          _showBottomSheet(
              context: context,
              titletext: "termsAndConditions",
              description: termHtml);
        }
      };

    _policy = TapGestureRecognizer()
      ..onTap = () {
        if (_loading == false) {
          _showBottomSheet(
              context: context,
              titletext: "privacyPolicy",
              description: privacyHtml);
        }
      };
  }

  // terms
  _terms() {
    print("hello");
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

      SingleChildScrollView(
        child: Column(
          children: [
            // top right content

            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(
                  right: size.width * 0.05, top: size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "${getTranslated(context, "alreadyhaveaccount")}",
                    // Strings.alreadyhaveaccount,
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      fontFamily: Fonts.dmSansRegular,
                      color: AppColors.inputTitle,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.008,
                  ),
                  InkWell(
                    onTap: () {
                      print("ok2");
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "${getTranslated(context, "backtoSignin")}",
                      // Strings.backtoSignin,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: Fonts.dmSansBold,
                          color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    // title

                    Text(
                      "${getTranslated(context, "signup")}",
                      // Strings.signup,
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
                          "${getTranslated(context, "quicklyOnboardto")}",
                          // Strings.quicklyOnboardto,
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              color: AppColors.descriptionfirst),
                        ),
                        SizedBox(
                          width: size.width * 0.015,
                        ),
                        Flexible(
                          child: Text(
                            "${getTranslated(context, "funfypartyApp")}",
                            // Strings.funfypartyApp,
                            style: TextStyle(
                                fontSize: size.width * 0.045,
                                color: Colors.white),
                          ),
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
                            controller: _fullnameController,
                            obscureTextBool: false,
                            titletxt:
                                "${getTranslated(context, "fullname")}", //Strings.fullname,
                            hinttxt:
                                "${getTranslated(context, "fullnamehint")}", // Strings.fullnamehint,
                            inputError: _fullnameError,
                            readonly: false,
                            ontapFun: null),
                        inputs(
                            context: context,
                            controller: _emailController,
                            obscureTextBool: false,
                            titletxt:
                                "${getTranslated(context, "email")}", // Strings.email,
                            hinttxt:
                                "${getTranslated(context, "emailHint")}", // Strings.emailHint,
                            inputError: _emailError,
                            ontapFun: null,
                            readonly: false),
                        // inputs(
                        //     context: context,
                        //     controller: _passwordController,
                        //     obscureTextBool: false,
                        //     titletxt: Strings.password,
                        //     hinttxt: Strings.passwordhint,
                        //     inputError: _passwordError,
                        //     ontapFun: null,
                        //     readonly: false),

                        // password
                        Container(
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
                                                    "${getTranslated(context, "passwordhint")}", //Strings.passwordhint,
                                                border: InputBorder.none,
                                                // contentPadding: EdgeInsets.only(
                                                //     left: size.width * 0.04,
                                                //     right: size.width * 0.04),

                                                hintStyle: TextStyle(
                                                    color: AppColors.inputHint,
                                                    fontSize:
                                                        size.width * 0.04),
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
                                              child: Image.asset(
                                                  _passeye != false
                                                      ? Images.eyeclose
                                                      : Images.eyeOpen),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // error password

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
                                ],
                              ),
                            ],
                          ),
                        ),
                        inputs(
                            context: context,
                            controller: _dobController,
                            obscureTextBool: false,
                            titletxt:
                                "${getTranslated(context, "dateofbirth")}", // Strings.dateofbirth,
                            hinttxt:
                                "${getTranslated(context, "dobtypehint")}", // Strings.dobtypehint,
                            inputError: _dobError,
                            ontapFun: selectDate,
                            readonly: true),
                        inputs(
                            context: context,
                            controller: _genderController,
                            obscureTextBool: false,
                            titletxt:
                                "${getTranslated(context, "gender")}", // Strings.gender,
                            hinttxt:
                                "${getTranslated(context, "genderHint")}", // Strings.genderHint,
                            inputError: _genderError,
                            ontapFun: _showBottomSheetgender,
                            readonly: true),

                        _signupError != ""
                            ? Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.01),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _signupError.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: Fonts.dmSansMedium,
                                      fontSize: size.width * 0.035),
                                ))
                            : SizedBox(),

                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        // bottom content
                        Container(
                          // alignment: Alignment.center,
                          child: Text.rich(TextSpan(
                              text:
                                  " ${getTranslated(context, "byContinuingYouAgreetoOur")} ", // Strings.byContinuingYouAgreetoOur,
                              style: TextStyle(
                                  fontFamily: Fonts.dmSansMedium,
                                  color: AppColors.donthaveaccount,
                                  fontSize: size.width * 0.04),
                              children: <InlineSpan>[
                                TextSpan(
                                  recognizer: _termsandConditions,
                                  text:
                                      " ${getTranslated(context, "termsOfService")} ", //"${Strings.termsOfService}",
                                  style: TextStyle(
                                      fontFamily: Fonts.dmSansBold,
                                      decoration: TextDecoration.underline,
                                      color: AppColors.white,
                                      fontSize: size.width * 0.033),
                                ),
                                TextSpan(
                                    text:
                                        " ${getTranslated(context, "and")} ", //"${Strings.and}",
                                    style: TextStyle(
                                        fontFamily: Fonts.dmSansMedium,
                                        color: AppColors.donthaveaccount,
                                        fontSize: size.width * 0.04)),
                                TextSpan(
                                  recognizer: _policy,
                                  text:
                                      " ${getTranslated(context, "privacypolicy")} ",
                                  // " ${Strings.privacypolicy}",
                                  style: TextStyle(
                                      fontFamily: Fonts.dmSansBold,
                                      decoration: TextDecoration.underline,
                                      color: AppColors.white,
                                      fontSize: size.width * 0.033),
                                ),
                              ])),
                        ),

                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        // signup button
                        GestureDetector(
                          onTap: () {
                            print("signup");

                            if (_loading == false) {
                              signupUser();
                            }
                          },
                          child: roundedBox(
                              // width: size.width * 0.78,
                              height: size.height * 0.058,
                              backgroundColor: AppColors.siginbackgrond,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${getTranslated(context, "signup")}",
                                  // Strings.signup,
                                  style: TextStyle(
                                      fontFamily: Fonts.dmSansMedium,
                                      fontSize: size.width * 0.05,
                                      color: AppColors.white),
                                ),
                              )),
                        ),

                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),

        //
      ),

      // // top right content

      // Container(
      //   alignment: Alignment.topRight,
      //   margin: EdgeInsets.only(right: size.width * 0.05),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       SizedBox(
      //         height: size.height * 0.02,
      //       ),
      //       Text(
      //         Strings.alreadyhaveaccount,
      //         style: TextStyle(
      //           fontSize: size.width * 0.035,
      //           fontFamily: Fonts.dmSansRegular,
      //           color: AppColors.inputTitle,
      //         ),
      //       ),
      //       SizedBox(
      //         height: size.height * 0.008,
      //       ),
      //       InkWell(
      //         onTap: () {
      //           print("ok2");
      //           Navigator.of(context).pop();
      //         },
      //         child: Text(
      //           Strings.backtoSignin,
      //           style: TextStyle(
      //               decoration: TextDecoration.underline,
      //               fontFamily: Fonts.dmSansBold,
      //               color: AppColors.white),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      _loading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)))
          : SizedBox()
    ])));
  }
}
