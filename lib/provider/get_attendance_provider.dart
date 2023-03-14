import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/model/get_attendance_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../AppConst/AppConst.dart';

class GetAttendanceProvider {
  Future<GetAttendanceModel?> onGetAttendanceAPI(
      String employeeid, String year, String month) async {
    try {
      print('month is $year-$month');
      final strURL = Uri.parse(AppConst.baseUrl +
          Config.getattendance +
          'employeeid=${employeeid}&' +
          'year=${year}&' +
          'month=${month}');
      print(strURL);

      // https: //monalisaedc.com/hrms/emp-backend/getattendanceapi.php?employeeid=3377&year=2021&month=6

      final response =
          await http.get(strURL, headers: {'content-Type': 'application/json'});
      debugPrint('View Attendance response ${response.body}');
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetAttendanceModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return GetAttendanceModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final getAttendanceProvider = GetAttendanceProvider();
