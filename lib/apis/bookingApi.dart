import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/createcartPreFiestasModel.dart';
import 'package:funfy/models/fiestasBooking.dart';
import 'package:funfy/models/fiestasBookingListModel.dart';
import 'package:funfy/models/makePrefiestasmodel.dart';
import 'package:funfy/models/preFiestasBookingListModel.dart';
import 'package:funfy/models/preFiestasCartModel.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<FistaBooking?> fiestasBooking(
    {String? id,
    String? ticketcount,
    String? standardticketcount,
    String? vipticketcount}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  Map<String, String> body = {
    "fiesta_id": "$id",
    "ticket_price_standard":
        standardticketcount != null ? "$standardticketcount" : "0",
    "ticket_price_vip": vipticketcount != null ? "$vipticketcount" : "0",
    "ticket_price": ticketcount != null ? "$ticketcount" : "0"
  };

  var res = await http.post(Uri.parse(Urls.fiestasBookingUrl),
      body: body, headers: headers);

  final jsonRes = json.decode(res.body);

  var response = Map<String, dynamic>.from(jsonRes);

  if (res.statusCode == 201) {
    return FistaBooking.fromJson(response);
  } else {
    // print(res.body);
  }
}

// booking list show

Future<FiestasBookingList?> fiestasBookingList() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  // Map<String, String> body = {

  // };

  var res =
      await http.post(Uri.parse(Urls.fiestasBookingListUrl), headers: headers);

  final jsonRes = json.decode(res.body);

  var response = Map<String, dynamic>.from(jsonRes);

  if (res.statusCode == 200) {
    // print("newModle" + res.body);
    return FiestasBookingList.fromJson(response);
  } else {
    // print(res.body);
  }
}

Future<CreatePrefiestasCartModel> addproductinCartPrefiestas(
    {String? preFiestaID, String? quantity}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  // print("Bearer ${UserData.userToken}");
  var body = {};

  if (quantity != null) {
    body = {"pre_fiesta_id": preFiestaID, "quantity": quantity};
  } else {
    body = {"pre_fiesta_id": preFiestaID};
  }

  var res = await http.post(Uri.parse(Urls.preFiestasBookingUrl),
      body: body, headers: headers);

  print(res.body);

  CreatePrefiestasCartModel jsonBody =
      createPrefiestasCartModelFromJson(res.body); // .decode(res.body);

  return jsonBody;
}

Future<PreFiestasBookingListModel?> preFiestaBookingListApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var res = await http.post(Uri.parse(Urls.preFiestasBookingListUrl),
      headers: headers);

  if (res.statusCode == 200) {
    return preFiestasBookingListModelFromJson(res.body);
  } else {
    print(res.body);
    // print(res.body);
  }
}

// make Order ------------------- //

Future<MakeprefiestasOrderModel?> makeOrderApi(
    {String? cartId, String? addressId}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  DateTime datetime = DateTime.now();

  String date = DateFormat('yyyy-MM-dd').format(datetime);

  String time = DateFormat('kk:mm').format(datetime);

  var body = {
    "cart_id": cartId,
    "date": date,
    "time": time,
    "address_id": addressId
  };

  var res = await http.post(Uri.parse(Urls.makeOrderUrl),
      body: body, headers: headers);

  if (res.statusCode == 201) {
    return makeprefiestasOrderModelFromJson(res.body);
  } else {
    print("here is error ${res.body}");
  }
}

// prefiestas Order detail show ------------------- //

Future prefiestasShowOrderDetail({String? orderId}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  // print("token is here - ${UserData.userToken}");

  var body = {
    "id": orderId.toString(),
  };

  var res = await http.post(Uri.parse(Urls.preFiestasOrderItemDetail),
      body: body, headers: headers);

  if (res.statusCode == 200) {
    print(res.body);
    return res.body;
  } else {
    print("here is error ${res.body}");
  }
}

// get my prefiestas cart

Future<PrefiestasCartModel?> getPrefiestasCart() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var res =
      await http.post(Uri.parse(Urls.preFiestasGetCartUrl), headers: headers);

  if (res.statusCode == 200) {
    print("here is cart - ${res.body}");
    return prefiestasCartModelFromJson(res.body);
  } else {
    print("here is error ${res.body}");
  }
}
