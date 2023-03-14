import 'package:dakshattendance/provider/PaySlipProvider.dart';
import 'package:dakshattendance/screens/EmployeePaySlip/ViewEmployeePaySlip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class EmployeeSlipPage extends StatefulWidget {
  const EmployeeSlipPage({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<EmployeeSlipPage> createState() => _EmployeeSlipPageState();
}

class _EmployeeSlipPageState extends State<EmployeeSlipPage> {
  void init() async {
    Provider.of<SlipProvider>(context, listen: false).userId = widget.userId;

    await Provider.of<SlipProvider>(context, listen: false).getSlips();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SlipProvider>(builder: (context, sp, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Manage Pay Slip',
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
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Get.to(ApplyLeave());
            //     },
            //     icon: Icon(
            //       Icons.add,
            //       color: Colors.black,
            //     )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...sp.slipList.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.blue.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Row(
                      children: [
                        Text(
                          e.payMonth ?? '',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'popin'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          e.payYear ?? '',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'popin'),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                        splashColor: Colors.white,
                        onPressed: () {
                          print(e.id);
                          Get.to(ViewSlip(slipId: e.id!, month: e.payMonth??'', year: e.payYear??'',));
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                        )),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
