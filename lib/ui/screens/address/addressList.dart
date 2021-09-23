import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/apis/addressApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/locationget.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/addressLsitModel.dart';

import 'package:funfy/ui/screens/address/mapShowAE.dart';

import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:location_permissions/location_permissions.dart';

class AddressList extends StatefulWidget {
  final int? navNum;

  const AddressList({Key? key, @required this.navNum}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  int? groupValue = -1;
  int? initvalue = 0;

  bool _loading = false;

  bool _edit = false;

  double lats = 0.0;
  double lngs = 0.0;

  AddressListModel? addressListModel;

  // _handleRadioValueChange(int? value) {
  //   setState(() {
  //     groupValue = value;
  //   });
  // }

  getAddresApiCall() async {
    var net = await Internetcheck.check();
    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        await getAddressList().then((value) {
          setState(() {
            _loading = false;
          });

          if (value?.data?.length == 0 || value == null) {
            setState(() {
              Constants.prefs?.setString("addres", '');
              Constants.prefs?.setString("addressId", '');
            });
          }

          if (value != null) {
            addressListModel = value;

            var data = value.data?.toList().reversed;

            addressListModel?.data = data?.toList();
          } else {
            Dialogs.showBasicsFlash(
                context: context,
                color: AppColors.siginbackgrond,
                duration: Duration(seconds: 1),
                content: "${getTranslated(context, 'errortoloading')}");
          }
        });
      } catch (e) {
        print("Here Creating error > $e");
        setState(() {
          _loading = false;
        });
        Dialogs.showBasicsFlash(
            context: context,
            color: AppColors.siginbackgrond,
            duration: Duration(seconds: 1),
            content: "${getTranslated(context, 'errortoloading')}");
      }
    }
  }

  // addAddress

  // getLatLong() {

  //   if (Constants.prefs?.getString("lat") != '' &&
  //       Constants.prefs?.getString("addres") != null) {
  //     lats = double.parse('${Constants.prefs?.getString("lat")}');
  //     lngs = double.parse('${Constants.prefs?.getString("lng")}');
  //   } else {
  //     determinePosition();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getAddresApiCall();
    // getLatLong();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
      ),
    );

    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(
                  pageIndexNum: 0,
                )));

        return false;
      },
      child: Scaffold(
          backgroundColor: AppColors.blackBackground,
          body: Column(
            children: [
              // appBar
              Container(
                width: size.width,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.homeTopBannerPng),
                        fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Home(
                                    pageIndexNum: 0,
                                  )));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        )),
                    Text(
                      "${getTranslated(context, 'chooseaplace')}",
                      style: TextStyle(
                          fontFamily: Fonts.dmSansBold,
                          color: AppColors.white,
                          fontSize: size.width * 0.05),
                    ),
                    addressListModel?.data?.length == 0 ||
                            addressListModel == null
                        ? SizedBox(
                            width: size.width * 0.13,
                          )
                        : _edit == false
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    _edit = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    roundedBoxBorder(
                                        context: context,
                                        radius: size.width * 0.025,
                                        backgroundColor: Colors.transparent,
                                        borderColor: AppColors.white,
                                        borderSize: size.width * 0.004,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.width * 0.008,
                                              horizontal: size.height * 0.012),
                                          child: Text(
                                            "${getTranslated(context, 'edit')}",
                                            style: TextStyle(
                                                fontFamily: Fonts.dmSansBold,
                                                color: AppColors.white,
                                                fontSize: size.width * 0.04),
                                          ),
                                        )),
                                    SizedBox(
                                      width: size.width * 0.04,
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(
                                width: size.width * 0.17,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _edit = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                    )),
                              )
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.025,
              ),

              // recent

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                  "${getTranslated(context, 'recent')?.toUpperCase()}",
                  style: TextStyle(
                      fontFamily: Fonts.dmSansMedium,
                      color: AppColors.descriptionfirst,
                      fontSize: size.width * 0.04),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),

              // current loaction
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02),
                width: size.width,
                height: size.height * 0.2,
                color: HexColor("#24211E"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => AddressAdd()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: size.width * 0.04,
                            // height: size.width * 0.04,
                            child: Image.asset(
                              "assets/pngicons/currentLocation.png",
                              width: size.width * 0.07,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context, 'currentLocation')}",
                                style: TextStyle(
                                    fontFamily: Fonts.dmSansBold,
                                    color: AppColors.siginbackgrond,
                                    fontSize: size.width * 0.048),
                              ),
                              Container(
                                width: size.width * 0.8,
                                child: Text(
                                  Constants.prefs?.getString("addres") !=
                                              null &&
                                          Constants.prefs
                                                  ?.getString("addres") !=
                                              ''
                                      ? "${Constants.prefs?.getString("addres")}"
                                      : "${getTranslated(context, "addLoacation")}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: Fonts.dmSansMedium,
                                      color: AppColors.descriptionfirst,
                                      fontSize: size.width * 0.038),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),

                    // divider

                    Divider(
                      color: AppColors.blackBackground,
                      thickness: size.height * 0.001,
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),

                    InkWell(
                      onTap: () async {
                        print("location....");
                        await LocationPermissions()
                            .requestPermissions()
                            .then((permission) {
                          print("value is here A$permission");

                          if (permission == PermissionStatus.denied) {
                            Dialogs.singleButtonAlertDialog(
                                context: context,
                                title: "${getTranslated(
                                  context,
                                  'alert!',
                                )}",
                                content: "${getTranslated(
                                  context,
                                  'AllowPermissionFromYourMobilesettings',
                                )}",
                                buttonContent: "${getTranslated(
                                  context,
                                  'goToPhoneSettings',
                                )}",
                                func: () async {
                                  Navigator.of(context).pop();
                                  bool isOpened = await LocationPermissions()
                                      .openAppSettings();
                                  print("here is bool $isOpened");
                                });
                          } else {
                            print("here is permission $permission");

                            // return Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) {
                            //   // return .
                            //
                            //   return PlacePickerB(
                            //     Strings.mapKey,
                            //     typeAE: 1,
                            //   );
                            // }));
                          }
                          return permission;
                        });
                      },
                      child: Row(
                        children: [
                          roundedBoxBorder(
                              context: context,
                              radius: size.width * 0.015,
                              backgroundColor: Colors.transparent,
                              borderColor: AppColors.white,
                              borderSize: size.width * 0.002,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 0.008,
                                    horizontal: size.height * 0.012),
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                      fontSize: size.width * 0.04),
                                ),
                              )),
                          SizedBox(width: size.width * 0.03),
                          Text(
                            "${getTranslated(context, 'addAddress')}",
                            style: TextStyle(
                                fontFamily: Fonts.dmSansBold,
                                color: AppColors.white,
                                fontSize: size.width * 0.048),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // others

              SizedBox(
                height: size.height * 0.025,
              ),

              // recent

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                  "${getTranslated(context, 'others')?.toUpperCase()}",
                  style: TextStyle(
                      fontFamily: Fonts.dmSansMedium,
                      color: AppColors.descriptionfirst,
                      fontSize: size.width * 0.04),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),

              Expanded(
                  child: _loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : addressListModel?.data?.length == 0 &&
                                  _loading == false ||
                              addressListModel == null
                          ? Center(
                              child: Text(
                                "${getTranslated(context, "listisEmpty")}",
                                //     Strings.PostsEmpty,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: size.width * 0.04),
                              ),
                            )
                          : ListView.builder(
                              itemCount: addressListModel?.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                var address = addressListModel?.data![index];
                                return addressIitem(
                                    size: size,
                                    address:
                                        "${address?.streetAddress}, ${address?.city}, ${address?.state}, ${address?.country}, ${address?.zip}",
                                    model: address);
                              }))
            ],
          )),
    ));
  }

  Widget addressIitem({size, String? address, Addressdata? model}) {
    return InkWell(
      onTap: () async {
        if (_edit) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PlacePickerB(
              Strings.mapKey,
              typeAE: 2,
              latE: double.parse("${model?.latitude}"),
              lngE: double.parse("${model?.longitude}"),
              address: model,
            );
          }));
        } else {
          print("location....");
          await LocationPermissions().requestPermissions().then((permission) {
            print("value is here A$permission");

            if (permission == PermissionStatus.denied) {
              Dialogs.singleButtonAlertDialog(
                  context: context,
                  title: "${getTranslated(
                    context,
                    'alert!',
                  )}",
                  content: "${getTranslated(
                    context,
                    'AllowPermissionFromYourMobilesettings',
                  )}",
                  buttonContent: "${getTranslated(
                    context,
                    'goToPhoneSettings',
                  )}",
                  func: () async {
                    Navigator.of(context).pop();
                    bool isOpened =
                        await LocationPermissions().openAppSettings();
                    print("here is bool $isOpened");
                  });
            } else {
              print("here is permission $permission");

              Dialogs.simpleAlertDialog(
                  context: context,
                  title: "${getTranslated(context, 'changeAddress')}",
                  content:
                      "${getTranslated(context, 'Dowanttoselectthisaddress')}",
                  func: () {
                    setState(() {
                      Constants.prefs?.setString("addres", "$address");
                      Constants.prefs?.setString("addressId", "${model?.id}");
                    });
                    navigatePopFun(context);
                    navigatorPushFun(
                        context,
                        Home(
                          pageIndexNum: 0,
                        ));
                  });
            }
            return permission;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.0025),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        width: size.width,
        height: size.height * 0.09,
        color: HexColor("#24211E"),
        child: Row(
          children: [
            // icon
            _edit
                ? InkWell(
                    onTap: () {
                      Dialogs.simpleAlertDialog(
                          context: context,
                          title: "${getTranslated(context, 'delete')}",
                          content:
                              "${getTranslated(context, 'Dowanttodeletethisaddress')}",
                          func: () {
                            navigatePopFun(context);
                            deleteAddressFun(id: model?.id.toString());
                          });
                    },
                    child: Container(
                      // width: size.width * 0.05,
                      // height: size.height * 0.03,
                      child: Image.asset(
                        "assets/pngicons/locationDelete.png",
                        width: size.width * 0.07,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    // width: size.width * 0.05,
                    // height: size.height * 0.03,
                    child: Image.asset(
                      "assets/pngicons/addBookMark.png",
                      width: size.width * 0.07,
                      fit: BoxFit.cover,
                    ),
                  ),

            SizedBox(
              width: size.width * 0.03,
            ),

            Expanded(
              child: Text(
                "$address",
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontFamily: Fonts.dmSansMedium,
                    color: AppColors.white,
                    fontSize: size.width * 0.048),
              ),
            ),

            SizedBox(
              width: size.width * 0.08,
            ),

            Container(
              width: size.width * 0.05,
              height: size.height * 0.03,
              child: Icon(
                Icons.chevron_right,
                color: AppColors.white,
                size: size.width * 0.07,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future deleteAddressFun({String? id}) async {
    var net = await Internetcheck.check();
    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        print("Run --------------");
        await deleteAddress(id: id).then((value) {
          setState(() {
            _loading = false;
          });

          if (value!) {
            Dialogs.showBasicsFlash(
                context: context,
                color: Colors.green,
                duration: Duration(seconds: 1),
                content:
                    "${getTranslated(context, 'addresssuccessfullyDeleted')}");
            getAddresApiCall();
          } else {
            Dialogs.showBasicsFlash(
                context: context,
                color: AppColors.siginbackgrond,
                duration: Duration(seconds: 1),
                content: "${getTranslated(context, 'errortoloading')}");
          }
        });
      } catch (e) {
        print("Here Creating error > $e");
        setState(() {
          _loading = false;
        });
        Dialogs.showBasicsFlash(
            context: context,
            color: AppColors.siginbackgrond,
            duration: Duration(seconds: 1),
            content: "${getTranslated(context, 'errortoloading')}");
      }
    }
  }
}
