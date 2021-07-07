import 'package:funfy/utils/strings.dart';

emailvalid(email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  if (emailValid == true) {
    return true;
  }
  return false;
}

String validateName(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (!regExp.hasMatch(value)) {
    return Strings.namemustbeAtoZ;
  }
  return "";
}

String calculateAge(DateTime birthDate) {
  // DateTime birthDate = DateTime(1997, 10, 25);
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }

  if (age < 18) {
    return Strings.agemustbe18;
  }

  return "";
}
