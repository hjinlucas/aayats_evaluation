import 'package:aayats_evaluation/services/models/beats.dart';
import 'package:aayats_evaluation/view/screens/base_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aayats_evaluation/services/state_management/app_state.dart';

class AddBeatScreen extends StatelessWidget {
  AddBeatScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _heading = '';
  var _tags = '';
  var _tune = '';
  var _bpm = '';
  var _price = '';
  var textStyle = const TextStyle(color: Colors.white70);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasAppBar: true,
      widget: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Include a new Beat'),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                style: textStyle,
                decoration: InputDecoration(
                    hintText: 'Heading',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  _heading = value;
                  return null;
                },
              ),
              TextFormField(
                style: textStyle,
                decoration: InputDecoration(
                    hintText: 'Tags',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  _tags = value;

                  return null;
                },
              ),
              TextFormField(
                style: textStyle,
                decoration: InputDecoration(
                    hintText: 'Tune',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  _tune = value;

                  return null;
                },
              ),
              TextFormField(
                style: textStyle,
                decoration: InputDecoration(
                  hintText: 'bpm',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  labelStyle: const TextStyle(color: Colors.white70),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  _bpm = value;

                  return null;
                },
              ),
              TextFormField(
                style: textStyle,
                decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  _price = value;

                  return null;
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        var beat = BeatsModel(
                          id: 2,
                          imageUrl: 'assets/images/beats_temp1.jpg',
                          heading: _heading,
                          numOfLikes: '36',
                          tags: _tags,
                          tune: _tune,
                          bpm: _bpm,
                          price: '\$$_price+',
                        );
                        stateManagement.addBeat(beat);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Beat'),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Trigger an error
                    if (kDebugMode) {
                      print('A simulated error go to error handler screen');
                    }
                    //********************************
                    // Error objects could be created
                    // ********************************/
                    throw Exception('Simulated error in Add Beat screen');
                  },
                  child: const Text('Testing a Global Error'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
