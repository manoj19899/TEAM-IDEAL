import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/model/login_model.dart';
import 'package:dakshattendance/provider/EmployeeInfoProvider/EmployeeInfoProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppConst/AppConst.dart';

class UserLoginApi {
  Future<LoginModel?> onUserLoginAPI(String userid, String password) async {
    try {
      // final uri = Uri.parse(AppConst.baseUrl +
      //     Config.login +
      //     'username=${userid}&' +
      //     'password=${password}');
      // print(uri);
      // final request = http.MultipartRequest(
      //   'POST',
      //   uri,
      // );
      //
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      };
      // request.headers.addAll(headers);
      // request.fields['username']=userid;
      // request.fields['password']=password;

      // final http.Response response = await http.Response.fromStream(
      //   await request.send(),
      // );
      var response = await http.post(Uri.parse(AppConst.baseUrl + Config.login),
          headers: headers,
          body: jsonEncode({'username': userid, 'password': password}));
      print(response.request!.url);
      print(response.body);
      dynamic responseJson;
      if (response.statusCode == 200) {
        print(response.statusCode);
        responseJson = json.decode(response.body);
        print(responseJson['status']);

        if (responseJson['status'] == 'Success') {
          var prefs = await SharedPreferences.getInstance();
          await prefs.setString('empId', responseJson['id']);
          Provider.of<EmployeeInfoProvider>(Get.context!, listen: false).empId =
              responseJson['id'];

          return LoginModel.fromJson(responseJson);
        } else {
          Loader().hideLoader(Get.context!);
          print(responseJson['status']);
          showpopDialog(Get.context!, 'Opps', responseJson['message']);
          // Fluttertoast.showToast(msg: responseJson['message']);
          return null;
        }
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
