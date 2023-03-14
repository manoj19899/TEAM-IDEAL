// ignore_for_file: unused_import, deprecated_member_use

import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/provider/EmployeeInfoProvider/EmployeeInfoProvider.dart';
import 'package:dakshattendance/provider/PaySlipProvider.dart';
import 'package:dakshattendance/provider/leaveProvider.dart';
import 'package:dakshattendance/screens/homepage.dart';
import 'package:dakshattendance/screens/login_page.dart';
import 'package:dakshattendance/shared_preference/pref_keys.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.prefs});
  final Box prefs;

  @override
  _MyAppState createState() => _MyAppState(prefs: prefs);
}

class _MyAppState extends State<MyApp> {
  String notificationMsg = "";

  _MyAppState({required this.prefs});
  Box prefs;

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.instance.getInitialMessage().then((event) {
    //   setState(() {
    //     notificationMsg =
    //         "${event!.notification!.title} ${event.notification!.body}";
    //   });
    // });
    // FirebaseMessaging.onMessage.listen((event) {
    //   setState(() {
    //     notificationMsg =
    //         "${event.notification!.title} ${event.notification!.body}";
    //   });
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   setState(() {
    //     notificationMsg =
    //         "${event.notification!.title} ${event.notification!.body}";
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LeaveProvider()),
            ChangeNotifierProvider(create: (context) => SlipProvider()),
            ChangeNotifierProvider(create: (context) => EmployeeInfoProvider()),
          ],
          child: GetMaterialApp(
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: MediaQuery(
                  data: mediaQueryData.copyWith(textScaleFactor: 1.0),
                  child: child!,
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: MaterialColor(
                AppColor.appColor2.value,
                {
                  50: Color(AppColor.appColor2.value).withOpacity(0.1),
                  100: Color(AppColor.appColor2.value).withOpacity(0.2),
                  200: Color(AppColor.appColor2.value).withOpacity(0.3),
                  300: Color(AppColor.appColor2.value).withOpacity(0.4),
                  400: Color(AppColor.appColor2.value).withOpacity(0.5),
                  500: Color(AppColor.appColor2.value).withOpacity(0.6),
                  600: Color(AppColor.appColor2.value).withOpacity(0.7),
                  700: Color(AppColor.appColor2.value).withOpacity(0.8),
                  800: Color(AppColor.appColor2.value).withOpacity(0.9),
                  900: Color(AppColor.appColor2.value).withOpacity(1),
                },
              ),
              appBarTheme: Theme.of(context)
                  .appBarTheme
                  .copyWith(brightness: Brightness.light),
              fontFamily: 'popin',
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'popin'),
            ),
            home: _dicedeScreen(prefs),
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

// SPLASH SCREEN -------------
Widget _dicedeScreen(Box prefs) {
  PrefObj.preferences = prefs;
  return prefs.containsKey(PrefKeys.USERDATA) ? MyHomepage() : LoginPage();
}
