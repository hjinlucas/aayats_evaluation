import 'dart:convert';

import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/text_widgets.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

import '../signin/signin.dart';

import '../../common/widgets.dart';
class Beats extends StatefulWidget {
  const Beats({
    super.key,
    //required this.username,
    });

    //final username;

  @override
  State<Beats> createState() => _Beats();
}

class _Beats extends State<Beats> {
  late SharedPreferences sharedPref;
  var listBeats = [];
  List<Widget> listBeatsWidget = [];
  var resJson;
  void signOut() async {
    late SharedPreferences sharedPref;
    sharedPref = await SharedPreferences.getInstance();
    
    sharedPref.clear();
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin()));
    }
    
  }

  @override
  void initState() {
    super.initState();
    initPref();
    grabAllBeats();
    setState(() {});
  }
  void grabAllBeats() async{
    print("START GRAB ALL");
    
    var response = await http.get(Uri.parse('http://192.168.1.238:5001/api/beats/findAll'),
      headers: {"content-type":"application/json"}
    );
    if (response.statusCode == 200)
    {
      //Response gave back valid data
      resJson = json.decode(response.body);
      print("THE FIRST TITLE" + resJson['success'][0]['title'].toString());
      print("THE SECOND TITLE" + resJson['success'][1]['title'].toString());
      listBeats = resJson['success'];
      print("THIS IS THE LIST");
      print(listBeats);
      print("LIST LENGTH");
      print(listBeats.length);
      setState(() {});

    }
    else{
      print("SHOULD NOT BE HERE");
      listBeats = [];
    }

    print("END GRAB ALL");
    
  }

  void initPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  Widget constructBeats(var index) {
    String tags = "";
    for(final tag in listBeats[index]['artists'])
    {
      tags = tags + "#"+tag + " "; 
    }
    return beatsListingForm(
      imageURL: listBeats[index]['imageUrl'],
      heading: listBeats[index]['title'].toString(),
      numOfLikes: listBeats[index]['likes'],
      tags: tags,
      tune: listBeats[index]['key'].toString(),
      bpm: listBeats[index]['bpm'],
      price: "\$"+listBeats[index]['price'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2, left: 8, right: 8),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: text24Bold(text: "Sample Elements", isGradient: true),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: text24Bold(text: "Welcome!", isGradient: true),
                ),
                for (int i = 0; i < listBeats.length; i++)
                  constructBeats(i),
                
                TextButton(onPressed: () async {
                  signOut();
                },
                 child: const Text(
                  "Sign Out"
                 ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
