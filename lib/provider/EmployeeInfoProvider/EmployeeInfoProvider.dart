import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/Model/ProfileModel.dart';
import 'package:dakshattendance/Model/ProfileModel.dart';
import 'package:dakshattendance/Model/WorkingFor.dart';
import 'package:dakshattendance/screens/ManageEmployees/ManageEmployees.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeInfoProvider extends ChangeNotifier {
  String tag = 'EmployeeInfoProvider';
  late String empId;
  late String empCode;

  ProfileData? profileData;
  bool approved = false;
  bool loadingProfileData = false;
  late SharedPreferences prefs;
  Future<void> getProfileData() async {
    var response;
    prefs = await SharedPreferences.getInstance();
    empId = prefs.getString('empId') ?? '';
    try {
      debugPrint('$tag getProfileData ');
      loadingProfileData = true;
      notifyListeners();
      Map<String, String> headers = {"Accept": "*/*"};
      var url = AppConst.baseUrl + AppConst.edit_profile + 'emp_id=${empId}';
      bool cacheExist =
          await APICacheManager().isAPICacheKeyExist('profileData');
      var res = await http.get(Uri.parse(url), headers: headers);
      debugPrint(
          '$tag getProfileData response ${res.request!.url} ${res.body}');
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['status'] == 'Success') {
          var data = jsonDecode(res.body)['data'];
          var cacheModel =
              APICacheDBModel(key: 'profileData', syncData: jsonEncode(data));
          await APICacheManager().addCacheData(cacheModel);
          response = cacheModel.syncData;
        } else {
          Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
        }
      }
      // // debugPrint("it's url getProfileData Hit  $response ");
      // } else {
      //   showNetWorkToast();
      //   if (cacheExist) {
      //     response =
      //         (await APICacheManager().getCacheData('profileData')).syncData;
      // //     debugPrint("it's getProfileData cache Hit $response");
      //   }
      // }
      response = jsonDecode(response);
      if (response != null) {
        profileData = (ProfileData.fromJson(response));

        profileData!.employee = profileData!.employee ?? Employee();
        empCode = profileData!.employee!.empCode ?? '';
        profileData!.documents = profileData!.documents ?? Documents();
        approved = profileData!.employee!.is_approved != null &&
            profileData!.employee!.is_approved == '0';
        initEducationsList(profileData!.eduDetail);
        initEmpDetailList(profileData!.empDetail);
        initRefEmergencyList((profileData!.refEmergengy != null &&
                profileData!.refEmergengy!.isNotEmpty)
            ? profileData!.refEmergengy
            : [RefEmergency(), RefEmergency()]);
        initrefPersonsList((profileData!.refPersons != null &&
                profileData!.refPersons!.isNotEmpty)
            ? profileData!.refPersons
            : [RefPersons(), RefPersons(), RefPersons()]);
        notifyListeners();
      }

      debugPrint('$tag getProfileData is_approved ${approved}');
    } catch (e) {
      // // debugPrint('e e e e e  getProfileData e e -> $e');
    }
    // debugPrint(
    //     'testing getProfileData  edu details------ >${response['edu_detail']} ');
    // debugPrint(
    //     'testing getProfileData  edu details------ >${profileData!.eduDetail} ');
    loadingProfileData = false;
    notifyListeners();
    // Navigator.push(Get.context!, MaterialPageRoute(builder: (context)=>ManageEmployees()));
  }

  List<MapEntry<String, TextEditingController>> form1controllers = [];

  bool loadingStates = false;
  List<String> states = [];
  Future<void> getStates() async {
    var response;
    try {
      loadingStates = true;
      notifyListeners();
      Map<String, String> headers = {"Accept": "*/*"};
      var url = AppConst.baseUrl + 'master.php?func_name=get_states';
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('states');
      notifyListeners();
      var res = await http.get(Uri.parse(url), headers: headers);
      // debugPrint('$tag getStates response ${res.request!.url} ${res.body}');
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['status'] == 'Success') {
          var data = jsonDecode(res.body)['data'];
          var cacheModel =
              APICacheDBModel(key: 'states', syncData: jsonEncode(data));
          await APICacheManager().addCacheData(cacheModel);
          response = cacheModel.syncData;
        } else {
          Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
        }
      }
      // debugPrint("it's url getStates Hit  $response ");
      response = jsonDecode(response);
      // debugPrint('$tag getStates total ${response} ${response.runtimeType}');
      states.clear();

      if (response != null && response is List) {
        states = List<String>.from(response);
        notifyListeners();
      }

      // debugPrint('$tag getStates total ${states.length}');
    } catch (e) {
      // debugPrint('e e e e e  getStates e e -> $e');
    }
    // debugPrint('testing getStates ------ >getStates ');
    loadingStates = false;
    notifyListeners();
  }

  ///principal Companies
  bool loadingCompanies = false;
  List<String> principalCompanies = [];
  Future<void> getPrincipalCompanies() async {
    var response;
    try {
      loadingCompanies = true;
      notifyListeners();
      Map<String, String> headers = {"Accept": "*/*"};
      var url =
          AppConst.baseUrl + 'master.php?func_name=get_principal_companies';
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('companies');
      notifyListeners();
      var res = await http.get(Uri.parse(url), headers: headers);
      // // debugPrint(
      //     '$tag getPrincipalCompanies response ${res.request!.url} ${res.body}');
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['status'] == 'Success') {
          var data = jsonDecode(res.body)['data'];
          var cacheModel =
              APICacheDBModel(key: 'companies', syncData: jsonEncode(data));
          await APICacheManager().addCacheData(cacheModel);
          response = cacheModel.syncData;
        } else {
          Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
        }
      }
      // debugPrint("it's url getPrincipalCompanies Hit  $response ");
      response = jsonDecode(response);
      // debugPrint(
      //     '$tag getPrincipalCompanies total ${response} ${response.runtimeType}');
      principalCompanies.clear();
      if (response != null && response is List) {
        principalCompanies = List<String>.from(response);
        notifyListeners();
      }

      // debugPrint(
      //     '$tag getPrincipalCompanies total ${principalCompanies.length}');
    } catch (e) {
      // debugPrint('e e e e e  getPrincipalCompanies e e -> $e');
    }
    // debugPrint('testing getPrincipalCompanies ------ >getPrincipalCompanies ');
    loadingCompanies = false;
    notifyListeners();
  }

  ///working for
  bool loadingWorkingFor = false;
  List<WorkingForModel> workingForCompanies = [];
  Future<void> getWorkingFor() async {
    var response;
    try {
      loadingWorkingFor = true;
      notifyListeners();
      Map<String, String> headers = {"Accept": "*/*"};
      var url =
          AppConst.baseUrl + 'master.php?func_name=get_company_working_for';
      bool cacheExist =
          await APICacheManager().isAPICacheKeyExist('workingFor');
      notifyListeners();
      var res = await http.get(Uri.parse(url), headers: headers);
      debugPrint('$tag getWorkingFor response ${res.request!.url} ${res.body}');
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['status'] == 'Success') {
          var data = jsonDecode(res.body)['data'];
          var cacheModel =
              APICacheDBModel(key: 'workingFor', syncData: jsonEncode(data));
          await APICacheManager().addCacheData(cacheModel);
          response = cacheModel.syncData;
        } else {
          Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
        }
      }
      // debugPrint("it's url getWorkingFor Hit  $response ");
      response = jsonDecode(response);
      // debugPrint(
      //     '$tag getWorkingFor total ${response} ${response.runtimeType}');
      if (response != null) {
        // debugPrint(
        //     '$tag getWorkingFor total response ${response.length} ${response.runtimeType}');

        List<Map<String, dynamic>>.from(response).forEach((element) {
          print(element);
          try {
            workingForCompanies.add(WorkingForModel.fromJson(element));
          } catch (e) {
            print('e $e');
          }
        });
        notifyListeners();
      }
      // debugPrint('$tag getWorkingFor total ${workingForCompanies.length}');
    } catch (e) {
      // debugPrint('e e e e e  getWorkingFor e e -> $e');
    }
    // debugPrint('testing getWorkingFor ------ >getWorkingFor ');
    loadingWorkingFor = false;
    notifyListeners();
  }

  ///working for
  bool loadingZones = false;
  List<String> zones = [];
  String? selectedState;
  String? selectedPC;
  String? selectedWorkingCompany;
  String? selectedZone;
  String? selectedAccStatus;
  Future<void> getZones() async {
    var response;
    try {
      loadingZones = true;
      zones.clear();
      notifyListeners();
      Map<String, String> headers = {"Accept": "*/*"};
      var url = AppConst.baseUrl +
          // 'master.php?func_name=get_zones&working_for=YJ FOODS PRIVATE LIMITED';
          'master.php?func_name=get_zones&working_for=$selectedWorkingCompany';
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('zones');
      notifyListeners();
      var res = await http.get(Uri.parse(url), headers: headers);
      debugPrint('$tag getZones response ${res.request!.url} ${res.body}');
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['status'] == 'Success') {
          var data = jsonDecode(res.body)['data'];
          var cacheModel =
              APICacheDBModel(key: 'zones', syncData: jsonEncode(data));
          await APICacheManager().addCacheData(cacheModel);
          response = cacheModel.syncData;
        } else {
          Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
        }
      }
      // debugPrint("it's url getWorkingFor Hit  $response ");
      response = jsonDecode(response);
      debugPrint('$tag getZones total ${response} ${response.runtimeType}');
      if (response != null) {
        response.forEach((element) {
          zones.add(element['zone_nm']);
        });
        notifyListeners();
      }
      debugPrint('$tag getZones total ${zones.length}');
    } catch (e) {
      debugPrint('e e e e e  getWorkingFor e e -> $e');
    }
    // debugPrint('testing getWorkingFor ------ >getWorkingFor ');
    loadingZones = false;
    notifyListeners();
  }

  ///Step 2
  List<List> fieldControl2 = [];
  List<SingleValueDropDownController> field2controllers = [];
  String? selectGender;
  String? interviewed;
  String? treatment;
  bool isUploadingField1andForm2 = false;
  Future<void> uploadField1andForm2Docs() async {
    var url = AppConst.baseUrl + AppConst.form1andForm2Upload;
    var header = {"Accept": "*/*"};

    try {
      isUploadingField1andForm2 = true;
      notifyListeners();
      var newData = {};
      print(form1controllers.length);
      for (var i = 0; i < form1controllers.length; i++) {

        newData.addIf(
            true, form1controllers[i].key, form1controllers[i].value.text);
      }
      newData.addIf(true, 'edit', profileData!.employee!.empCode ?? '');
      newData.addIf(true, 'state', selectedState ?? '');
      newData.addIf(true, 'principal_comp', selectedPC ?? '');
      newData.addIf(true, 'working_for', selectedWorkingCompany ?? '');
      newData.addIf(true, 'zone', selectedZone ?? '');
      newData.addIf(true, 'account_status', selectedAccStatus ?? '');
      newData.addIf(true, 'gender', selectGender ?? '');
      newData.addIf(true, 'interviewed', interviewed ?? '');
      newData.addIf(true, 'treatment', treatment ?? '');
      newData.forEach((key, value) {
        print('$key + $value');
      });
      print(
          'params   uploadField1andForm2Docs-->h ${url} ${jsonEncode(newData)}');

      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(newData));
      print(
          'result  got uploadField1andForm2Docs--> responseData ${response.body}');

      var responseData;
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
        print(
            'result   uploadField1andForm2Docs --> responseData $responseData');
        if (responseData['success']) {
          fieldControl2.clear();
          getProfileData();
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            autoHide: Duration(seconds: 3),
            title: '\n${responseData['message']} \n',
            autoDismiss: true,
          ).show();
        } else {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            autoHide: Duration(seconds: 3),
            title: '\n${responseData['message']} \n',
            autoDismiss: true,
          ).show();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isUploadingField1andForm2 = false;
    notifyListeners();
  }

  ///Step 3
  List<EducationBoxModel> educations = [];
  void initEducationsList(List<EduDetail>? list) {
    educations.clear();
    if (list != null && list.isNotEmpty) {
      list.forEach((detail) {
        educations.add(
          EducationBoxModel(
            id: detail.id ?? '',
            examPassed: detail.exampass ?? '',
            insName: detail.instnm ?? '',
            yearOfPass: detail.passyear ?? '',
            passPercentage: detail.passperc ?? '',
          ),
        );
      });
    }
  }

  void removeEdu(EducationBoxModel e) {
    educations.remove(e);
    notifyListeners();
  }

  bool isUploadingForm3 = false;

  Future<void> uploadField3() async {
    var url = AppConst.baseUrl + AppConst.form3Upload;
    var header = {"Accept": "*/*"};

    try {
      isUploadingForm3 = true;
      notifyListeners();
      var newData = [];
      print(educations.length);
      for (var i = 0; i < educations.length; i++) {
        newData.add({
          'exampass': educations[i].examPassed,
          'instnm': educations[i].insName,
          'passyear': educations[i].yearOfPass,
          'passperc': educations[i].passPercentage,
        });
      }
      var body = {
        'edit': profileData!.employee!.empCode,
        'data': newData,
      };
      print('result   uploadField3-->h ${url} ${jsonEncode(body)}');

      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      print('result  got uploadField3--> responseData ${response.body}');

      var responseData;
      responseData = jsonDecode(response.body);
      print('result   uploadField3 --> responseData $responseData');
      if (responseData['success']) {
        educations.clear();
        getProfileData();
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          autoHide: Duration(seconds: 3),
          title: '\n${responseData['message']} \n',
          autoDismiss: true,
        ).show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 3),
          title: '\n${responseData['message']} \n',
          autoDismiss: true,
        ).show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isUploadingForm3 = false;
    notifyListeners();
  }

  ///Step 4
  List<EmpDetail> employees = [];
  void initEmpDetailList(List<EmpDetail>? list) {
    employees.clear();
    if (list != null && list.isNotEmpty) {
      list.forEach((detail) {
        employees.add(detail);
      });
    }
  }

  void removeEmpDetail(EmpDetail e) {
    employees.remove(e);
    notifyListeners();
  }

  bool isUploadingForm4 = false;

  Future<void> uploadField4() async {
    var url = AppConst.baseUrl + AppConst.form4Upload;
    var header = {"Accept": "*/*"};

    try {
      isUploadingForm4 = true;
      notifyListeners();
      var newData = [];
      print(employees.length);
      for (var i = 0; i < employees.length; i++) {
        newData.add(
          {
            "prevorg": employees[i].prevorg,
            "prevpos": employees[i].prevpos,
            "prevsal": employees[i].prevsal,
            "reasonleave": employees[i].reasonleave,
            "periodofemp": employees[i].periodofemp
          },
        );
      }
      var body = {
        'edit': profileData!.employee!.empCode,
        'data': newData,
      };
      print('result   uploadField4-->h ${url} ${jsonEncode(body)}');

      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      print('result  got uploadField4--> responseData ${response.body}');

      var responseData;
      responseData = jsonDecode(response.body);
      print(
          'result   uploadField4 --> responseData $responseData  ${responseData['success']}  ${responseData['success'].runtimeType}');
      if (responseData['success']) {
        employees.clear();
        getProfileData();

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          autoHide: Duration(seconds: 3),
          title: '\n${responseData['message']} \n',
          autoDismiss: true,
        ).show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 3),
          title: '\n${responseData['message']} \n',
          autoDismiss: true,
        ).show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isUploadingForm4 = false;
    notifyListeners();
  }

  ///Step 4
  List<RefEmergency> emergencies = [];
  void initRefEmergencyList(List<RefEmergency>? list) {
    emergencies.clear();
    if (list != null && list.isNotEmpty) {
      list.forEach((detail) {
        emergencies.add(detail);
      });
    }
  }

  List<RefPersons> refPersons = [];
  void initrefPersonsList(List<RefPersons>? list) {
    refPersons.clear();
    if (list != null && list.isNotEmpty) {
      list.forEach((detail) {
        refPersons.add(detail);
      });
    }
  }

  bool isUploadingForm5 = false;

  Future<void> uploadField5() async {
    var url = AppConst.baseUrl + AppConst.form5Upload;
    var header = {"Accept": "*/*"};

    try {
      isUploadingForm5 = true;
      notifyListeners();

      var body = {
        "edit": empCode,
        "emergency": emergencies
            .map((e) => {
                  "emergname": e.emergname,
                  "emergrel": e.emergrel,
                  "emergno": e.emergno
                })
            .toList(),
        "references": refPersons
            .map((e) => {
                  "refname": e.refname,
                  "addconemail": e.addconemail,
                  "occupation": e.occupation,
                  "yrsofacq": e.yrsofacq
                })
            .toList(),
      };
      print('result   uploadField5-->h ${url} ${jsonEncode(body)}');

      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      print('result  got uploadField5--> responseData ${response.body}');

      var responseData;
      responseData = jsonDecode(response.body);
      print(
          'result   uploadField5 --> responseData $responseData  ${responseData['success']}  ${responseData['success'].runtimeType}');
      if (responseData['success']) {
        employees.clear();
        getProfileData();

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          autoHide: Duration(seconds: 3),
          title: '\n${responseData['message']} \n',
          autoDismiss: true,
        ).show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 3),
          title: '\n${responseData['message']} \n',
          autoDismiss: true,
        ).show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isUploadingForm5 = false;
    notifyListeners();
  }

  ///Step 6
  Map<String, String> fieldControl6 = {};
  bool isUploadingField6 = true;

  Future<void> pickFiles({required String field}) async {
    String fileName = '';

    File? file;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      fileName = file.path.split('/').last;
      print(' picked file $file');
      fieldControl6.addAll({field: file.path});
      print(fieldControl6);
    } else {
      // User canceled the picker
      print('could not pick file');
      print('could not pick file');
    }
  }

  Future<void> uploadField6Docs() async {
    var url = AppConst.baseUrl + AppConst.form6Upload;
    var header = {"Accept": "*/*"};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    try {
      isUploadingField6 = true;
      notifyListeners();
      // var data = {
      //   "id": "1",
      //   "emp_code": empCode,
      //   "esicupld": "",
      //   "form2upld": "",
      //   "form11upld": "",
      //   "tiplinfo": "",
      //   "tiplkit": empCode-IMG20230112100423.jpg",
      //   "panupld": "",
      //   "aadharupld": "",
      //   "cchqupld": "",
      //   "reletterupld": "",
      //   "pastcerupld": "",
      //   "passportupld": "",
      //   "addproofupld": ""
      // };
      fieldControl6.entries.forEach((doc) async {
        print('doc  $doc');
        request.files
            .add(await http.MultipartFile.fromPath(doc.key, doc.value));
      });
      request.fields['edit'] = empCode.toString();
      request.headers.addAll(header);
      print('result   addLeave--> ${request.url} ${request.fields}');
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      print('result   addLeave--> ${request.url} ${request.fields}');
      print('result   addLeave--> $result');
      if (jsonDecode(result)['success']) {
        fieldControl6.clear();
        getProfileData();
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          autoHide: Duration(seconds: 3),
          title: '\n${jsonDecode(result)['message']} \n',
          autoDismiss: true,
        ).show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 3),
          title: '\n${jsonDecode(result)['message']} \n',
          autoDismiss: true,
        ).show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isUploadingField6 = false;
    notifyListeners();
  }
}
