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
    });

  @override
  State<Beats> createState() => _Beats();
}

class _Beats extends State<Beats> {
  late SharedPreferences sharedPref;
  var listBeats = [];
  List<Widget> listBeatsWidget = [];
  var resJson;

  //When user wants to signout
  void signOut() async {
    //Clear out user variables in sharedPref
    sharedPref.clear();

    //If only 1 screen on stack, pushReplace the Signin page instead of just popping
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
    //Initialize our sharedPref variable for future use
    initPref();

    //Call function to call http query and build listBeats variable
    grabAllBeats();

    //Refresh page to reflect newly built listBeats
    setState(() {});
  }
  void grabAllBeats() async{    
    var response = await http.get(Uri.parse('http://192.168.1.238:5001/api/beats/findAll'),
      headers: {"content-type":"application/json"}
    );
    //If response.statuscode == 200 (valid)
    if (response.statusCode == 200)
    {
      //Response gave back valid data
      //Decode response into var resJson
      resJson = json.decode(response.body);
      //We only want the list of beat jsons, put into listBeats
      listBeats = resJson['success'];
      //setState to refresh page and correctly display widgets
      setState(() {});

    }
    else{
      print("SHOULD NOT BE HERE");
      listBeats = [];
    }    
  }

  void initPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  Widget constructBeats(var index) {
    //build the string that our tags will be
    String tags = "";
    for(final tag in listBeats[index]['artists'])
    {
      tags = tags + "#"+tag + " "; 
    }
    //Build the beatsListingForm widget using the listBeats list of JSONs
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
