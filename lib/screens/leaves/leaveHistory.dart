import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dakshattendance/Model/leaveModel.dart';
import 'package:dakshattendance/provider/leaveProvider.dart';
import 'package:dakshattendance/screens/leaves/applyLeave.dart';
import 'package:dakshattendance/screens/leaves/summaryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AppConst/AppConst.dart';

class LeavesHistory extends StatefulWidget {
  const LeavesHistory({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<LeavesHistory> createState() => _LeavesHistoryState();
}

class _LeavesHistoryState extends State<LeavesHistory> {
  void init() async {
    Provider.of<LeaveProvider>(context, listen: false).userId = widget.userId;
    // Provider.of<LeaveProvider>(context, listen: false).userId ='3377';
    await Provider.of<LeaveProvider>(context, listen: false).getLeaves();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(
      builder: (context, lp, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Manage Leaves',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'popin', fontSize: 16),
            ),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            actions: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.to(SummaryPage(empCode: widget.userId));
                      },
                      child: Text(
                        'Summary',
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(ApplyLeave());
                      },
                      child: Text(
                        'Apply',
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: lp.isLoadingLeave
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : lp.leaves.isEmpty
                    ? Center(
                        child: Text('Leaves not available.'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: lp.leaves.length,
                              itemBuilder: (context, i) {
                                LeaveModel leave = lp.leaves[i];
                                DateTime fromDate =
                                    DateTime.parse(leave.fromdt!);
                                DateTime toDate = DateTime.parse(leave.todt!);
                                bool isHalfDay =
                                    leave.noOfDays == 0.5.toString()
                                        ? true
                                        : false;
                                String descr = '';
                                if (leave.description != null) {
                                  if (leave.description!.contains('<p>')) {
                                    // print(true);
                                    // print(leave.description!.split('<p>').last.split('</p>').first);
                                    descr = leave.description!
                                        .split('<p>')
                                        .last
                                        .split('</p>')
                                        .first;
                                  } else {
                                    descr = leave.description!;
                                  }
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   DateFormat('MMMM yyyy').format(fromDate),
                                    //   style: TextStyle(
                                    //       color: Colors.black38,
                                    //       fontFamily: 'popin',
                                    //       fontSize: 16),
                                    // ),
                                    // SizedBox(height: 1.h),
                                    Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black38),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  isHalfDay
                                                      ? "Half day leave"
                                                      : '${leave.noOfDays} days leaves',
                                                  style: TextStyle(
                                                    color: Colors.black38,
                                                    fontFamily: 'popin',
                                                    // fontSize: 16,
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.green
                                                          .withAlpha(50)),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                                  child: Text(
                                                    leave.status ?? '',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontFamily: 'popin',
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 3.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      DateFormat('dd MMM yyyy')
                                                          .format(fromDate),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'popin',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      ' to ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'popin',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      DateFormat('dd MMM yyyy')
                                                          .format(toDate),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'popin',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                if (DateTime.parse(
                                                        leave.fromdt!)
                                                    .isAfter(DateTime.now()))
                                                  GestureDetector(
                                                    onTap: () {
                                                      AwesomeDialog(
                                                        context: Get.context!,
                                                        dialogType:
                                                            DialogType.warning,
                                                        title:
                                                            'Are you sure to cancel?',
                                                        btnOkText: 'Yes',
                                                        btnCancelText: 'No',
                                                        btnCancelOnPress: () {},
                                                        btnOkOnPress: () async {
                                                          await lp.deleteLeave(
                                                              leave.id!);
                                                        },
                                                      ).show();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.red
                                                              .withAlpha(50)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 5),
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontFamily: 'popin',
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(height: 3.h),
                                            Table(
                                              // textDirection: TextDirection.RTL,
                                              defaultVerticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              border: TableBorder.all(
                                                width: 2.0,
                                                color: Colors.black38,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),

                                              children: [
                                                TableRow(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Days",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'popin',
                                                          fontSize: 16),
                                                      // textScaleFactor: 1,
                                                    ),
                                                  ),
                                                  Text(
                                                    "PL",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'popin',
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    "CL",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'popin',
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    "SL",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'popin',
                                                        fontSize: 16),
                                                  ),
                                                ]),
                                                TableRow(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      leave.noOfDays ?? '',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Text(
                                                    leave.pl ?? '',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    leave.cl ?? '',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    leave.sl ?? '',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ]),
                                              ],
                                            ),
                                            SizedBox(height: 3.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    descr,
                                                    maxLines: 50,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      // color: Colors.black87,
                                                      fontFamily: 'popin',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      // fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10.h),
                                                if (leave.image != null &&
                                                    leave.image != '')
                                                  GestureDetector(
                                                    onTap: () async {
                                                      bool canLunch =
                                                          await canLaunch(
                                                              '${AppConst.baseUrl}${leave.image}');
                                                      print(canLunch);
                                                      print(leave.image);
                                                      if (canLunch) {
                                                        await launch(
                                                            '${AppConst.baseUrl}${leave.image}');
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Could\'nt open url');
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.blue
                                                              .withAlpha(50)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                      child: Transform.rotate(
                                                        angle: -pi / 4,
                                                        child: Icon(
                                                          Icons
                                                              .attachment_rounded,
                                                          size: 15,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
          ),
        );
      },
    );
  }
}
