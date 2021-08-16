import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:funfy/apis/signinApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/models/updateModel.dart';
import 'package:funfy/models/userModel.dart';
import 'package:funfy/ui/screens/home.dart';
import 'package:funfy/utils/Constants.dart';
import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<Map> signApiCall(
    {String? fullname,
    String? email,
    String? password,
    String? dob,
    String? gender,
    String? devicetype}) async {
  var body = {
    "name": fullname,
    "email": email,
    "password": password,
    "dob": dob,
    "gender": gender,
    "device_token": "test",
    "device_type": devicetype
  };

  var res = await http.post(Uri.parse(Urls.signUpUrl), body: body);

  var response = json.decode(res.body);
  print(response);

  if (response["status"] == true && response["code"] == 201) {
    var resp = response["data"]["user"];
    saveDataInshareP(
      name: resp["name"],
      email: resp["email"],
      dob: resp["dob"].toString(),
      gender: resp["gender"],
      profileImage: "",
      social: "false",
      token: response["data"]["token"],
    );

    return {"bool": true, "res": response};
  }

  return {"bool": false, "res": response};
}

var headers = {
  'Accept': 'application/json',
  'Authorization': 'Bearer ${UserData.userToken}',
};

Future<UpdateProfileDataModel?> updateProfile(
    {String? name, String? gender, File? imageFile, String? dob}) async {
  print("update profile");
  Map<String, String>? body;

  if (Constants.prefs?.getString("social") == "false") {
    body = {
      "name": name!,
      "dob": dob.toString(),
      "gender": gender!,
      "is_social": "0"
    };
  } else {
    body = {"name": name!, "is_social": "1"};
  }

  return await updateUserApi(
      auth: UserData.userToken, file: imageFile, params: body);
}

Future<UpdateProfileDataModel?> updateUserApi(
    {File? file, String? auth, Map<String, String>? params}) async {
  print(auth);
  final postUri = Uri.parse(Urls.updateProfileUrl);
  UpdateProfileDataModel dataModel;
  http.MultipartRequest request = http.MultipartRequest('POST', postUri);
  request.headers['Authorization'] = "Bearer $auth";
  request.fields.addAll(params!);
  // print(updateUrl.toString());
  if (file != null) {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'image', file.path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
  }
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200 || response.statusCode == 201) {
    print("${response.body}");
    return dataModel = updateProfileDataModelFromJson(response.body);

    // var map = Map<String, dynamic>.from(jsonData);
    // return UpdateUserData.fromJson(map);
    // return dataModel;
  } else {
    print(
        "THERE IS AN ERROR IN THE UPDATE USER PROFILE API WITH STATUS CODE ${response.statusCode}");
    print("${response.body}");
  }
}
