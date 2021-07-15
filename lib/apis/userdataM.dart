import 'package:funfy/models/userModel.dart';
import 'package:funfy/utils/Constants.dart';

class UserData {
  static List<UserModel> user = [];
  static String termsofservice = "";
  static String privacypolicy = "";
  static var userToken = Constants.prefs?.getString("token");
  static Map facebookUserdata = {};
  static Map ticketcartMap = {};
}
