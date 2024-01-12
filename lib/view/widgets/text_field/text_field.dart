import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.textFieldController,
    required this.inputType,
    required this.icon,
    required this.textFieldName,
  }) : super(key: key);

  final TextEditingController? textFieldController;
  final TextInputType inputType;
  final IconData icon;
  final String textFieldName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          textFieldName,
          style: const TextStyle(),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 50.0,
          color: Colors.grey,
          child: TextField(
            controller: textFieldController,
            keyboardType: inputType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                icon,
              ),
              hintText: textFieldName,
              hintStyle: const TextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
