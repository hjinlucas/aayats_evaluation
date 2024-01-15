import 'package:aayats_evaluation/common/text_widgets.dart';
import 'package:aayats_evaluation/services/data/data_test.dart';
import 'package:aayats_evaluation/services/state_management/app_state.dart';
import 'package:aayats_evaluation/view/screens/base_screen.dart';
import 'package:aayats_evaluation/view/widgets/toast/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets.dart';

class Beats extends StatelessWidget {
  const Beats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasAppBar: true,
      widget: StreamBuilder(
          stream: stateManagement.appStream,
          builder: (context, snapshot) {
            var list = snapshot.hasData
                ? stateManagement.getBeats
                : DataTest.beatsList;
            return Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.only(bottom: 25, top: 25),
                    itemBuilder: (BuildContext context, int index) {
                      return beatsListingForm(
                        imageURL: list[index].imageUrl,
                        heading: list[index].heading,
                        numOfLikes: list[index].numOfLikes,
                        tags: list[index].tags,
                        tune: list[index].tune,
                        bpm: list[index].bpm,
                        price: list[index].price,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (stateManagement.hasPermissionToAddBeats) {
                      Navigator.pushNamed(context, 'add');
                    } else {
                      context.showToast(
                          'You do not have permission to add a new item.',
                          style: const TextStyle());
                    }
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
            );
          }),
    );
  }
}
