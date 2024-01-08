import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'api.dart'; 
import '../../common/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the BeatUploadForm screen when FloatingActionButton is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BeatUploadForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//Created a Form that allows certified users to input the details of the new beat they want to upload.
class BeatUploadForm extends StatefulWidget {
  const BeatUploadForm({Key? key}) : super(key: key);

  @override
  _BeatUploadFormState createState() => _BeatUploadFormState();
}

class _BeatUploadFormState extends State<BeatUploadForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController likesController = TextEditingController();
  final TextEditingController artistsController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final TextEditingController bpmController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //final Completer<void> _completer = Completer<void>();

  Future<void> uploadBeat() async {
    final String title = titleController.text;
    final int likes = int.parse(likesController.text);
    final String artists = artistsController.text;
    final String key = keyController.text;
    final int bpm = int.parse(bpmController.text);
    final double price = double.parse(priceController.text);
    final String imageUrl = imageUrlController.text;

    try {
      // Made an HTTP POST request to backend API endpoint for creating a new beat
      final response = await http.post(
        Uri.parse('http://localhost:5001/api/beats/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'likes': likes,
          'artists': artists,
          'key': key,
          'bpm': bpm,
          'price': price,
          'imageUrl': imageUrl,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Trigger a rebuild of the main widget
        setState(() {});

        // Show a success message using ScaffoldMessenger
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Beat Successfully Uploaded'),
          ),
        );
      } else {
        // Handle errors from the API (e.g., show an error message)
        print('Failed to upload beat. and the statusCode is ${response.statusCode}, Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      print('Error during HTTP request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload New Beat')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: likesController,
              decoration: const InputDecoration(labelText: 'Likes'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: artistsController,
              decoration: const InputDecoration(labelText: 'Artists'),
            ),
            TextFormField(
              controller: keyController,
              decoration: const InputDecoration(labelText: 'Key'),
            ),
            TextFormField(
              controller: bpmController,
              decoration: const InputDecoration(labelText: 'BPM'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            ElevatedButton(
              onPressed: uploadBeat,
              child: const Text('Upload Beat'),
            ),
          ],
        ),
      ),
    );
  }
}
