import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/model/approval_list_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../AppConst/AppConst.dart';

class ApprovalListProvider {
  Future<dynamic> onApprovalListAPI(
      String employeeid, int month, int year) async {
    try {
      final strURL = Uri.parse(AppConst.baseUrl +
          Config.approvalist +
          'employeeid=${employeeid}&month=$year-$month');

      final response = await http
          .get((strURL), headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      print(json.decode(response.body));

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        if (responseJson['status'] == 'Error') {
          Fluttertoast.showToast(msg: responseJson['message']);
        }
        responseJson['data'].forEach((e) {
          print(e['dateofattendance']);
        });
        print(strURL);
        return ApprovalListModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return ApprovalListModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final approvalListProvider = ApprovalListProvider();
