import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/apis/signupApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/inputvalid.dart';
import 'package:funfy/components/zeroadd.dart';
import 'package:funfy/ui/screens/auth/signin.dart';
import 'package:funfy/ui/widgets/inputtype.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';
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
  File? _image;

  String _fullnameError = "";
  String _emailError = "";
  String _passwordError = "";
  String _dobError = "";
  String _genderError = "";
  String _signupError = "";

  update() {
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
        _updateProfile();
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
                gender: "male",
                dob: dob,
                imageFile: _image)
            .then((response) {
          setState(() {
            _loading = false;
            saveDataInshareP(
                name: response?.data?.user?.name,
                email: response?.data?.user?.email,
                profileImage: response?.data?.user?.image,
                gender: response?.data?.user?.gender,
                social: "false");

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

        print(dob);
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
                    titletext.toString(),
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
            height: size.height * 0.25,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      gender = Strings.male;
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
                    Strings.male,
                    style: TextStyle(
                        fontFamily: Fonts.dmSansBold,
                        fontSize: size.width * 0.042),
                  ),
                ),

                ListTile(
                  onTap: () {
                    setState(() {
                      gender = Strings.female;
                      _genderController.text = gender;
                    });
                    Navigator.of(context).pop();
                  },
                  // leading: Icon(Icons.female),
                  leading: Icon(Icons.female),
                  title: Text(Strings.female,
                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          fontSize: size.width * 0.042)),
                ),

                ListTile(
                  onTap: () {
                    setState(() {
                      gender = Strings.other;
                      _genderController.text = gender;
                    });
                    Navigator.of(context).pop();
                  },
                  leading: Icon(Icons.female),
                  // leading: Icon(Icons.error),
                  title: Text(Strings.other,
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
                  title: Text(Strings.camera,
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
                    Strings.gallery,
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
    await _picker.getImage(source: cameraOrGallery).then((image) {
      setState(() {
        _image = File(image!.path);
      });
    });
  }

  // set old data in vars

  setdataolddata() {
    // Constants.prefs?.getString('profileImage');

    _fullnameController.text = "${Constants.prefs?.getString('name')}";
    _emailController.text = "${Constants.prefs?.getString('email')}";

    print("------------------------ ${Constants.prefs?.getString('dob')}");
    _dobController.text = Constants.prefs?.getString('dob') == "null"
        ? "0000-00-00"
        : "${Constants.prefs?.getString('dob')}";

    _genderController.text = "${Constants.prefs?.getString('gender')}";

    //_dobController.text = "0000-00-00";
  }

  @override
  void initState() {
    super.initState();
    setdataolddata();
    print("Image Link ---------------------- ");
    print(Constants.prefs?.getString('profileImage'));
    Constants.prefs?.getString('social');
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
                        Strings.myprofile,
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
                                  "${Constants.prefs?.getString('profileImage')}"),
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
                        Constants.prefs?.getString('social') == "false"
                            ? inputs(
                                context: context,
                                controller: _fullnameController,
                                obscureTextBool: false,
                                titletxt: Strings.fullname,
                                hinttxt: Strings.fullnamehint,
                                inputError: _fullnameError,
                                readonly: false,
                                ontapFun: null)
                            : Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.015),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Strings.fullname,
                                        style: TextStyle(
                                            fontFamily: Fonts.dmSansMedium,
                                            fontSize: size.width * 0.04,
                                            color: AppColors.inputTitle),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      roundedBox(
                                        width: size.width,
                                        height: size.height * 0.058,
                                        backgroundColor:
                                            AppColors.inputbackgroung,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.04,
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TextField(
                                              readOnly: true,
                                              obscureText: false,
                                              controller: _fullnameController,
                                              style: TextStyle(
                                                fontFamily: Fonts.dmSansRegular,
                                                color: Colors.black,
                                              ),
                                              keyboardType: TextInputType.text,
                                              cursorColor: AppColors.white,
                                              decoration: InputDecoration(
                                                hintText: Strings.fullnamehint,
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                    color: AppColors.inputHint,
                                                    fontSize:
                                                        size.width * 0.04),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])),
                        // inputs(
                        //     context: context,
                        //     controller: _emailController,
                        //     obscureTextBool: false,
                        //     titletxt: Strings.email,
                        //     hinttxt: Strings.emailHint,
                        //     inputError: _emailError,
                        //     ontapFun: null,
                        //     readonly: true),

                        Container(
                            margin: EdgeInsets.only(top: size.height * 0.015),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Strings.email,
                                    style: TextStyle(
                                        fontFamily: Fonts.dmSansMedium,
                                        fontSize: size.width * 0.04,
                                        color: AppColors.inputTitle),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  roundedBox(
                                    width: size.width,
                                    height: size.height * 0.058,
                                    backgroundColor: AppColors.inputbackgroung,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.04,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          readOnly: true,
                                          obscureText: false,
                                          controller: _emailController,
                                          style: TextStyle(
                                            fontFamily: Fonts.dmSansRegular,
                                            color: Colors.black,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          cursorColor: AppColors.white,
                                          decoration: InputDecoration(
                                            hintText: Strings.emailHint,
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.inputHint,
                                                fontSize: size.width * 0.04),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ])),

                        Constants.prefs?.getString('social') == "false"
                            ? inputs(
                                context: context,
                                controller: _dobController,
                                obscureTextBool: false,
                                titletxt: Strings.dateofbirth,
                                hinttxt: Strings.dobtypehint,
                                inputError: _dobError,
                                ontapFun: selectDate,
                                readonly: true)
                            : SizedBox(),
                        Constants.prefs?.getString('social') == "false"
                            ? inputs(
                                context: context,
                                controller: _genderController,
                                obscureTextBool: false,
                                titletxt: Strings.gender,
                                hinttxt: Strings.genderHint,
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

                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        // update button
                        GestureDetector(
                          onTap: () {
                            update();
                          },
                          child: roundedBox(
                              // width: size.width * 0.78,
                              height: size.height * 0.058,
                              backgroundColor: AppColors.siginbackgrond,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Strings.update,
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
