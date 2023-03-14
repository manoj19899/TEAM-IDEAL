import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/Model/SummaryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Model/leaveModel.dart';
import 'package:http/http.dart' as http;

class LeaveProvider extends ChangeNotifier {
  List<LeaveModel> leaves = [];
  bool isLoadingLeave = false;
  bool isApplyingLeave = false;
  bool isLoadingLeaveSummary = false;
  bool isLoadingRemLeave = false;
  String remainingLeave = '';
  late String userId;
  SummaryModel? summaryModel;

  Future<void> getLeaves() async {
    var url = AppConst.baseUrl + AppConst.getemployeeleaveshistoryApi;
    var header = {"Content-Type": "application/json", "Accept": "*/*"};
    var body = {"emp_code": userId};

    try {
      isLoadingLeave = true;
      leaves.clear();
      notifyListeners();
      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      debugPrint('Leaves --> ${response.body}');

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if (res['data'].isNotEmpty) {
          res['data'].forEach((e) {
            leaves.add(LeaveModel.fromJson(e));
          });
          debugPrint('last leave id ${leaves.first.id}');
          notifyListeners();
        } else {
          Fluttertoast.showToast(msg: res['message']);
        }
        isLoadingLeave = false;
        notifyListeners();
      } else {
        debugPrint('http error code -->  ${response.statusCode}');
        isLoadingLeave = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoadingLeave = false;
      notifyListeners();
    }
  }

  Future<void> addLeave({
    required String fromdt,
    required String todt,
    required String hf,
    required String lt,
    required String des,
    required File? file,
  }) async {
    var url = AppConst.baseUrl + AppConst.addleaveApi;
    var header = {"Content-Type": "application/json", "Accept": "*/*"};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    try {
      isApplyingLeave = true;
      notifyListeners();
      if (file != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', file.path));
      }
      request.fields['emp_code'] = userId.toString();
      request.fields['fromdt'] = fromdt.toString();
      request.fields['todt'] = todt.toString();
      request.fields['halfleave'] = hf.toString();
      request.fields['leavetype'] = lt.toString();
      request.fields['description'] = des.toString();
      request.headers.addAll(header);
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      print('result   addLeave--> ${request.url} ${request.fields}');
      print('result   addLeave--> $result');
      if (jsonDecode(result)['status'] == 'Success') {
        await getLeaves();

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          autoHide: Duration(seconds: 3),
          title: '\n\n${jsonDecode(result)['message']} \n',
          autoDismiss: true,
        ).show().then((value) => Get.back());
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 3),
          title: '\n\n${jsonDecode(result)['message']} \n',
          autoDismiss: true,
        ).show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isApplyingLeave = false;
    notifyListeners();
  }

  Future<void> deleteLeave(String id) async {
    var url = AppConst.baseUrl + AppConst.leavecancelApi;
    var header = {"Content-Type": "application/json", "Accept": "*/*"};
    var body = {"id": id};

    try {
      isLoadingLeave = true;
      notifyListeners();
      print('result   deleteLeave--> $url $body');
      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      print('result deleteLeave--> ${response.body}');
      if (jsonDecode(response.body)['status'] == 'Success') {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          autoHide: Duration(seconds: 3),
          title: '\n\n${jsonDecode(response.body)['message']} \n',
          autoDismiss: true,
        ).show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 3),
          title: '\n\n${jsonDecode(response.body)['message']} \n',
          autoDismiss: true,
        ).show();
      }
      isLoadingLeave = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      isLoadingLeave = false;
      notifyListeners();
    }
    await getLeaves();
  }

  Future<void> getRemainingLeaves(String type) async {
    var url = AppConst.baseUrl + AppConst.availableleaveApi;
    var header = {"Content-Type": "application/json", "Accept": "*/*"};
    var body = {"emp_code": userId, "leavetype": type};

    try {
      isLoadingRemLeave = true;
      notifyListeners();
      print('result   getRemainingLeaves--> $url $body');
      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        debugPrint('getRemainingLeaves $type --> ${response.body}');
        var res = jsonDecode(response.body);
        if (res['status'] == 'Success') {
          remainingLeave = res['totleave'].toString();
          notifyListeners();
        } else {
          Fluttertoast.showToast(msg: res['message']);
        }
        isLoadingRemLeave = false;
        notifyListeners();
      } else {
        debugPrint(
            'http getRemainingLeaves error code -->  ${response.statusCode}');
        isLoadingRemLeave = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoadingRemLeave = false;
      notifyListeners();
    }
  }

  Future<void> getLeaveSummary() async {
    var url = AppConst.baseUrl + AppConst.manageempleavesummaryreportApi;
    var header = {"Content-Type": "application/json", "Accept": "*/*"};
    var body = {"emp_code": userId};

    try {
      isLoadingLeaveSummary = true;
      notifyListeners();
      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      debugPrint('Summary --> ${response.body}');

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if (res['data'] != null) {
          summaryModel = (SummaryModel.fromJson(res['data']));
          notifyListeners();
        } else {
          Fluttertoast.showToast(msg: res['message']);
        }
        isLoadingLeaveSummary = false;
        notifyListeners();
      } else {
        debugPrint('http error code -->  ${response.statusCode}');
        isLoadingLeaveSummary = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoadingLeaveSummary = false;
      notifyListeners();
    }
  }
}
