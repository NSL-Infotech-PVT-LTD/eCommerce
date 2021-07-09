import 'dart:convert';
import 'dart:io';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<FiestasModel?> fiestasPostGet() async {
  // var headers = {
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  //   'Authorization': 'Bearer ${UserData.userToken}',
  // };

  var headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer ${UserData.userToken}"
  };
  var res = await http.get(Uri.parse(Urls.fiestasPostUrl), headers: headers);

  print("Fiestas posts-----------------------");

  print(res.body);

  if (res.statusCode == 200) {
    return fiestasModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in fiestas");
  }
}

Future<PrefiestasModel?> prefiestasPostGet() async {
  var res = await http.get(Uri.parse(Urls.preFiestasPostsUrl));

  if (res.statusCode == 200) {
    return prefiestasModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in prefiestas");
  }
}
