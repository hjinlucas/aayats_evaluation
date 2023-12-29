import 'package:aayats_evaluation/view/beats/beats_tile.dart';
import 'package:aayats_evaluation/common/models/beats.dart';
import 'package:flutter/material.dart';

class BeatsList extends StatelessWidget {
  const BeatsList({
    super.key,
    required this.beats,
  });

  final List<Beats> beats;

  @override
  Widget build(BuildContext context) {
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
