import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<String> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  print("lacation");

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  var placemark = placemarks[0];

  String address =
      "${placemark.locality},${placemark.administrativeArea}, ${placemark.country}";

  print(address);

  print(placemark);

  return address;
}
