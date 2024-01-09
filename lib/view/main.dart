import 'package:aayats_evaluation/global_error_handler/global_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'beats/beats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(393, 852),
      child: MaterialApp(
        color: Colors.black,
        debugShowCheckedModeBanner: false,
        // Centralized error responses
        home: GlobalErrorHandler(
          child: Beats(),
        ),
      ),
    );
  }
}
