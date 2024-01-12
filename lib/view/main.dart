import 'package:aayats_evaluation/global_error_handler/global_error_handler.dart';
import 'package:aayats_evaluation/services/data/data_test.dart';
import 'package:aayats_evaluation/view/screens/add_beat/add_beat.dart';
import 'package:aayats_evaluation/view/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/beats/beats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        color: Colors.black,
        debugShowCheckedModeBanner: false,
        // Centralized error responses
        home: GlobalErrorHandler(
          child: Beats(
            beatList: DataTest.beatsList,
          ),
        ),
        // home: GlobalErrorHandler(
        //   child: LoginScreen(),
        // ),
        // home: GlobalErrorHandler(
        //   child: AddBeatScreen(),
        // ),
      ),
    );
  }
}
