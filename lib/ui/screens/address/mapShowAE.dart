import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funfy/apis/addressApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/models/addressLsitModel.dart';
import 'package:funfy/ui/screens/address/addressList.dart';
import 'package:funfy/ui/screens/address/map/searchInput.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:geocoding/geocoding.dart' as locationG;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/entities/localization_item.dart';
import 'package:place_picker/uuid.dart';
import 'package:place_picker/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// Place picker widget made with map widget from
/// [google_maps_flutter](https://github.com/flutter/plugins/tree/master/packages/google_maps_flutter)
/// and other API calls to [Google Places API](https://developers.google.com/places/web-service/intro)
///
/// API key provided should have `Maps SDK for Android`, `Maps SDK for iOS`
/// and `Places API`  enabled for it
class PlacePickerB extends StatefulWidget {
  /// API key generated from Google Cloud Console. You can get an API key
  /// [here](https://cloud.google.com/maps-platform/)
  final String apiKey;

  final int? typeAE;

  double? latE = 0.0;
  double? lngE = 0.0;

  final Addressdata? address;

  /// Location to be displayed when screen is showed. If this is set or not null, the
  /// map does not pan to the user's current location.
  final LatLng? displayLocation;
  LocalizationItem? localizationItem;

  PlacePickerB(this.apiKey,
      {this.displayLocation,
      @required this.typeAE,
      this.localizationItem,
      this.latE,
      this.lngE,
      this.address}) {
    if (this.localizationItem == null) {
      this.localizationItem = new LocalizationItem();
    }
  }

  @override
  State<StatefulWidget> createState() => PlacePickerBState();
}

/// Place picker state
class PlacePickerBState extends State<PlacePickerB> {
  final Completer<GoogleMapController> mapController = Completer();
  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();

  /// Indicator for the selected location
  final Set<Marker> markers = Set();

  /// Result returned after user completes selection
  LocationResult? locationResult;

  /// Overlay to display autocomplete suggestions
  OverlayEntry? overlayEntry;

  List<NearbyPlace> nearbyPlaces = [];

  /// Session token required for autocomplete API call
  String sessionToken = Uuid().generateV4();

  GlobalKey appBarKey = GlobalKey();

  bool hasSearchTerm = false;

  String previousSearchTerm = '';

  bool bottomSheetShow = false;
  TextEditingController addressController = TextEditingController();
  String addressError = "";
  String addressNameError = "";

  String zipCodeError = "";

  bool moovingTrue = false;

  TextEditingController addressNameController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  PanelController _pc = new PanelController();

  // constructor
  PlacePickerBState();

