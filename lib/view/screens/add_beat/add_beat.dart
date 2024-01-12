import 'package:aayats_evaluation/view/screens/base_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddBeatScreen extends StatelessWidget {
  AddBeatScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
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
                decoration: InputDecoration(
                    hintText: 'Heading',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Tags',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Tune',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'bpm',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: TextStyle(color: Colors.grey.shade600)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
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
