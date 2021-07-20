import 'dart:convert';
import 'dart:io';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/fiestasmodel.dart';
import 'package:funfy/models/preFiestasModel.dart';
import 'package:funfy/models/prifiestasAlMxEx.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<FiestasModel?> fiestasPostGet() async {
  //print('token print here ---------  ${UserData.userToken}');

  // print('token print here ---------  ${headers.toString()}');
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };
  var res = await http.post(Uri.parse(Urls.fiestasPostUrl), headers: headers);

  print("Fiestas posts-----------------------");

  print(res.body);

  if (res.statusCode == 200) {
    return fiestasModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in fiestas");
  }
}

Future<PrefiestasModel?> prefiestasPostGet() async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };
  var res =
      await http.post(Uri.parse(Urls.preFiestasPostsUrl), headers: headers);

  print(res.body);

  if (res.statusCode == 200) {
    return prefiestasModelFromJson(res.body);
  } else if (res.statusCode == 422) {
    print("ERRRO IN THE API in prefiestas");
  }
}

Future<PrefiestasAlMxExModel?> prefiestasAlMxExApi(
    {String? id, String? categoriesName}) async {
  var headers = {
    'Authorization': 'Bearer ${UserData.userToken}',
  };

  Map body = {"id": id, "categories": categoriesName};
  var res = await http.post(Uri.parse(Urls.preFiestachildlistUrl),
      body: body, headers: headers);

  print(res.body);

  if (res.statusCode == 200) {
    return prefiestasAlMxExModelFromJson(res.body);
  } else {
    print("ERRRO IN THE API in prefiestas child");
  }
}
