import 'dart:math';

import 'package:aayats_evaluation/common/utils/price.dart';
import 'package:aayats_evaluation/view/beats/beats_list.dart';
import 'package:aayats_evaluation/common/constants/color_constant.dart';
import 'package:aayats_evaluation/common/services/beats_service.dart';
import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'beats_tile.dart';
import 'package:aayats_evaluation/common/models/beats.dart' as BeatsModel;

class Beats extends StatefulWidget {
  const Beats({super.key});
  @override
  State<Beats> createState() => _BeatsState();
}

class _BeatsState extends State<Beats> {
  Future<List<BeatsModel.Beats>?> beats = getAllBeats();
  final formKey = GlobalKey<FormState>();
  Future openForm(BuildContext context) async {
    var rng = Random();
    BeatsModel.Beats newBeats = BeatsModel.Beats(
        title: "",
        likes: 0,
        artists: [],
        key: "",
        bpm: -1,
        price: "",
        priceRaw: -1,
        imageUrl: "",
        producerId: rng.nextInt(100).toString());
    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: ColorConstant.backgroundPrimary,
              scrollable: true,
              content: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    top: -10,
                    right: -10,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 30,
                        color: Color(0xFF4b434b),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            onSaved: (newValue) =>
                                {newBeats.imageUrl = newValue!},
                            decoration: const InputDecoration(
                                labelText: 'Image url:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textPrimary)),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) != null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            onSaved: (newValue) =>
                                {newBeats.artists = newValue!.split(" ")},
                            decoration: const InputDecoration(
                                labelText: 'Artists (spaced):',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textPrimary)),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) != null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            onSaved: (newValue) => {newBeats.title = newValue!},
                            decoration: const InputDecoration(
                                labelText: 'Name:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textPrimary)),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) != null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            onSaved: (newValue) => {newBeats.key = newValue!},
                            decoration: const InputDecoration(
                                labelText: 'Key/Tune:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textPrimary)),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) != null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            onSaved: (newValue) =>
                                {newBeats.bpm = int.parse(newValue!)},
                            decoration: const InputDecoration(
                                labelText: 'BPM:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textPrimary)),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return 'Please enter a number';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            onSaved: (newValue) => {
                              newBeats.priceRaw = double.parse(newValue!),
                              newBeats.price =
                                  formatPrice(newBeats.priceRaw, "en_US", "USD")
                            },
                            decoration: const InputDecoration(
                                labelText: 'Price:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textPrimary)),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return 'Please enter a number';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.accentPrimary),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                setState(() async {
                                  try {
                                    await addBeats(newBeats);
                                    Navigator.pop(context);
                                  } catch (error) {
                                    print(error);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Something went wrong")));
                                  }
                                });
                              }
                            },
                            child: const Text(
                              'Submit',
                              style:
                                  TextStyle(color: ColorConstant.textPrimary),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorConstant.backgroundPrimary,
          elevation: 0,
          title: text24Bold(text: "Sample Elements", isGradient: true)),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () => openForm(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant
              .accentPrimary, //should change to button color for consistency
          textStyle: const TextStyle(color: ColorConstant.textPrimary),
        ),
        icon: const Icon(
          Icons.add_circle_outline,
          size: 30,
          color: ColorConstant.textPrimary,
        ),
        label: const Text(
          "Add beats",
          style: TextStyle(color: ColorConstant.textPrimary),
        ),
      ),
      backgroundColor: ColorConstant.backgroundPrimary,
      body: SafeArea(
        child: FutureBuilder(
            future: beats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: ColorConstant.accentPrimary,
                  ),
                );
              } else if (snapshot.hasData) {
                return BeatsList(beats: snapshot.data!);
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "Something went wrong",
                  style: TextStyle(color: ColorConstant.accentSecondary),
                ));
              } else {
                return const Center(
                    child: Text("No data is available",
                        style:
                            TextStyle(color: ColorConstant.accentSecondary)));
              }
            }),
      ),
    );
  }
}
