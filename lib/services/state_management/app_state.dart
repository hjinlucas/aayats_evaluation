import 'dart:async';

import 'package:aayats_evaluation/services/data/data_test.dart';
import 'package:aayats_evaluation/services/models/beats.dart';
import 'package:flutter/foundation.dart';

class _StateManagement {
  List<BeatsModel> appData = DataTest.beatsList;
  var isAllowedToAddBeats = false;

  final StreamController<List<BeatsModel>> _appStreamController =
      StreamController<List<BeatsModel>>();

// Get and Set Beat value
  List<BeatsModel> get getBeats => appData;
  void addBeat(BeatsModel beat) {
    appData.add(beat);
    _appStreamController.add(appData);
  }

  void removeBeat(BeatsModel beat) {
    if (appData.remove(beat)) {
      if (kDebugMode) {
        print('Beat was removed');
      }
    } else {
      if (kDebugMode) {
        print('Beat was not in the beat list');
      }
    }
  }

  // Get and Set change add permission
  bool get hasPermissionToAddBeats => isAllowedToAddBeats;
  void changeAddBeatPermission() {
    isAllowedToAddBeats = true;
  }

  // Subscribers
  Stream<List<BeatsModel>> get appStream => _appStreamController.stream;
}

// Simple singleton without using factory constructor
// We can create our own state management if neccessary
final stateManagement = _StateManagement();
