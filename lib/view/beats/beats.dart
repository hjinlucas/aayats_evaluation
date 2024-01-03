import 'dart:convert';
import 'dart:io';

import 'package:aayats_evaluation/Model/beats_model.dart';
import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:aayats_evaluation/view/mongodb.dart';
import 'package:flutter/material.dart';

import '../../common/widgets.dart';

class Beats extends StatefulWidget {
  const Beats({ Key? key }) : super(key: key);

  @override
  BeatsState createState() => BeatsState();
}

class BeatsState extends State<Beats> {

  List<dynamic> BeatsList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readJson();
  }

  Future<void> readJson() async {

    String filepath = await MongoDatabase.connect();
    File file = File(filepath);
    String fileContent = '';
    if (await file.exists()) {
      fileContent = await file.readAsString();
      // print('File content: $fileContent');
    } else {
      print('File does not exist.');
    }

    final data = await json.decode(fileContent);

    setState(() {
      BeatsList = data
          .map((data) => Beats_Model.fromJson(data)).toList();
    });

    print(BeatsList);
  }


  
  

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Container(
      margin: const EdgeInsets.only(top: 2, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.center,
                  child: text24Bold(text: "Sample Elements", isGradient: true),
                ),
              ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: BeatsList.length,
              itemBuilder: (context, index) {
                return beatsListingForm(
                  imageURL: BeatsList[index].imageURL,
                  heading: BeatsList[index].heading,
                  numOfLikes: BeatsList[index].numOfLikes,
                  tags: BeatsList[index].tags,
                  tune: BeatsList[index].tune,
                  bpm: BeatsList[index].bpm,
                  price: BeatsList[index].price,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

  
  
}
