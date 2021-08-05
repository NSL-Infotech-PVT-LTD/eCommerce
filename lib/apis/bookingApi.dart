import 'dart:convert';

import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/createcartPreFiestasModel.dart';
import 'package:funfy/models/fiestasBooking.dart';
import 'package:funfy/models/fiestasBookingListModel.dart';
import 'package:funfy/models/fiestasDetailmodel.dart';
import 'package:funfy/models/makePrefiestasmodel.dart';
import 'package:funfy/models/preFiestasBookingListModel.dart';
import 'package:funfy/models/preFiestasCartModel.dart';
import 'package:funfy/models/prefiestasOrderDetailModel.dart';
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

Future addproductinCartPrefiestas(
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

  // print(res.body);

  var jsonBody = json.decode(res.body);

  print("here is json body cart $jsonBody");

  // CreatePrefiestasCartModel jsonBody =
  //     createPrefiestasCartModelFromJson(res.body); // .decode(res.body);
  if (res.statusCode == 200 || res.statusCode == 201) {
    return jsonBody;
  } else {
    return jsonBody;
  }
}

Future cartResetPrefiestas({
  String? preFiestaID,
  String? quantity,
}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  // print("Bearer ${UserData.userToken}");
  var body = {"pre_fiesta_id": preFiestaID, "quantity": quantity, "reset": "1"};

  var res = await http.post(Uri.parse(Urls.preFiestasBookingUrl),
      body: body, headers: headers);

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

Future<PrefiestasOrderDetailModel?> prefiestasShowOrderDetail(
    {String? orderId}) async {
  // String tok =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE1OWM2MzBmNWFmMjhkOGM5NWIwNDVhZTA5NThhZjA0MWMwOTAxMWY4NGIzMGJjNjhhNzhjZGI5YTAwZWViNTg0Nzc4YmNjZmNiODhlZGRmIn0.eyJhdWQiOiIxIiwianRpIjoiMTU5YzYzMGY1YWYyOGQ4Yzk1YjA0NWFlMDk1OGFmMDQxYzA5MDExZjg0YjMwYmM2OGE3OGNkYjlhMDBlZWI1ODQ3NzhiY2NmY2I4OGVkZGYiLCJpYXQiOjE2Mjc2NDg1OTUsIm5iZiI6MTYyNzY0ODU5NSwiZXhwIjoxNjU5MTg0NTk1LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.qi0Y9uK-BosCzq7nCs5VMNWuHSZx5XRhU0xJnM51-_XW8uQikUsX-eE1lcvXA681imCI7HOQ6_3Rvt8PosU0GUedl_X9VZRUQJyhv75LWjLh93QbayjTZk6P6THEfiGKYJhlERnE0ZrUBLX32tJvzbI0q8oTsZuEqGz-qqJ00HEZg_UYVp6AN4cereXb9qCQvcUYOxohZp3dhx889p2S_alq3PNyxTk4PjvYxWZznuPQmDcDTkadjEnjyLFiErUXgGn5WUZ_LeIZxd13dX4iUPzZ4AHQjz4nTNkP6zW8pfer3zXVcMlq3b-bPMd1k7Ov-0d0CYwBJwlvIT8Gr9oboZgh2h5sq9s0EV2_Zq0MKt45rw8rJovDRrBXqAB4VgS6ARhde1vy7_xYQVLW8_yrlZ5JpfWeh-3xG1MRQwullCWmwv5habNdI3Xjy3x87ckHex_qXbg51G-_5MyINso9DWbsBfFPZqBPiuA32lUC85YeFpnFj8zG_OpSSrmm-pVn-yzVDT8zMnVyg5CDNzvcI7Ku40OQOv0ApVKm5FKotXtd6YQN17UEHmH0JvSE_RzPouq_3GpkE5LCuem8rfMKG14TjyWR3cjkyaP0fvRZS9o-LLXfR77tHkzHoHUJX9XJLMY4yPievoJa2N6eshEz9uA3AqrjxZRi_cRHWuResJE";
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
    // print(res.body);
    return prefiestasOrderDetailModelFromJson(res.body);
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

// get fiestas by id

Future<FiestasDetailModel?> getFiestasbyId({String? fiestasID}) async {
  print("Api run ---------------- $fiestasID");
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  var body = {"id": "$fiestasID"};

  var res = await http.post(Uri.parse(Urls.fiestasGetByidUrl),
      body: body, headers: headers);

  if (res.statusCode == 200) {
    print("here is cart - ${res.body}");
    return fiestasDetailModelFromJson(res.body);
  } else {
    print("here is error ${res.body}");
  }
}
