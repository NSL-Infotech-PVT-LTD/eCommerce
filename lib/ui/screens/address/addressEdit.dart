import 'package:flutter/material.dart';
import 'package:funfy/apis/addressApi.dart';
import 'package:funfy/apis/introApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/addressLsitModel.dart';
import 'package:funfy/ui/screens/address/addressList.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hexcolor/hexcolor.dart';

class AddressEdit extends StatefulWidget {
  final Addressdata? addressmodel;
  final double? lat;
  final double? lng;

  const AddressEdit(
      {Key? key,
      @required this.addressmodel,
      @required this.lat,
      @required this.lng})
      : super(key: key);

  @override
  _AddressEditState createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
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
  bool _edit = true;

  editFunc() {
    setState(() {
      _edit = true;
    });
  }

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

  // set address in input fieds

  setinputValues() async {
    print("address ---------------");

    print("lat ${widget.lat} lng ${widget.lng}");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.lat!, widget.lng!);
    var placemark = placemarks[0];

    print(placemark);

    String address =
        "${placemark.locality},${placemark.administrativeArea}, ${placemark.country}";

    print(address);

    setState(() {
      nameController.text = "${widget.addressmodel?.name}";
      streetController.text = placemark.street.toString();
      cityController.text = placemark.locality.toString();
      stateController.text = placemark.administrativeArea.toString();
      zipController.text = placemark.postalCode.toString();
      countryController.text = placemark.country.toString();
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
        await updateaddAddressApi(
                id: "${widget.addressmodel?.id}",
                addresname: nameController.text.toString(),
                street: streetController.text.toString(),
                city: cityController.text.toString(),
                state: stateController.text.toString(),
                zip: zipController.text.toString(),
                country: countryController.text.toString(),
                latitude: widget.lat.toString(),
                longitude: widget.lng.toString())
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
                    "${getTranslated(context, 'addresssuccessfullyUpdated')}");

            clearFeilds();
            navigatorPushFun(
                context,
                AddressList(
                  navNum: 0,
                ));
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
  void initState() {
    super.initState();
    // set value in input
    setinputValues();

    // nameController.text = "${widget.addressmodel?.name}";
    // streetController.text = "${widget.addressmodel?.streetAddress}";
    // cityController.text = "${widget.addressmodel?.city}";
    // stateController.text = "${widget.addressmodel?.state}";
    // zipController.text = "${widget.addressmodel?.zip}";
    // countryController.text = "${widget.addressmodel?.country}";
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
        title: Text(
            "${_edit ? getTranslated(context, 'addressEdit') : getTranslated(context, 'address')}"),
        actions: [
          // _edit
          //     ? SizedBox()
          //     : IconButton(
          //         onPressed: () {
          //           editFunc();
          //         },
          //         icon: Icon(Icons.edit))
        ],
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
                            error: zipError,
                            title: "${getTranslated(context, 'zipcode')}",
                            hint: "${getTranslated(context, 'enterZipCode')}"),
                        securityField(
                            context: context,
                            controller: countryController,
                            error: countryError,
                            title: "${getTranslated(context, 'country')}",
                            hint: "${getTranslated(context, 'enterCountry')}"),
                        _edit
                            ? InkWell(
                                onTap: () {
                                  formValid();
                                },
                                child: roundedBox(
                                    height: size.height * 0.08,
                                    backgroundColor: AppColors.siginbackgrond,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          "${getTranslated(context, 'update')}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                            fontSize: size.width * 0.045,
                                          )),
                                    )),
                              )
                            : SizedBox()
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
      {context,
      String? title,
      String? hint,
      String? error,
      controller,
      bool enable = true}) {
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
          enabled: enable,
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
