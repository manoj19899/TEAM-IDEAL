import 'package:dakshattendance/Model/SlipDetailsModel.dart';
import 'package:flutter/material.dart';

import '../AppConst/AppConst.dart';
import '../Model/employeeSlipModel.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/leaveModel.dart';
import 'package:http/http.dart' as http;

class SlipProvider extends ChangeNotifier{

  List<EmployeeSlip> slipList = [];
  bool isLoadingSlips = false;
  bool isLoadingDetails = false;
  late String userId;
   SlipDetails? sd;

  Future<void> getSlips() async {
    var url = AppConst.baseUrl + AppConst.manageemppayslipApi;
    var header = {"Content-Type": "application/json", "Accept": "*/*"};
    var body = {"emp_code": userId};

    try {
      isLoadingSlips = true;
      slipList.clear();
      notifyListeners();
      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        debugPrint('Slips --> ${response.body}');
        var res = jsonDecode(response.body);
        if (res['data'].isNotEmpty) {
          res['data'].forEach((e) {
            slipList.add(EmployeeSlip.fromJson(e));
          });
          notifyListeners();

        } else {
          Fluttertoast.showToast(msg: res['message']);
        }
        isLoadingSlips = false;
        notifyListeners();
      } else {
        debugPrint('http error code -->  ${response.statusCode}');
        isLoadingSlips = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoadingSlips = false;
      notifyListeners();
    }
  }
  Future<void> getSlipDetails(String id) async {
    var url = AppConst.baseUrl + AppConst.printemppayslipApi;
    var header = {"Content-Type": "application/json", "Accept": "*/*"};
    var body = {"printid": id};

    try {
      isLoadingDetails = true;
      sd=null;
      notifyListeners();
      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        debugPrint('Slips --> ${response.body}');
        var res = jsonDecode(response.body);
        // var res =response.body;
        print('888888888888888888');
        // print(res);
        if (res['data']!=null) {
          // res['data'].forEach((e) {
          sd= SlipDetails.fromJson(res['data']);
          // print('object');
          // });
          notifyListeners();

        } else {
          Fluttertoast.showToast(msg: res['success']);
        }
        isLoadingDetails = false;
        notifyListeners();
      } else {
        debugPrint('http error code -->  ${response.statusCode}');
        isLoadingDetails = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoadingDetails = false;
      notifyListeners();
    }
  }

}