import 'package:flutter/material.dart';
import 'package:funfy/apis/addressApi.dart';
import 'package:funfy/apis/introApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/ui/screens/address/addressEdit.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:hexcolor/hexcolor.dart';

class AddressAdd extends StatefulWidget {
  const AddressAdd({Key? key}) : super(key: key);

  @override
  _AddressAddState createState() => _AddressAddState();
}

class _AddressAddState extends State<AddressAdd> {
  TextEditingController nameController = TextEditingController();
  String nameError = "";

  TextEditingController streetController = TextEditingController();
  String streetError = "";

  TextEditingController cityController = TextEditingController();
  String cityError = "";

  TextEditingController stateController = TextEditingController();
  String stateError = "";

  TextEditingController zipController = TextEditingController();
  String zipError = "";

  TextEditingController countryController = TextEditingController();
  String countryError = "";

  bool _loading = false;

  // validation

  formValid() {
    setState(() {
      nameError = "";
      streetError = "";
      cityError = "";
      stateError = "";
      countryError = "";
      zipError = "";

      if (nameController.text.length == 0) {
        nameError = "${getTranslated(context, 'pleaseEnterAddressname')}";
      }
      if (stateController.text.length == 0) {
        streetError = "${getTranslated(context, 'pleaseenterStreet')}";
      }
      if (cityController.text.length == 0) {
        cityError = "${getTranslated(context, 'pleaseenterCity')}";
      }
      if (stateController.text.length == 0) {
        stateError = "${getTranslated(context, 'pleaseenterState')}";
      }
      if (countryController.text.length == 0) {
        countryError = "${getTranslated(context, 'pleaseenterCountry')}";
      }
      if (zipController.text.length == 0) {
        zipError = "${getTranslated(context, 'pleaseenterzipcode')}";
      }

      if (nameController.text.length != 0 &&
          stateController.text.length != 0 &&
          cityController.text.length != 0 &&
          stateController.text.length != 0 &&
          countryController.text.length != 0) {
        addAddressApiCall();
      }
    });
  }

  addAddressApiCall() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var net = await Internetcheck.check();
    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        var introdata = await getIntrodata();
        await addAddressApi(
                addresname: nameController.text.toString(),
                street: streetController.text.toString(),
                city: cityController.text.toString(),
                state: stateController.text.toString(),
                zip: zipController.text.toString(),
                country: countryController.text.toString(),
                latitude: "18.89",
                longitude: "19.23")
            .then((value) {
          setState(() {
            _loading = false;
          });

          if (value!) {
            Dialogs.showBasicsFlash(
                context: context,
                color: Colors.green,
                duration: Duration(milliseconds: 1),
                content:
                    "${getTranslated(context, 'addresssuccessfullycreated')}");

            clearFeilds();
            navigatePopFun(context);
          } else {
            Dialogs.showBasicsFlash(
                context: context,
                color: AppColors.siginbackgrond,
                duration: Duration(seconds: 1),
                content: "${getTranslated(context, 'errortoaddaddress')}");
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
            content: "${getTranslated(context, 'errortoaddaddress')}");
      }
    }
  }

  clearFeilds() {
    nameController.clear();
    streetController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: HexColor("#3d322a"),
      backgroundColor: AppColors.blackBackground,
      appBar: AppBar(
        elevation: 1,
        shadowColor: AppColors.white,
        backgroundColor: AppColors.blackBackground,
        centerTitle: true,
        title: Text("${getTranslated(context, 'addressAdd')}"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        securityField(
                            context: context,
                            controller: nameController,
                            error: nameError,
                            title: "${getTranslated(context, 'addressName')}",
                            hint:
                                "${getTranslated(context, 'enterAddressname')}"),
                        securityField(
                            context: context,
                            controller: streetController,
                            error: streetError,
                            title: "${getTranslated(context, 'street')}",
                            hint: "${getTranslated(context, 'enterStreet')}"),
                        securityField(
                            context: context,
                            controller: cityController,
                            error: cityError,
                            title: "${getTranslated(context, 'city')}",
                            hint: "${getTranslated(context, 'enterCity')}"),
                        securityField(
                            context: context,
                            controller: stateController,
                            title: "${getTranslated(context, 'state')}",
                            error: stateError,
                            hint: "${getTranslated(context, 'enterState')}"),
                        securityField(
                            context: context,
                            controller: zipController,
                            error: stateError,
                            title: "${getTranslated(context, 'zipcode')}",
                            hint: "${getTranslated(context, 'enterZipCode')}"),
                        securityField(
                            context: context,
                            controller: countryController,
                            error: stateError,
                            title: "${getTranslated(context, 'country')}",
                            hint: "${getTranslated(context, 'enterCountry')}"),
                        InkWell(
                          onTap: () {
                            formValid();
                          },
                          child: roundedBox(
                              height: size.height * 0.08,
                              backgroundColor: AppColors.siginbackgrond,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("${getTranslated(context, 'save')}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                      fontSize: size.width * 0.045,
                                    )),
                              )),
                        )
                      ],
                    ))
              ],
            ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  // input field

  Widget securityField(
      {context, String? title, String? hint, String? error, controller}) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title",
            style: TextStyle(
                fontSize: size.width * 0.038, color: AppColors.white)),
        SizedBox(
          height: size.height * 0.008,
        ),
        TextFormField(
          style: TextStyle(color: AppColors.white),
          cursorColor: AppColors.white,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              fillColor: HexColor("#3e332b"),
              filled: true,
              errorText: error,
              border: InputBorder.none,
              hintStyle: TextStyle(color: HexColor("#6c604e")),
              hintText: "$hint"),
        ),
      ],
    );
  }
}
