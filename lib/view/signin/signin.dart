import 'dart:convert';

import 'package:aayats_evaluation/common/text_widgets.dart';
import '../../common/text_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aayats_evaluation/common/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets.dart';
import 'package:http/http.dart' as http;
import '../../common/color_constant.dart';
import '../beats/beats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../register/register.dart';



class Signin extends StatefulWidget {
  Signin({
    super.key,
  });

  @override
  State<Signin> createState() => _Signin();
}
class _Signin extends State<Signin>{

  String email = "";
  String pwd = "";
  late SharedPreferences sharedPref;
  //String mongoUrl = dotenv.env['MONGO_URL']!;
  String mongoUrl = "mongodb://localhost:5001";
  
  final _emailController =
      TextEditingController(); // Controller for username
  final _pwdController = TextEditingController(); // Controller for pwd

  @override
  void initState() {
    super.initState();
    initPref();
  }

  void initPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  void signin() async {
    //When button is pressed, create a var of the information
    var loginInformation = {
      'email' : _emailController.text,
      'password' : _pwdController.text,
    };
    //Try to find if password matches 
    //print(jsonEncode(loginInformation));
    var response = await http.post(Uri.parse('http://192.168.1.238:5001/api/login'),
      headers: {"content-type":"application/json"},
      body: jsonEncode(loginInformation)
    );
    //Print response to see if it is correct (should give us a token if a user matches)
    print(response.body);
    if(response.statusCode == 200){
      //Means that the http request was successful, user with login information found
      _emailController.clear();
      _pwdController.clear();
      var resJson = json.decode(response.body);
      var token = resJson['accessToken'];
      var username = resJson['username'];
      sharedPref.setString('token', token);
      sharedPref.setString('username', username);
      Navigator.push(context, MaterialPageRoute(builder: ((context) => Beats())));

    }
    else
    {
      //Login attempt failed
      print("LOGIN FAILED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2, left: 8, right: 8),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction, //Triggers on user interactions
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: text24Bold(text: "Signin Page", isGradient: true),
                  ),
                  FractionallySizedBox(
                    //Set the width of the widget surrounding textfield to only be 0.5 wifth of the screen
                    widthFactor: 0.5,
                    //Use the MyTextField widget that I have made
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyTextField(
                        controller: _emailController, //Pass controller to widget
                        labelText: "Email", //What textbox is labeled
                        obscureText: false, //Text written is not obscured (turned into *s)
                        validator: (value) {
                          //Check emails for empty, or if it doesn't contain a "@" -> print out error text
                          if (value == null || value.isEmpty || !value.contains("@")) {
                            return 'Please enter a valid Email.';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    //Set the width of the widget surrounding textfield to only be 0.5 wifth of the screen
                    widthFactor: 0.5,
                    //Use the MyTextField widget that I have made
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyTextField(
                        controller: _pwdController, //Pass controller to widget
                        labelText: "Password", //What textbox is labeled
                        obscureText: true, //Text written is obscured (turned into *s)
                        validator: (value) {
                          //Check pwd if empty -> print out error text
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password.';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      signin();
                    },
                    
                    child: const Text(
                      'Submit'
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //When button is pressed, go to registration screen
                      print(sharedPref.getString('token'));
                      print("REGISTRATION");

                      Navigator.push(context, MaterialPageRoute(builder: ((context) => registerScreen())));
                    },
                    child: const Text(
                      'Or if you want to register instead',
                      style: TextStyle(
                        color: ColorConstant.brandTertiary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
