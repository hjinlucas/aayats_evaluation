import 'dart:convert';
import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../../common/widgets.dart';

const String beatsApiUrl = 'http://10.0.2.2:5001/api/beats';
const String loginApiUrl = 'http://10.0.2.2:5001/api/login';

class Beat {
  String imageURL;
  String heading;
  String numOfLikes;
  String tags;
  String tune;
  String bpm;
  String price;
  String producerId;

  Beat({
    required this.imageURL,
    required this.heading,
    required this.numOfLikes,
    required this.tags,
    required this.tune,
    required this.bpm,
    required this.price,
    required this.producerId,
  });

  factory Beat.fromJson(Map<String, dynamic> json) {
    final List<String> tagList = (json['artists'] as List<dynamic>)
        .map<String>((tag) => '#$tag')
        .toList();
    return Beat(
      imageURL: json['imageUrl'],
      heading: json['title'],
      numOfLikes: json['likes'].toString(),
      tags: tagList.join(' '),
      tune: json['key'],
      bpm: json['bpm'].toString(),
      price: json['price'].toString(),
      producerId: json['producerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageURL,
      'title': heading,
      'likes': numOfLikes,
      'artist': tags.split(' '),
      'key': tune,
      'bpm': bpm,
      'price': price,
      'producerId': producerId,
    };
  }

}

class Beats extends StatefulWidget {
  const Beats({super.key});

  @override
  BeatsState createState() => BeatsState();
}

class BeatsState extends State<Beats> {
  List<Beat> beats = [];
  bool isCertifiedUser = false;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBeats();
  }

  Future<void> fetchBeats() async {
    // get all the beats stored in db
    final response = await http.get(Uri.parse(beatsApiUrl));

    if (response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Beat> fetchedBeats = data.map((json) => Beat.fromJson(json)).toList();
      setState(() {
        beats = fetchedBeats;
      });
    } else {
      throw Exception("Failed to load beats");
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
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await showCertificationDialog(context);
                  },
                  child: const Text("Upload New Beat"),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Explore Beats",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 198, 205, 218)
                    ),
                  ),
                  ),
                  for (var beat in beats)
                  beatsListingForm(
                    imageURL: beat.imageURL,
                    heading: beat.heading,
                    numOfLikes: beat.numOfLikes,
                    tags: beat.tags,
                    tune: beat.tune,
                    bpm: beat.bpm,
                    price: "\$${beat.price}+",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showCertificationDialog(BuildContext context) async {
    // clear email, password so user has to enter everytime
    email.clear();
    password.clear();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Certified User Login"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    bool certified = await checkCertification(email.text, password.text);
                    setState(() {
                      isCertifiedUser = certified;
                    });
                    Navigator.of(context).pop();
                    if (isCertifiedUser) {
                      await showUploadForm(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("You're not a certified user."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }, 
                  child: const Text("Submit"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<bool> checkCertification(String email, String password) async {
    final response = await http.post(Uri.parse(loginApiUrl),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'email': email, 'password': password})
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['isCertified'] == true;
    }
    return false;
  }

  Future<void> showUploadForm(BuildContext context) async {
    Beat newBeat = Beat(imageURL: "", heading: "", numOfLikes: "", tags: "", tune: "", bpm: "", price: "", producerId: "");

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Beat Details"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => newBeat.imageURL = value,
                  decoration: const InputDecoration(labelText: "Image URL"),
                ),
                TextField(
                  onChanged: (value) => newBeat.heading = value,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  onChanged: (value) => newBeat.numOfLikes = value,
                  decoration: const InputDecoration(labelText: "Likes"),
                ),
                TextField(
                  onChanged: (value) => newBeat.tags = value,
                  decoration: const InputDecoration(labelText: "Artist"),
                ),
                TextField(
                  onChanged: (value) => newBeat.tune = value,
                  decoration: const InputDecoration(labelText: "Tune"),
                ),
                TextField(
                  onChanged: (value) => newBeat.bpm = value,
                  decoration: const InputDecoration(labelText: "BPM"),
                ),
                TextField(
                  onChanged: (value) => newBeat.price = value,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
                TextField(
                  onChanged: (value) => newBeat.producerId = value,
                  decoration: const InputDecoration(labelText: "Producer ID"),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    await addNewBeat(newBeat);
                    Navigator.of(context).pop();
                    await fetchBeats();
                  },
                  child: const Text("Submit"),
                )
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> addNewBeat(Beat newBeat) async {
    final response = await http.post(Uri.parse(beatsApiUrl),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(newBeat.toJson())
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Beat added successfully."),
          backgroundColor: Colors.green,
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to add beat. Please try again."),
          backgroundColor: Colors.red,
        )
      );
    }
  }
}
