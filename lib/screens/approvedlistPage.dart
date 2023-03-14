import 'dart:convert';
import 'package:dakshattendance/screens/checkin_screen.dart';
import 'package:dakshattendance/bloc/approval_list_bloc.dart';
import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/model/approval_list_model.dart';
import 'package:dakshattendance/shared_preference/pref_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../bloc/get_attendance_bloc.dart';

class ApprovedListPage extends StatefulWidget {
  final String? employeeid;
  final String? employeename;
  final String? tdate;
  final String? intime;
  final String? outtime;
  final String? requesttext;
  // final String doneMessage;
  ApprovedListPage({
    // required this.doneMessage,
    this.employeeid,
    this.employeename,
    this.tdate,
    this.intime,
    this.outtime,
    this.requesttext,
  });

  @override
  _ApprovedListPageState createState() => _ApprovedListPageState();
}

class _ApprovedListPageState extends State<ApprovedListPage> {
  String? currentdate;
  // TextEditingController _time = TextEditingController();
  // TextEditingController _messagetext = TextEditingController();

  var userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = json.decode(PrefObj.preferences!.get(PrefKeys.USERDATA));
    // approvalListBloc.approvalListSink(widget.employeeid!);
  }

  var formatter = new DateFormat('dd-MM-yyyy');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;
    }
    return _date;
  }

  late List<Future<dynamic>> ascending = [];
  var asc;

  bool loadingData = false;

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Connections State }   ${loadingData}');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff0082FF),
        onPressed: () async {
          // setState(() {});
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              // return CheckIn();
              return CheckIn(
                isBake: (value) {
                  approvalListBloc.approvalListSink(widget.employeeid!,
                      DateTime.now().month, DateTime.now().month);
                },
              );
            },
          ));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: Text(
          "View Approval List",
          style: AppBarStyle.textStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset("assets/images/homeBackground.png"),
          ),
          Column(
            children: [
              ViewApprovalListCalender(
                  employeeid: widget.employeeid!,
                  callBack: (loading) {
                    setState(() {
                      loadingData = loading;
                    });
                  }),
              Expanded(
                child:  StreamBuilder<ApprovalListModel>(
                        stream: approvalListBloc.approvalListStream,
                        builder: (context,
                            AsyncSnapshot<ApprovalListModel>
                                approvalListsnapshot) {
                          debugPrint(
                              'Connections State ${approvalListsnapshot.connectionState}   ${loadingData}');
                          if (approvalListsnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (!approvalListsnapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Color(0xffEE2B7A)),
                              ),
                            );
                            // child: CircularProgressIndicator(
                            //     valueColor: AlwaysStoppedAnimation(Color(0xffEE2B7A))))
                          }
                          // ascending = approvalListsnapshot as List<Future>;
                          //  asc = approvalListsnapshot.data!.data!.sort((a,b) => a.dateofattendance!.compareTo(b.));

                          return approvalListsnapshot.data!.data != null
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 43.0),
                                  child: ListView.separated(
                                    reverse: true,
                                    padding: EdgeInsets.only(
                                        top: 20.0, bottom: 20.0),
                                    itemCount: approvalListsnapshot
                                        .data!.data!.reversed.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                  color: AppColor.buttonColor2
                                                      .withOpacity(0.05),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Text(
                                                            "${approvalListsnapshot.data!.data![index].requesttext}"),
                                                      ),
                                                    ),
                                                    // Spacer(),
                                                    Center(
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Date",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff6F6C6C),
                                                              fontFamily:
                                                                  "popin",
                                                              fontSize: 10.sp),
                                                        ),
                                                        Text(
                                                          "${approvalListsnapshot.data!.data![index].dateofattendance}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "popin",
                                                              fontSize: 12.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Center(
                                                      child: approvalListsnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .intime ==
                                                                  '0.0' ||
                                                              approvalListsnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .intime ==
                                                                  '0:00'
                                                          ? Column(
                                                              children: [
                                                                Text(
                                                                    "Check Out",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'popin',
                                                                        fontSize:
                                                                            13)),
                                                                Text(
                                                                    "${approvalListsnapshot.data!.data![index].outtime}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'popin',
                                                                        fontSize:
                                                                            13)),
                                                              ],
                                                            )
                                                          : approvalListsnapshot
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .outtime ==
                                                                      '0.0' ||
                                                                  approvalListsnapshot
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .outtime ==
                                                                      '0:00'
                                                              ? Column(
                                                                  children: [
                                                                    Text(
                                                                        "Check In",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'popin',
                                                                            fontSize:
                                                                                13)),
                                                                    SizedBox(
                                                                        width:
                                                                            2),
                                                                    Text(
                                                                        "${approvalListsnapshot.data!.data![index].intime}",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'popin',
                                                                            fontSize:
                                                                                13)),
                                                                  ],
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    Text(
                                                                        "Check In/Out",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'popin',
                                                                            fontSize:
                                                                                13)),
                                                                    SizedBox(
                                                                        width:
                                                                            2),
                                                                    Text(
                                                                        "${approvalListsnapshot.data!.data![index].intime} / ${approvalListsnapshot.data!.data![index].outtime} ",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'popin',
                                                                            fontSize:
                                                                                13)),
                                                                  ],
                                                                ),
                                                    ),
                                                    Spacer(),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Status",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff6F6C6C),
                                                              fontFamily:
                                                                  "popin",
                                                              fontSize: 10.sp),
                                                        ),
                                                        Text(
                                                          " ${approvalListsnapshot.data!.data![index].isapproved}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "popin",
                                                              fontSize: 12.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 0.0,
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "${approvalListsnapshot.data!.message}",
                                    style: TextStyle(
                                        fontFamily: 'popin', fontSize: 13),
                                  ),
                                );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ViewApprovalListCalender extends StatefulWidget {
  const ViewApprovalListCalender(
      {Key? key, required this.employeeid, required this.callBack})
      : super(key: key);
  final String employeeid;
  final void Function(bool loading) callBack;

  @override
  State<ViewApprovalListCalender> createState() =>
      _ViewApprovalListCalenderState();
}

