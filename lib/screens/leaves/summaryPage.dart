import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/leaveProvider.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key, required this.empCode}) : super(key: key);
  final String empCode;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  void init() async {
    Provider.of<LeaveProvider>(context, listen: false).userId = widget.empCode;
    // Provider.of<LeaveProvider>(context, listen: false).userId ='3377';
    await Provider.of<LeaveProvider>(context, listen: false).getLeaveSummary();
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
            'Leave Summary Report',
            style: TextStyle(color: Colors.black, fontFamily: 'popin'),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [],
        ),
        body: lp.isLoadingLeaveSummary
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'PL',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Opening Balance'),
                                      Text(lp.summaryModel!.plopenbal ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Avlb '),
                                      Text(lp.summaryModel!.avlbpl ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Availed	'),
                                      Text(lp.summaryModel!.plavailed ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Lapsed	'),
                                      Text(lp.summaryModel!.pllapsed ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Balance	'),
                                      Text(lp.summaryModel!.plbal ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('c/fw'),
                                      Text(lp.summaryModel!.plcfw ?? ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'CL',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Opening Balance'),
                                      Text(lp.summaryModel!.clopenbal ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Avlb '),
                                      Text(lp.summaryModel!.avlbcl ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Availed	'),
                                      Text(lp.summaryModel!.clavailed ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Cl Lapsed	'),
                                      Text(lp.summaryModel!.cllapsed ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Balance	'),
                                      Text(lp.summaryModel!.clbal ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('c/fw'),
                                      Text(lp.summaryModel!.clcfw ?? ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'SL',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Opening Balance'),
                                      Text(lp.summaryModel!.slopenbal ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Avlb '),
                                      Text(lp.summaryModel!.avlbsl ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Availed	'),
                                      Text(lp.summaryModel!.slavailed ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Lapsed	'),
                                      Text(lp.summaryModel!.sllapsed ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Balance	'),
                                      Text(lp.summaryModel!.slbal ?? ''),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('c/fw'),
                                      Text(lp.summaryModel!.slcfw ?? ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total PL Allocated Leave'),
                                      Text(lp.summaryModel!.allocleave ?? ''),
                                    ],
                                  ),
                                  // SizedBox(height: 10.h),
                                  Divider(
                                    color: Colors.black54,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Available Leave'),
                                      Text(lp.summaryModel!.avlbleave ?? ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
