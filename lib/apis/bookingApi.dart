import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/fiestasBooking.dart';
import 'package:funfy/models/fiestasBookingListModel.dart';
import 'package:funfy/models/preFiestasListModel.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

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
  print("run ----------------");
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

Future preFiestaBookingApi({String? preFiestaID, String? quantity}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {};

  if (quantity != null) {
    body = {"pre_fiesta_id": preFiestaID, "quantity": quantity};
  } else {
    body = {"pre_fiesta_id": preFiestaID};
  }

  var res = await http.post(Uri.parse(Urls.preFiestasBookingUrl),
      body: body, headers: headers);

  print(res.body);

  var jsonBody = json.decode(res.body);

  return jsonBody;
}

Future<PreFiestasBookingListModel?> preFiestaBookingListApi() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var res = await http.post(Uri.parse(Urls.preFiestasBookingListUrl),
      headers: headers);

  if (res.statusCode == 200) {
    print("workking------------ ");
    return preFiestasBookingListModelFromJson(res.body);
  } else {
    // print(res.body);
  }
}
