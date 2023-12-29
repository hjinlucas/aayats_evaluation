import 'dart:math';

import 'package:aayats_evaluation/common/utils/price.dart';
import 'package:aayats_evaluation/view/beats/beats_form.dart';
import 'package:aayats_evaluation/view/beats/beats_list.dart';
import 'package:aayats_evaluation/common/constants/color_constant.dart';
import 'package:aayats_evaluation/common/services/beats_service.dart';
import 'package:aayats_evaluation/common/widgets/text_widgets.dart';
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

  Future openForm(BuildContext context) async {
    bool? isUpdate = await showDialog<bool>(
        context: context,
        builder: (_context) => BeatsForm(snackBarContext: context));
    if (isUpdate != null && isUpdate) {
      setState(() {
        beats = getAllBeats();
      });
    }
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