  void onMapCreated(GoogleMapController controller) {
    this.mapController.complete(controller);
    widget.typeAE != 2 ? moveToCurrentUserLocation() : print("Edit");
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  // Zip validation ---------- //

  onTypeZipCode(v) {
    if (v.length > 3) {
      print("Zip Code $v");
      Future.delayed(
          Duration(milliseconds: 700), zipApiCall(zip: v.toString()));
    }
  }

  zipApiCall({String? zip}) async {
    try {
      setState(() {
        _loadingL = true;
      });
      await checkValidZipApi(zipcode: zip).then((res) {
        setState(() {
          _loadingL = false;

          if (res == "true") {
            zipCodeError = "";

            zip = zipController.text;
          } else {
            zipCodeError = res!;
          }
        });
        print("Res - $res");
      });
    } catch (e) {
      setState(() {
        _loadingL = false;
      });
      print("error in zip $e");
    }
  }

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
      position: widget.typeAE == 2
          ? LatLng(widget.latE ?? 0.0, widget.lngE ?? 0.0)
          : widget.displayLocation ?? LatLng(5.6037, 0.1870),
      markerId: MarkerId("selected-location"),
    ));

    if (widget.typeAE == 2) {
      setAddressFromLatLng(widget.latE ?? 0.0, widget.lngE ?? 0.0);
    }
  }

  @override
  void dispose() {
    this.overlayEntry?.remove();
    super.dispose();
  }

  bool _loadingL = false;
  double slideSheetMinSize = 0.05;

  // address
  String street = "";
  String city = "";
  String stateA = "";
  String country = "";
  String zip = "";

  double latL = 0.0;
  double lngL = 0.0;

  // add and edit location funcs

  // validation

  formValid() async {
    addressError = "";
    addressNameError = "";

    setState(() {
      if (addressController.text.length == 0) {
        addressError = "${getTranslated(context, 'PleaseSelectLocation')}";
      }
      if (addressNameController.text.length == 0) {
        addressNameError =
            "${getTranslated(context, "pleaseEnterAddressname")}";
      }

      if (zipController.text.length == 0) {
        zipCodeError = "${getTranslated(context, "pleaseenterzipcode")}";
      }
    });

    if (addressController.text.length != 0 &&
        addressNameController.text.length != 0 &&
        zipCodeError == "" &&
        zipController.text.length != 0) {
      if (widget.typeAE == 1) {
        await zipApiCall(zip: zipController.text);
        if (zipCodeError == "") {
          addLocationFunc();
        }
      } else {
        await zipApiCall(zip: zipController.text);
        if (zipCodeError == "") {
          editLocationFunc();
        }
      }
    }
  }

  addLocationFunc() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var net = await Internetcheck.check();
    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loadingL = true;
      });
      try {
        await addAddressApi(
                addresname: addressNameController.text.toString(),
                street: street,
                city: city,
                state: stateA,
                zip: zipController.text.toString(),
                country: country,
                latitude: latL.toString(),
                longitude: lngL.toString())
            .then((value) {
          setState(() {
            _loadingL = false;
          });

          if (value!) {
            Dialogs.showBasicsFlash(
                context: context,
                color: Colors.green,
                duration: Duration(milliseconds: 1),
                content:
                    "${getTranslated(context, 'addresssuccessfullycreated')}");

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddressList(navNum: 0)));
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
          _loadingL = false;
        });
        Dialogs.showBasicsFlash(
            context: context,
            color: AppColors.siginbackgrond,
            duration: Duration(seconds: 1),
            content: "${getTranslated(context, 'errortoaddaddress')}");
      }
    }
  }

  editLocationFunc() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var net = await Internetcheck.check();
    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loadingL = true;
      });
      try {
        await updateaddAddressApi(
                id: "${widget.address?.id}",
                addresname: addressNameController.text.toString(),
                street: street,
                city: city,
                state: stateA,
                zip: zipController.text.toString(),
                country: country,
                latitude: widget.latE.toString(),
                longitude: widget.lngE.toString())
            .then((value) {
          setState(() {
            _loadingL = false;
          });

          if (value!) {
            Dialogs.showBasicsFlash(
                context: context,
                color: Colors.green,
                duration: Duration(milliseconds: 1),
                content:
                    "${getTranslated(context, 'addresssuccessfullyUpdated')}");

            navigatorPushFun(context, AddressList(navNum: 0));
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
          _loadingL = false;
        });
        Dialogs.showBasicsFlash(
            context: context,
            color: AppColors.siginbackgrond,
            duration: Duration(seconds: 1),
            content: "${getTranslated(context, 'errortoaddaddress')}");
      }
    }
  }

  bool drage = false;

  // set Address from lat lng

  setAddressFromLatLng(double ln, double lo) async {
    // if (widget.typeAE == 2) {
    // print("latlng==> $ln : $lo");
    // if (ln != 0.0) {
    List<locationG.Placemark> placemarks =
        await locationG.placemarkFromCoordinates(ln, lo);
    print("place marke $placemarks");

    var placemark = placemarks[0];

    String address =
        "${placemark.street}, ${placemark.locality},${placemark.administrativeArea}, ${placemark.country}";

    setState(() {
      if (widget.typeAE == 2) {
        addressNameController.text = widget.address!.name.toString();

        zipController.text = widget.address!.zip.toString();
      } else {
        print("Edit");
      }

      if (drage == true || widget.typeAE != 2) {
        zipController.text = placemark.postalCode.toString();
      }
      street = placemark.street.toString();
      city = placemark.locality.toString();
      stateA = placemark.administrativeArea.toString();
      // zip = placemark.postalCode.toString();
      // zipController.text = "000000";
      country = placemark.country.toString();

      _pc.open();
      addressController.text = address;
    });
    // }
    // }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (_pc.isPanelOpen) {
          _pc.close();
        } else {
          navigatePopFun(context);
        }

        return false;
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     _pc.open();
        //   },
        //   child: Icon(Icons.map),
        // ),
        appBar: AppBar(
          backgroundColor: AppColors.blackBackground,
          key: this.appBarKey,
          title: SearchInputB(searchPlace),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: <Widget>[
            // Expanded(
            //   child:

            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.typeAE == 2
                    ? LatLng(widget.latE ?? 0.0, widget.lngE ?? 0.0)
                    : widget.displayLocation ?? LatLng(5.6037, 0.1870),
                zoom: 15,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              onCameraIdle: () async {
                setAddressFromLatLng(latL, lngL);
                // clearOverlay();
                // moveToLocation(LatLng(latL, lngL));
                // setState(() {
                //   moovingTrue = false;
                // });
              },
              onCameraMove: (v) {
                if (drage == false) {
                  setState(() {
                    drage = true;
                  });
                }
                // setState(() {
                //   moovingTrue = true;
                // });
                // print("address : ${v.target.latitude}");
                latL = v.target.latitude;
                lngL = v.target.longitude;

                _pc.close();

                // setAddressFromLatLng(v.target.latitude, v.target.longitude);
              },
              onTap: (latLng) async {
                latL = latLng.latitude;
                lngL = latLng.longitude;

                clearOverlay();
                moveToLocation(latLng);
                setAddressFromLatLng(latLng.latitude, latLng.longitude);
              },
              markers: markers,
            ),

            moovingTrue
                ? Center(
                    child: Icon(
                    Icons.push_pin,
                    color: Colors.black,
                  ))
                : SizedBox(),

            // Sliding Up
            SlidingUpPanel(
              controller: _pc,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.width * 0.05),
                  topRight: Radius.circular(size.width * 0.05)),
              minHeight: size.height * 0.05,
              panel: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.06),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.width * 0.05),
                          topRight: Radius.circular(size.width * 0.05)),
                      color: AppColors.blackBackground,
                    ),
                    child: Column(
                      children: [
                        roundedBoxR(
                            height: size.height * 0.008,
                            width: size.width * 0.3,
                            radius: size.width * 0.2,
                            backgroundColor: Colors.grey),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        inputF(
                          context: context,
                          type: TextInputType.text,
                          ontype: null,
                          controller: addressController,
                          title: "${getTranslated(context, 'yourLocation')}",
                          hint:
                              "${getTranslated(context, 'hereisYourLocation')}",
                          error: addressError,
                        ),

                        // pincode
                        inputF(
                          context: context,
                          type: TextInputType.number,
                          controller: zipController,
                          inputFormatterss: [
                            LengthLimitingTextInputFormatter(12),
                          ],
                          ontype: onTypeZipCode,
                          title: "${getTranslated(context, 'zipcode')}",
                          hint: "${getTranslated(context, 'enterZipCode')}",
                          error: zipCodeError,
                        ),
                        inputF(
                          type: TextInputType.text,
                          context: context,
                          ontype: null,
                          controller: addressNameController,
                          title: "${getTranslated(context, 'addressName')}",
                          hint: "${getTranslated(context, 'enterAddressname')}",
                          error: addressNameError,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        InkWell(
                          onTap: () {
                            formValid();
                          },
                          child: roundedBoxR(
                              height: size.height * 0.065,
                              radius: size.width * 0.02,
                              backgroundColor: AppColors.siginbackgrond,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${getTranslated(context, 'saveLocation')}",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  _loadingL
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    if (this.overlayEntry != null) {
      this.overlayEntry!.remove();
      this.overlayEntry = null;
    }
  }

  /// Begins the search process by displaying a "wait" overlay then
  /// proceeds to fetch the autocomplete list. The bottom "dialog"
  /// is hidden so as to give more room and better experience for the
  /// autocomplete list overlay.
  void searchPlace(String place) {
    // on keyboard dismissal, the search was being triggered again
    // this is to cap that.
    if (place == this.previousSearchTerm) {
      return;
    }

    previousSearchTerm = place;

    if (context == null) {
      return;
    }

    clearOverlay();

    setState(() {
      hasSearchTerm = place.length > 0;
    });

    if (place.length < 1) {
      return;
    }

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final RenderBox? appBarBox =
        this.appBarKey.currentContext!.findRenderObject() as RenderBox?;

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarBox!.size.height,
        width: size.width,
        child: Material(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              children: <Widget>[
                SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 3)),
                SizedBox(width: 24),
                Expanded(
                    child: Text(widget.localizationItem!.findingPlace,
                        style: TextStyle(fontSize: 16)))
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(this.overlayEntry!);

    autoCompleteSearch(place);
  }

  /// Fetches the place autocomplete list with the query [place].
  void autoCompleteSearch(String place) async {
    try {
      place = place.replaceAll(" ", "+");

      var endpoint =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
          "key=${widget.apiKey}&"
          "language=${widget.localizationItem!.languageCode}&"
          "input={$place}&sessiontoken=${this.sessionToken}";

      if (this.locationResult != null) {
        endpoint += "&location=${this.locationResult!.latLng!.latitude}," +
            "${this.locationResult!.latLng!.longitude}";
      }

      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['predictions'] == null) {
        throw Error();
      }

      List<dynamic> predictions = responseJson['predictions'];

      List<RichSuggestion> suggestions = [];

      if (predictions.isEmpty) {
        AutoCompleteItem aci = AutoCompleteItem();
        aci.text = widget.localizationItem!.noResultsFound;
        aci.offset = 0;
        aci.length = 0;

        suggestions.add(RichSuggestion(aci, () {}));
      } else {
        for (dynamic t in predictions) {
          final aci = AutoCompleteItem()
            ..id = t['place_id']
            ..text = t['description']
            ..offset = t['matched_substrings'][0]['offset']
            ..length = t['matched_substrings'][0]['length'];

          suggestions.add(RichSuggestion(aci, () {
            FocusScope.of(context).requestFocus(FocusNode());
            decodeAndSelectPlace(aci.id);
          }));
        }
      }

      displayAutoCompleteSuggestions(suggestions);
    } catch (e) {
      print(e);
    }
  }

  /// To navigate to the selected place from the autocomplete list to the map,
  /// the lat,lng is required. This method fetches the lat,lng of the place and
  /// proceeds to moving the map to that location.
  void decodeAndSelectPlace(String? placeId) async {
    clearOverlay();

    try {
      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/details/json?key=${widget.apiKey}&" +
              "language=${widget.localizationItem!.languageCode}&" +
              "placeid=$placeId");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['result'] == null) {
        throw Error();
      }

      final location = responseJson['result']['geometry']['location'];
      moveToLocation(LatLng(location['lat'], location['lng']));
    } catch (e) {
      print(e);
    }
  }

  /// Display autocomplete suggestions with the overlay.
  void displayAutoCompleteSuggestions(List<RichSuggestion> suggestions) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    final RenderBox? appBarBox =
        this.appBarKey.currentContext!.findRenderObject() as RenderBox?;

    clearOverlay();

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: appBarBox!.size.height,
        child: Material(elevation: 1, child: Column(children: suggestions)),
      ),
    );

    Overlay.of(context)!.insert(this.overlayEntry!);
  }

  /// Utility function to get clean readable name of a location. First checks
  /// for a human-readable name from the nearby list. This helps in the cases
  /// that the user selects from the nearby list (and expects to see that as a
  /// result, instead of road name). If no name is found from the nearby list,
  /// then the road name returned is used instead.
  String getLocationName() {
    if (this.locationResult == null) {
      return widget.localizationItem!.unnamedLocation;
    }

    for (NearbyPlace np in this.nearbyPlaces) {
      if (np.latLng == this.locationResult!.latLng &&
          np.name != this.locationResult!.locality) {
        this.locationResult!.name = np.name;
        return "${np.name}, ${this.locationResult!.locality}";
      }
    }

    return "${this.locationResult!.name}, ${this.locationResult!.locality}";
  }

  /// Moves the marker to the indicated lat,lng
  void setMarker(LatLng latLng) {
    // markers.clear();
    setState(() {
      markers.clear();
      markers.add(
          Marker(markerId: MarkerId("selected-location"), position: latLng));
    });
  }

  /// Fetches and updates the nearby places to the provided lat,lng
  void getNearbyPlaces(LatLng latLng) async {
    try {
      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
          "key=${widget.apiKey}&location=${latLng.latitude},${latLng.longitude}"
          "&radius=150&language=${widget.localizationItem!.languageCode}");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      this.nearbyPlaces.clear();

      for (Map<String, dynamic> item in responseJson['results']) {
        final nearbyPlace = NearbyPlace()
          ..name = item['name']
          ..icon = item['icon']
          ..latLng = LatLng(item['geometry']['location']['lat'],
              item['geometry']['location']['lng']);

        this.nearbyPlaces.add(nearbyPlace);
      }

      // to update the nearby places
      setState(() {
        // this is to require the result to show
        this.hasSearchTerm = false;
      });
    } catch (e) {
      //
    }
  }

  /// This method gets the human readable name of the location. Mostly appears
  /// to be the road name and the locality.
  void reverseGeocodeLatLng(LatLng latLng) async {
    try {
      final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?"
          "latlng=${latLng.latitude},${latLng.longitude}&"
          "language=${widget.localizationItem!.languageCode}&"
          "key=${widget.apiKey}");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      final result = responseJson['results'][0];

      setState(() {
        String? name,
            locality,
            postalCode,
            country,
            administrativeAreaLevel1,
            administrativeAreaLevel2,
            city,
            subLocalityLevel1,
            subLocalityLevel2;
        bool isOnStreet = false;
        if (result['address_components'] is List<dynamic> &&
            result['address_components'].length != null &&
            result['address_components'].length > 0) {
          for (var i = 0; i < result['address_components'].length; i++) {
            var tmp = result['address_components'][i];
            var types = tmp["types"] as List<dynamic>?;
            var shortName = tmp['short_name'];
            if (types == null) {
              continue;
            }
            if (i == 0) {
              // [street_number]
              name = shortName;
              isOnStreet = types.contains('street_number');
              // other index 0 types
              // [establishment, point_of_interest, subway_station, transit_station]
              // [premise]
              // [route]
            } else if (i == 1 && isOnStreet) {
              if (types.contains('route')) {
                name = (name ?? "") + ", $shortName";
              }
            } else {
              if (types.contains("sublocality_level_1")) {
                subLocalityLevel1 = shortName;
              } else if (types.contains("sublocality_level_2")) {
                subLocalityLevel2 = shortName;
              } else if (types.contains("locality")) {
                locality = shortName;
              } else if (types.contains("administrative_area_level_2")) {
                administrativeAreaLevel2 = shortName;
              } else if (types.contains("administrative_area_level_1")) {
                administrativeAreaLevel1 = shortName;
              } else if (types.contains("country")) {
                country = shortName;
              } else if (types.contains('postal_code')) {
                postalCode = shortName;
              }
            }
          }
        }
        locality = locality ?? administrativeAreaLevel1;
        city = locality;
        this.locationResult = LocationResult()
          ..name = name
          ..locality = locality
          ..latLng = latLng
          ..formattedAddress = result['formatted_address']
          ..placeId = result['place_id']
          ..postalCode = postalCode
          ..country = AddressComponent(name: country, shortName: country)
          ..administrativeAreaLevel1 = AddressComponent(
              name: administrativeAreaLevel1,
              shortName: administrativeAreaLevel1)
          ..administrativeAreaLevel2 = AddressComponent(
              name: administrativeAreaLevel2,
              shortName: administrativeAreaLevel2)
          ..city = AddressComponent(name: city, shortName: city)
          ..subLocalityLevel1 = AddressComponent(
              name: subLocalityLevel1, shortName: subLocalityLevel1)
          ..subLocalityLevel2 = AddressComponent(
              name: subLocalityLevel2, shortName: subLocalityLevel2);
      });
    } catch (e) {
      print(e);
    }
  }

  /// Moves the camera to the provided location and updates other UI features to
  /// match the location.
  void moveToLocation(LatLng latLng) {
    this.mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 15.0)),
      );
    });

    setMarker(latLng);

    reverseGeocodeLatLng(latLng);

    getNearbyPlaces(latLng);
  }

  void moveToCurrentUserLocation() {
    if (widget.displayLocation != null) {
      moveToLocation(widget.displayLocation!);
      return;
    }

    Location().getLocation().then((locationData) {
      LatLng target = LatLng(locationData.latitude!, locationData.longitude!);
      moveToLocation(target);
    }).catchError((error) {
      print(error);
    });
  }

  Widget inputF(
      {context,
      String? title,
      String? hint,
      String? error,
      ontype,
      inputFormatterss,
      type,
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
        TextField(
          style: TextStyle(color: AppColors.white),
          cursorColor: AppColors.white,
          controller: controller,
          enabled: enable,
          onChanged: (v) {
            if (ontype != null) {
              ontype(v);
            } else {}
          },
          keyboardType: type,
          inputFormatters: inputFormatterss ?? [],
          decoration: InputDecoration(
              fillColor: HexColor("#3e332b"),
              filled: true,
              errorText: error,
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    width: 1,
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.black)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              hintStyle: TextStyle(color: HexColor("#6c604e")),
              hintText: "$hint"),
        ),
      ],
    );
  }
}
