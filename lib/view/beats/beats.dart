import 'package:aayats_evaluation/common/color_constant.dart';
import 'package:aayats_evaluation/common/services/beats_service.dart';
import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/beats_tile.dart';
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
                return BeatsList(snapshot.data!);
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

  Widget BeatsList(List<BeatsModel.Beats> beats) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: beats.length,
        itemBuilder: (context, index) {
          final current = beats[index];
          return BeatsTile(current);
        });
  }
}
