import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/widgets.dart';

class Beats extends StatelessWidget {
  const Beats({super.key});

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
      ),
    );
  }
}
