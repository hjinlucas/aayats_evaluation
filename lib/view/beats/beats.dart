import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'api.dart'; 
import '../../common/widgets.dart';

class Beats extends StatefulWidget {
  const Beats({Key? key}) : super(key: key);

  @override
  _BeatsState createState() => _BeatsState();
}

class _BeatsState extends State<Beats> {
  late Future<List<Map<String, dynamic>>> beats;

  @override
  void initState() {
    super.initState();
    beats = BeatsApi.getBeats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: beats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final beatList = snapshot.data!;
            return ListView.builder(
              itemCount: beatList.length + 1, // Added one for the heading
              itemBuilder: (context, index) {
                if (index == 0) { // Display heading for the first item
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: text24Bold(text: "Sample Example", isGradient: true),
                  );
                }

                final beat = beatList[index - 1];
                final tags = beat['artists'].join(', ');

                return Container(
                  margin: const EdgeInsets.only(top: 2, left: 8, right: 8),
                  child: Column(
                    children: [
                      beatsListingForm(
                        imageURL: beat['imageUrl'],
                        heading: beat['title'],
                        numOfLikes: beat['likes'],
                        tags: tags,
                        tune: beat['key'],
                        bpm: beat['bpm'],
                        price: "\$${beat['price']}+",
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