class _ViewApprovalListCalenderState extends State<ViewApprovalListCalender> {
  String? time;

  dynamic selectedIndex = 2;
  dynamic selectedIndex1;
  List Months = [
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
  ];
  var currentdate;
  String? chosenValue = '10';
  String? selectValue = '';
  var currentYear = DateTime.now().year;
  String finalDate = '';
  bool loadingList = false;
  var formatter = new DateFormat('MM');
  var formatter1 = new DateFormat('MMMM-dd-yyyy');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool isClick = true;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectValue = DateFormat.MMMM().format(DateTime(0, now.day));
    approvalListBloc.approvalListSink(
      widget.employeeid,
      now.month,
      now.year,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 250.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Stack(
            children: [
              SfDateRangePicker(
                // showActionButtons: true,
                monthFormat: "MMMM",
                allowViewNavigation: false,
                showNavigationArrow: true,
                view: DateRangePickerView.year,
                navigationMode: DateRangePickerNavigationMode.snap,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontFamily: "popin",
                  ),
                ),
                selectionMode: DateRangePickerSelectionMode.single,
                selectionColor: Color(0xff0082FF).withOpacity(0.6),
                selectionShape: DateRangePickerSelectionShape.circle,
                selectionRadius: 20,
                onSelectionChanged:
                    (DateRangePickerSelectionChangedArgs args) async {
                  final dynamic value = args.value;
                  print('value $value');

                  chosenValue = formatter.format(value);
                  print(chosenValue);

                  ///
                  setState(() {
                    isClick = false;
                    currentdate == formatter.format(value)
                        ? isClick = true
                        : isClick = false;
                  });

                  ///
                  widget.callBack(true);
                  setState(() {
                    loadingList = true;
                  });
                  await approvalListBloc.approvalListSink(
                    widget.employeeid,
                    int.parse(chosenValue!),
                    int.parse(value.toString().split('-').first),
                  );
                  currentdate = formatter.format(fromDate);
                  print(currentdate);
                  isClick == false ? print("Hello") : print("Byyy");
                  setState(() {
                    loadingList = false;
                  });
                  widget.callBack(false);
                },
                onViewChanged: (DateRangePickerViewChangedArgs args) {
                  final PickerDateRange visibleDates = args.visibleDateRange;
                  final DateRangePickerView view = args.view;
                },
                onSubmit: (test) {
                  print(test);
                },
                yearCellStyle: DateRangePickerYearCellStyle(
                  disabledDatesDecoration: BoxDecoration(
                      color: const Color(0xFFDFDFDF),
                      border: Border.all(color: Colors.black, width: 1),
                      shape: BoxShape.circle),
                  disabledDatesTextStyle: const TextStyle(color: Colors.black),
                  leadingDatesDecoration: BoxDecoration(
                      color: const Color(0xFFDFDFDF),
                      border: Border.all(color: Colors.black, width: 1),
                      shape: BoxShape.circle),
                  leadingDatesTextStyle: const TextStyle(color: Colors.black),
                  textStyle: const TextStyle(color: Colors.black),
                  todayCellDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: isClick == true
                        ? Color(0xff0082FF).withOpacity(0.6)
                        : Colors.transparent,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  todayTextStyle: const TextStyle(color: Colors.black),
                ),
              ),
              if (loadingList)
                Container(
                  color: Colors.grey.withOpacity(0.05),
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 30,
                        color: Colors.black.withOpacity(1)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
