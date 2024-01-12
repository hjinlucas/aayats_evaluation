import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: widget,
    );
  }
}
