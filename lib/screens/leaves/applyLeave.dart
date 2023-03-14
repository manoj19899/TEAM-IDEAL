import 'dart:io';

import 'package:dakshattendance/provider/leaveProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApplyLeave extends StatefulWidget {
  const ApplyLeave({Key? key}) : super(key: key);

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  int selectedLeaveType = 0;
  String leaveTypeText = '';
  bool isHalfDay = false;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController desContoller = TextEditingController();
  String fileName = 'Choose File';
  File? file;

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      fileName = file!.path.split('/').last;
      setState(() {});
      print(' picked file $file');
    } else {
      // User canceled the picker
      print('could not pick file');
      print('could not pick file');
    }
  }

  void init() async {
    leaveTypeText = 'PL';
    await Provider.of<LeaveProvider>(context, listen: false)
        .getRemainingLeaves(leaveTypeText);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(builder: (context, lp, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Apply Leaves',
            style: TextStyle(color: Colors.black, fontFamily: 'popin'),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              )),
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                SizedBox(height: 10),
                SizedBox(
                  height: 50.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            selectedLeaveType = 0;
                            leaveTypeText = 'PL';
                          });
                          await lp.getRemainingLeaves(leaveTypeText);
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: selectedLeaveType != 0
                                  ? Colors.white
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PL',
                                    style: TextStyle(
                                      color: selectedLeaveType == 0
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'popin',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       'Total',
                                  //       style: TextStyle(
                                  //         color: Colors.blue,
                                  //         fontFamily: 'popin',
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.normal,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 5.h,
                                  //     ),
                                  //     Text('16 Leaves'),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.w),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            selectedLeaveType = 1;
                            leaveTypeText = 'CL';
                          });
                          await lp.getRemainingLeaves(leaveTypeText);
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: selectedLeaveType != 1
                                  ? Colors.white
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'CL',
                                    style: TextStyle(
                                      color: selectedLeaveType == 1
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'popin',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       'Total',
                                  //       style: TextStyle(
                                  //         color: Colors.blue,
                                  //         fontFamily: 'popin',
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.normal,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 5.h,
                                  //     ),
                                  //     Text('16 Leaves'),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.w),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            selectedLeaveType = 2;
                            leaveTypeText = 'SL';
                          });
                          await lp.getRemainingLeaves(leaveTypeText);
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: selectedLeaveType == 2
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SL',
                                    style: TextStyle(
                                      color: selectedLeaveType == 2
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'popin',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       'Total',
                                  //       style: TextStyle(
                                  //         color: Colors.blue,
                                  //         fontFamily: 'popin',
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.normal,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 5.h,
                                  //     ),
                                  //     Text('16 Leaves'),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.w),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text('Available Leave : ${lp.remainingLeave} '),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'popin',
                                fontSize: 16),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: fromDateController,
                                  decoration: InputDecoration(
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.calendar_month),
                                      onPressed: () async {
                                        var date = await showDatePicker(
                                            initialDate: DateTime.now(),
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(DateTime.now()
                                                .add(Duration(days: 1080))
                                                .year));
                                        if (date != null) {
                                          setState(
                                            () {
                                              fromDateController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date);
                                            },
                                          );
                                        }
                                        ;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 30.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'popin',
                                fontSize: 16),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: toDateController,
                                  decoration: InputDecoration(
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.calendar_month),
                                      onPressed: () async {
                                        var date = await showDatePicker(
                                            initialDate: DateTime.now(),
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(DateTime.now()
                                                .add(Duration(days: 1080))
                                                .year));
                                        if (date != null) {
                                          setState(
                                            () {
                                              toDateController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date);
                                            },
                                          );
                                        }
                                        ;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'popin',
                              fontSize: 16),
                        ),
                        Text(
                          '${desContoller.text.length}/1000',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'popin',
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: false,
                            controller: desContoller,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Half Day Leave',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'popin',
                              fontSize: 16),
                        ),
                        Checkbox(
                          onChanged: (val) async {
                            setState(() {
                              isHalfDay = val!;
                            });
                          },
                          value: isHalfDay,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Attachment',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'popin',
                              fontSize: 16),
                        ),
                        if (file == null)
                          IconButton(
                              onPressed: () async {
                                await pickFiles();
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                              )),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    if (file != null)
                      Builder(builder: (context) {
                        if (fileName.length < 16) {
                          fileName = fileName;
                        } else {
                          fileName = fileName.substring(0, 12) +
                              '...' +
                              fileName.substring(
                                  fileName.length - 6, fileName.length);
                        }
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                          ),
                          padding: EdgeInsets.only(left: 10.w),
                          child: Row(
                            children: [
                              Icon(Icons.attachment_rounded),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  fileName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'popin',
                                      fontSize: 16),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      file = null;
                                      fileName = 'Choose File';
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                if (fromDateController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please select start date');
                } else if (toDateController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please select end date');
                } else if (leaveTypeText.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please select leave type');
                } else if (desContoller.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please enter description');
                } else {
                  await lp.addLeave(
                      file: file,
                      fromdt: fromDateController.text,
                      todt: toDateController.text,
                      hf: isHalfDay ? '1' : '',
                      lt: leaveTypeText,
                      des: desContoller.text);
                }
              },
              child: lp.isApplyingLeave
                  ? CupertinoActivityIndicator()
                  : Text('Apply For Leave'),
            ),
          ),
        ),
      );
    });
  }
}
