import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:aayats_evaluation/services/data/data_test.dart';
import 'package:aayats_evaluation/view/widgets/toast/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/widgets.dart';

class Beats extends StatelessWidget {
  const Beats({super.key, this.beatList});

  final beatList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: beatList.length,
              padding: const EdgeInsets.only(bottom: 25, top: 25),
              itemBuilder: (BuildContext context, int index) {
                return beatsListingForm(
                  imageURL: beatList[index].imageUrl,
                  heading: beatList[index].heading,
                  numOfLikes: beatList[index].numOfLikes,
                  tags: beatList[index].tags,
                  tune: beatList[index].tune,
                  bpm: beatList[index].bpm,
                  price: beatList[index].price,
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              context.showToast('This is a test', style: const TextStyle());
            },
            child: const Text('Add Beat'),
          ),
          ElevatedButton(
            onPressed: () {
              // Trigger an error
              if (kDebugMode) {
                print('A simulated error go to error handler screen');
              }
              //********************************
              // Error objects could be created
              // ********************************/
              throw Exception('Simulated error in Beats screen');
            },
            child: const Text('Testing a Global Error'),
          ),
        ],
      ),
    );
  }
}
