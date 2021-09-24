import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/apis/signupApi.dart';

import 'package:funfy/components/inputvalid.dart';
import 'package:funfy/components/zeroadd.dart';

import 'package:funfy/ui/widgets/inputtype.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:io' show Platform;

final _picker = ImagePicker();

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  String dob = "";
  DateTime dobDateTime = DateTime.now();
  String gender = "";
  bool _loading = false;
  bool _passeye = true;
  File? _image;

  String _fullnameError = "";
  String _dobError = "";
  String _mobileError = "";
  String _genderError = "";
  String _signupError = "";

  update() {
    print("update");
// input validation ----------- //
    setState(() {
      _fullnameError = "";
      _dobError = "";
      _genderError = "";
      _mobileError = "";
// fullname
      if (_fullnameController.text == "") {
        _fullnameError =
            "${getTranslated(context, "pleaseEnterYourfullname")}"; //Strings.pleaseEnterYourfullname;
      } else if (_fullnameController.text.length < 3) {
        _fullnameError =
            "${getTranslated(context, "yourNameMustBeAbove3Characters")}"; // Strings.yourNameMustBeAbove3Characters;
      } else if (validateName(_fullnameController.text) != "") {
        _fullnameError = validateName(_fullnameController.text);
      }

      if (Constants.prefs?.getString("social").toString() == "false") {
// dob
        if (_dobController.text == "") {
          _dobError =
              "${getTranslated(context, "dateofbirthhint")}"; //Strings.dateofbirthhint;
        } else if (calculateAge(dobDateTime) != "") {
          _dobError =
              "${getTranslated(context, "agemustbe18")}"; //Strings.agemustbe18;
        }

        // mobile

        if (_mobileController.text == "") {
          _mobileError =
              "${getTranslated(context, 'pleaseEnterYourMobileNumber')}";
        }

// gender
        if (_genderController.text == "") {
          _genderError =
              "${getTranslated(context, "pleaseEnterYourGender")}"; //Strings.pleaseEnterYourGender;
        }
        if (_fullnameError == "" && _dobError == "" && _genderError == "") {
          _updateProfile();
        } else {
          print("error is here");
        }
      }

      // social Update

      else {
        print("social Update");

        if (_fullnameError == "") {
          _updateProfile();
        }
      }
    });
  }

  // sign up api call

  _updateProfile() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _loading = true;
    });
    var net = await Internetcheck.check();

    if (net == false) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        await updateProfile(
                name: _fullnameController.text,
                gender: "${_genderController.text}",
                dob: "$dob",
                imageFile: _image)
            .then((response) {
          setState(() {
            _loading = false;
            if (response?.code == 201 && response?.status == true) {
              saveDataInshareP(
                  name: response?.data?.user?.name,
                  email: response?.data?.user?.email,
                  profileImage: response?.data?.user?.image,
                  gender: response?.data?.user?.gender,
                  mobile: response?.data?.user?.mobile.toString(),
                  dob: response?.data?.user?.dob
                      .toString()
                      .split(" ")[0]
                      .toString(),
                  social:
                      Constants.prefs?.getString("social").toString() == "false"
                          ? "false"
                          : "true");
              print("newData + ${response?.data?.user?.dob.toString()}");
            } else {
              print("error in update Profile");
            }

            setdataolddata();
          });

          Navigator.of(context).pop();
        });
      } catch (e) {
        setState(() {
          _loading = false;
        });

        print(e);
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

        print("dob + $dob");
      });
    }
  }

  void _showBottomSheet({context, String? titletext, String? description}) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
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
                    "${getTranslated(context, "titletext")}",
                    //titletext.toString(),
                    style: TextStyle(
                      fontFamily: Fonts.dmSansBold,
                      fontSize: size.width * 0.05,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Html(data: description)),
                )
              ],
            ),
          );
        });
  }

  // gender bottom list

  void _showBottomSheetgender(context) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: size.height * 0.27,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      gender =
                          "${getTranslated(context, "male")}"; // Strings.male;
                      _genderController.text = gender;
                    });
                    Navigator.of(context).pop();
                  },
                  leading: Icon(
                    // Icons.error,
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
                      gender =
                          "${getTranslated(context, "female")}"; //Strings.female;
                      _genderController.text = gender;
                    });
                    Navigator.of(context).pop();
                  },
                  // leading: Icon(Icons.female),
                  leading: Icon(Icons.female),
                  title: Text(
                      //Strings.female,
                      "${getTranslated(context, "female")}",
                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.042)),
                ),

                ListTile(
                  onTap: () {
                    setState(() {
                      gender = "${getTranslated(context, "other")}";
                      // Strings.other;
                      _genderController.text = gender;
                    });
                    Navigator.of(context).pop();
                  },
                  leading: Icon(Icons.female),
                  // leading: Icon(Icons.error),
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

  // pick profile image bottom list

  void _profilePickshowBottomSheet(context) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: size.height * 0.2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickImage(cameraOrGallery: ImageSource.camera);

                    Navigator.of(context).pop();
                  },
                  // leading: Icon(Icons.female),
                  leading: Icon(Icons.camera),
                  title: Text(
                      // Strings.camera
                      "${getTranslated(context, "camera")}",
                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.042)),
                ),
                ListTile(
                  onTap: () {
                    pickImage(cameraOrGallery: ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  leading: Icon(
                    // Icons.error,
                    Icons.image,
                    // color: AppColors.siginbackgrond,
                  ),
                  title: Text(
                    "${getTranslated(context, "gallery")}",
                    // Strings.gallery,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansBold,
                        fontSize: size.width * 0.042),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // pick image

  pickImage({cameraOrGallery}) async {
    await _picker
        .getImage(imageQuality: 60, source: cameraOrGallery)
        .then((image) {
      setState(() {
        _image = File(image!.path);
      });
    });
  }

  // set old data in vars

  setdataolddata() {
    _fullnameController.text = "${Constants.prefs?.getString('name')}";
    _emailController.text = "${Constants.prefs?.getString('email')}";

    _mobileController.text = "${Constants.prefs?.getString('mobile')}";

    print("------------------------ ${Constants.prefs?.getString('dob')}");
    if (Constants.prefs?.getString('dob') != "null") {
      _dobController.text =
          "${Constants.prefs?.getString('dob').toString().split(" ").first.toString()}";
      dobDateTime = DateTime.parse(
          "${Constants.prefs?.getString('dob').toString().split(" ").first.toString()}");
      dob =
          "${Constants.prefs?.getString('dob').toString().split(" ").first.toString()}";
    }

    print(dob);

    if (Constants.prefs?.getString('gender') != "null") {
      _genderController.text = "${Constants.prefs?.getString('gender')}";
    } else {
      _genderController.text =
          "${getTranslated(context, "genderHint")}"; //Strings.genderHint;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setdataolddata();
    super.didChangeDependencies();
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
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      left: size.width * 0.05, top: size.height * 0.025),
                  child: Icon(
                    Icons.arrow_back,
                    size: size.width * 0.06,
                    color: AppColors.white,
                  )),
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

                    Center(
                      child: Text(
                        "${getTranslated(context, "myprofile")}",
                        // Strings.myprofile,
                        style: TextStyle(
                            fontSize: size.width * 0.088,
                            fontFamily: Fonts.abrilFatface,
                            color: Colors.white),
                      ),
                    ),

                    SizedBox(height: size.height * 0.05),

                    // profile Image

                    Stack(alignment: Alignment.center, children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.2,
                      ),
                      _image != null
                          ? CircleAvatar(
                              radius: size.width * 0.15,
                              backgroundColor: AppColors.white,
                              backgroundImage: FileImage(File(_image!.path)),
                            )

                          //AssetImage(_image!.path))
                          : CircleAvatar(
                              radius: size.width * 0.15,
                              backgroundColor: AppColors.white,
                              backgroundImage: NetworkImage(
                                  "${Constants.prefs?.getString('profileImage') ?? Images.profileNetwork}"),
                            ),
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            _profilePickshowBottomSheet(context);
                          },
                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                                color: AppColors.siginbackgrond,
                                shape: BoxShape.circle),
                            child: Center(
                                child: Icon(
                              Icons.add,
                              size: size.width * 0.06,
                              color: Colors.white,
                            )),
                          ),
                        ),
                      )
                    ]),

                    SizedBox(
                      height: size.height * 0.04,
                    ),

                    // full name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // name
                        inputs(
                            context: context,
                            controller: _fullnameController,
                            obscureTextBool: false,
                            titletxt:
                                "${getTranslated(context, "fullname")}", // Strings.fullname,
                            hinttxt:
                                "${getTranslated(context, "fullnamehint")}", //Strings.fullnamehint,
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
                            inputError: "",
                            ontapFun: null,
                            readonly: true),

                        // mobile

                        inputs(
                            context: context,
                            controller: _mobileController,
                            obscureTextBool: false,
                            titletxt:
                                "${getTranslated(context, "email")}", // Strings.email,
                            hinttxt:
                                "${getTranslated(context, "emailHint")}", // Strings.emailHint,
                            inputError: "",
                            ontapFun: null,
                            readonly: false),

                        // Container(
                        //     margin: EdgeInsets.only(top: size.height * 0.015),
                        //     child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             Strings.email,
                        //             style: TextStyle(
                        //                 fontFamily: Fonts.dmSansMedium,
                        //                 fontSize: size.width * 0.04,
                        //                 color: AppColors.inputTitle),
                        //           ),
                        //           SizedBox(
                        //             height: size.height * 0.01,
                        //           ),
                        //           roundedBox(
                        //             width: size.width,
                        //             height: size.height * 0.058,
                        //             backgroundColor: AppColors.inputbackgroung,
                        //             child: Padding(
                        //               padding: EdgeInsets.symmetric(
                        //                 horizontal: size.width * 0.04,
                        //               ),
                        //               child: Align(
                        //                 alignment: Alignment.center,
                        //                 child: TextField(
                        //                   readOnly: true,
                        //                   obscureText: false,
                        //                   controller: _emailController,
                        //                   style: TextStyle(
                        //                     fontFamily: Fonts.dmSansRegular,
                        //                     color: Colors.black,
                        //                   ),
                        //                   keyboardType:
                        //                       TextInputType.emailAddress,
                        //                   cursorColor: AppColors.white,
                        //                   decoration: InputDecoration(
                        //                     hintText: Strings.emailHint,
                        //                     border: InputBorder.none,
                        //                     hintStyle: TextStyle(
                        //                         color: AppColors.inputHint,
                        //                         fontSize: size.width * 0.04),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ])),

                        Constants.prefs?.getString('social') == "false"
                            ? inputs(
                                context: context,
                                controller: _dobController,
                                obscureTextBool: false,
                                titletxt:
                                    "${getTranslated(context, "dateofbirth")}", // Strings.dateofbirth,
                                hinttxt:
                                    "${getTranslated(context, "dobtypehint")}", // Strings.dobtypehint,
                                inputError: _dobError,
                                ontapFun: selectDate,
                                readonly: true)
                            : SizedBox(),
                        Constants.prefs?.getString('social') == "false"
                            ? inputs(
                                context: context,
                                controller: _genderController,
                                obscureTextBool: false,
                                titletxt:
                                    "${getTranslated(context, "gender")}", // Strings.gender,
                                hinttxt:
                                    "${getTranslated(context, "genderHint")}", //Strings.genderHint,
                                inputError: _genderError,
                                ontapFun: _showBottomSheetgender,
                                readonly: true)
                            : SizedBox(),

                        _signupError != ""
                            ? Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.01),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${getTranslated(context, "_signupError")}",
                                  // _signupError.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: Fonts.dmSansMedium,
                                      fontSize: size.width * 0.035),
                                ))
                            : SizedBox(),

                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        // update button
                        GestureDetector(
                          onTap: () {
                            print("update call");
                            update();
                          },
                          child: roundedBox(
                              // width: size.width * 0.78,
                              height: size.height * 0.058,
                              backgroundColor: AppColors.siginbackgrond,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${getTranslated(context, "update")}",
                                  // Strings.update,
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
      _loading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)))
          : SizedBox()
    ])));
  }
}
