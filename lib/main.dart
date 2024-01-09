import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/beats/beats.dart';
import 'view/signin/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Grab token from sharedPref
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  String? token = sharedPref.getString('token');
  //If token is null, set it to empty string
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
    bool isTokenValid = false;
    //Check if the token was set to empty string, if it wasn't then it must be a token -> see if token is expired
    if (token != ""){
      isTokenValid = JwtDecoder.isExpired(token);
    }
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        theme: ThemeData.light(),
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        //Send the user to either the Beats page or Signin page depending if they have a valid stored token
        home: isTokenValid ? Beats() : Signin() ,
      ),
    );
  }
}
