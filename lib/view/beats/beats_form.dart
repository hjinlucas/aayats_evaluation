// ignore_for_file: use_build_context_synchronously

import 'package:aayats_evaluation/common/constants/color_constant.dart';
import 'package:aayats_evaluation/common/models/beats.dart';
import 'package:aayats_evaluation/common/services/beats_service.dart';
import 'package:aayats_evaluation/common/utils/id.dart';
import 'package:aayats_evaluation/common/utils/price.dart';
import 'package:flutter/material.dart';

class BeatsForm extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  BeatsForm({super.key});

  @override
  State<BeatsForm> createState() => _BeatsFormState();
}

class _BeatsFormState extends State<BeatsForm> {
  bool isLoading = false;
  bool isError = false;
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
            child: SizedBox(
              width: 500,
              child: (isLoading)
                  ? const SizedBox(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: ColorConstant.accentPrimary,
                        ),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            onTap: () => setState(() {
                              isError = false;
                            }),
                            initialValue: newBeats.imageUrl,
                            style: const TextStyle(
                                color: ColorConstant.textPrimary),
                            onSaved: (newValue) =>
                                {newBeats.imageUrl = newValue!},
                            decoration: const InputDecoration(
                                labelText: 'Image url:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textSecondary)),
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
                            onTap: () => setState(() {
                              isError = false;
                            }),
                            onSaved: (newValue) =>
                                {newBeats.artists = newValue!.split(", ")},
                            style: const TextStyle(
                                color: ColorConstant.textPrimary),
                            decoration: const InputDecoration(
                                labelText: 'Artists (comma separated):',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textSecondary)),
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
                            onTap: () => setState(() {
                              isError = false;
                            }),
                            onSaved: (newValue) => {newBeats.title = newValue!},
                            style: const TextStyle(
                                color: ColorConstant.textPrimary),
                            decoration: const InputDecoration(
                                labelText: 'Name:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textSecondary)),
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
                            onTap: () => setState(() {
                              isError = false;
                            }),
                            onSaved: (newValue) => {newBeats.key = newValue!},
                            style: const TextStyle(
                                color: ColorConstant.textPrimary),
                            decoration: const InputDecoration(
                                labelText: 'Key/Tune:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textSecondary)),
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
                            onTap: () => setState(() {
                              isError = false;
                            }),
                            onSaved: (newValue) =>
                                {newBeats.bpm = int.parse(newValue!)},
                            style: const TextStyle(
                                color: ColorConstant.textPrimary),
                            decoration: const InputDecoration(
                                labelText: 'BPM:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textSecondary)),
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
                            onTap: () => setState(() {
                              isError = false;
                            }),
                            onSaved: (newValue) => {
                              newBeats.priceRaw = double.parse(newValue!),
                              newBeats.price =
                                  formatPrice(newBeats.priceRaw, "en_US", "USD")
                            },
                            style: const TextStyle(
                                color: ColorConstant.textPrimary),
                            decoration: const InputDecoration(
                                labelText: 'Price:',
                                labelStyle: TextStyle(
                                    color: ColorConstant.textSecondary)),
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
                        isError
                            ? const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Error occurred!",
                                  style: TextStyle(
                                      color: ColorConstant.accentSecondary,
                                      fontSize: 20),
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(0, 77, 255, 0.502)),
                            onPressed: () async {
                              if (widget.formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                try {
                                  widget.formKey.currentState!.save();
                                  await addBeats(newBeats);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context, true);
                                } catch (error) {
                                  setState(() {
                                    isLoading = false;
                                    isError = true;
                                  });
                                  // print(error);
                                }
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
          ),
        ],
      ),
    );
  }
}
