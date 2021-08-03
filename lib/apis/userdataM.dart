import 'package:funfy/models/userModel.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';

class UserData {
  static List<UserModel> user = [];
  static String termsofservice = "";
  static String privacypolicy = "";
  static var userToken = Constants.prefs?.getString("token");
  static Map facebookUserdata = {};
  static Map ticketcartMap = {};
  static num totalTicketNum = 0;
  static num fiestastotalTicketNum = 0;
  static String preFiestasAlcoholCart = "";
  static Map preFiestasMixesTicketCart = {};
  static Map preFiestasExtrasTicketCart = {};
  static String preFiestasCartid = "";
  static bool returnV = false;

  static List tiketList = [
    {
      "image": Images.ticketImageSvg,
      "name": Strings.ticket,
      "description": Strings.ticketDescription,
      "price": 0.00 //"${widget.fiestasModel?.ticketPrice}"
    },
    {
      "image": Images.standardImageSvg,
      "name": Strings.standard,
      "description": Strings.standardDescription,
      "price": 0.00 //"${widget.fiestasModel?.ticketPrice}"
    },
    {
      "image": Images.vIPTableImageSvg,
      "name": Strings.vipTable,
      "description": Strings.vipTableDescription,
      "price": 0.00 //"${widget.fiestasModel?.ticketPrice}"
    }
  ];
}
