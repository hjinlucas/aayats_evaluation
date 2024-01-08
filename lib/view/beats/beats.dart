import 'dart:convert';

import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/text_widgets.dart';
import 'package:firebase_core/firebase_core.dart';


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
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: text24Bold(text: "Sample Elements", isGradient: true),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: text24Bold(text: "Welcome!", isGradient: true),
                ),
                beatsListingForm(
                    imageURL: "assets/images/beats_temp1.jpg",
                    heading: "Lover's Blume",
                    numOfLikes: "639",
                    tags: "#Chris Brown # SZA",
                    tune: "A minor",
                    bpm: "82",
                    price: "\$29.99+"),
                beatsListingForm(
                    imageURL: "assets/images/beats_temp2.jpg",
                    heading: "Lover's Blume",
                    numOfLikes: "639",
                    tags: "#Chris Brown # SZA",
                    tune: "A minor",
                    bpm: "82",
                    price: "\$29.99+"),
                beatsListingForm(
                    imageURL: "assets/images/beats_temp3.jpg",
                    heading: "Lover's Blume",
                    numOfLikes: "639",
                    tags: "#Chris Brown # SZA",
                    tune: "A minor",
                    bpm: "82",
                    price: "\$29.99+"),
                beatsListingForm(
                    imageURL: "assets/images/beats_temp4.jpg",
                    heading: "Lover's Blume",
                    numOfLikes: "639",
                    tags: "#Chris Brown # SZA",
                    tune: "A minor",
                    bpm: "82",
                    price: "\$29.99+"),
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
