import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/beats/beats.dart';
import 'view/signin/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  String? token = sharedPref.getString('token');
  token = token ?? "";
  print("TOKEN IS " + token + "****");
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final token;
  
  const MyApp({super.key, required this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isTokenValid = true;
    if (token != ""){
      isTokenValid = JwtDecoder.isExpired(token);
    }
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        theme: ThemeData.light(),
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        home: isTokenValid ? Beats() : Signin() ,
      ),
    );
  }
}
