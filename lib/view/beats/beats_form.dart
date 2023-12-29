import 'package:aayats_evaluation/common/constants/color_constant.dart';
import 'package:aayats_evaluation/common/models/beats.dart';
import 'package:aayats_evaluation/common/services/beats_service.dart';
import 'package:aayats_evaluation/common/utils/id.dart';
import 'package:aayats_evaluation/common/utils/price.dart';
import 'package:flutter/material.dart';

class BeatsForm extends StatefulWidget {
  final BuildContext snackBarContext;
  final formKey = GlobalKey<FormState>();
  BeatsForm({super.key, required this.snackBarContext});

  @override
  State<BeatsForm> createState() => _BeatsFormState();
}

class _BeatsFormState extends State<BeatsForm> {
  @override
  Widget build(BuildContext context) {
    final Beats newBeats = Beats(
        title: "",
        likes: 0,
        artists: [],
        key: "",
        bpm: 0,
        price: "",
        priceRaw: 0,
        imageUrl: "assets/images/beats_temp2.jpg",
        producerId: generateRandomHex(24));

    return AlertDialog(
      backgroundColor: ColorConstant.backgroundPrimary,
      scrollable: true,
      content: Stack(
        fit: StackFit.loose,
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
            key: widget.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    initialValue: newBeats.imageUrl,
                    style: const TextStyle(color: ColorConstant.textPrimary),
                    onSaved: (newValue) => {newBeats.imageUrl = newValue!},
                    decoration: const InputDecoration(
                        labelText: 'Image url:',
                        labelStyle:
                            TextStyle(color: ColorConstant.textPrimary)),
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
                        {newBeats.artists = newValue!.split(", ")},
                    style: const TextStyle(color: ColorConstant.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'Artists (comma separated):',
                        labelStyle:
                            TextStyle(color: ColorConstant.textPrimary)),
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
                    style: const TextStyle(color: ColorConstant.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'Name:',
                        labelStyle:
                            TextStyle(color: ColorConstant.textPrimary)),
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
                    style: const TextStyle(color: ColorConstant.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'Key/Tune:',
                        labelStyle:
                            TextStyle(color: ColorConstant.textPrimary)),
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
                    style: const TextStyle(color: ColorConstant.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'BPM:',
                        labelStyle:
                            TextStyle(color: ColorConstant.textPrimary)),
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
                    style: const TextStyle(color: ColorConstant.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'Price:',
                        labelStyle:
                            TextStyle(color: ColorConstant.textPrimary)),
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
                    onPressed: () async {
                      if (widget.formKey.currentState!.validate()) {
                        widget.formKey.currentState!.save();
                        try {
                          print('adding new beat,');
                          print(newBeats.priceRaw);

                          await addBeats(newBeats);
                          Navigator.pop(context);
                        } catch (error) {
                          print(error);
                          ScaffoldMessenger.of(widget.snackBarContext)
                              .showSnackBar(SnackBar(
                            content: const Text("Something went wrong"),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            margin: EdgeInsets.only(
                                bottom: MediaQuery.of(widget.snackBarContext)
                                        .size
                                        .height -
                                    100,
                                right: 20,
                                left: 20),
                          ));
                        }
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: ColorConstant.textPrimary),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
