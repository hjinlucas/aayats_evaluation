import 'package:aayats_evaluation/common/services/beats_service.dart';
import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets.dart';
import 'package:aayats_evaluation/common/models/beats.dart' as BeatsModel;

class Beats extends StatefulWidget {
  const Beats({super.key});

  @override
  State<Beats> createState() => _BeatsState();
}

class _BeatsState extends State<Beats> {
  Future<List<BeatsModel.Beats>?> beats = getAllBeats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: FutureBuilder(
          future: beats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return BeatsTile(snapshot.data!);
            } else if (snapshot.hasError) {
              return const Text("Something went wrong");
            } else {
              return const Text("No data is available");
            }
          }),
    );
  }

  Widget BeatsTile(List<BeatsModel.Beats> beats) {
    print(beats);
    return ListView.builder(
        itemCount: beats.length,
        itemBuilder: (context, index) {
          final current = beats[index];
          return Text(current.title);
        });
  }

  ListView BeatsList() {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2, left: 8, right: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: text24Bold(text: "Sample Elements", isGradient: true),
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
            ],
          ),
        ),
      ],
    );
  }
}
