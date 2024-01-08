import 'package:flutter/material.dart';
import '../../common/text_widgets.dart';
import '../../common/text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _emailController = TextEditingController(); // Controller for email
  final _pwdController = TextEditingController(); // Controller for pwd
  final _usernameController = TextEditingController(); // Controller for username

  void createAccount() async {
    //When button is pressed, create a var of the information
    var registerInformation = {
      'username' : _usernameController.text,
      'email' : _emailController.text,
      'password' : _pwdController.text,
    };
    //Find if create account was successful
    var response = await http.post(Uri.parse('http://192.168.1.238:5001/api/register'),
      headers: {"content-type":"application/json"},
      body: jsonEncode(registerInformation)
    );

    if(response.statusCode == 201){
      _emailController.clear();
      _usernameController.clear();
      _pwdController.clear();
    }
    else{
      print("FAILED REGISTERING");
      print(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.all(10),
          child: text24Bold(text: "Register!"
          ,isGradient: true)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _emailController, 
              labelText: "Email", 
              obscureText: false),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _pwdController, 
              labelText: "Password", 
              obscureText: false),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _usernameController, 
              labelText: "Username", 
              obscureText: false),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {createAccount();}, 
              child: const Text("Submit", style: TextStyle(color: Colors.white),))
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("Go Back", style: TextStyle(color: Colors.white)))
          ),
        ],
      ),
    );
  }
}