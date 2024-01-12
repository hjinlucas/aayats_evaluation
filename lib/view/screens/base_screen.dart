import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    Key? key,
    required this.widget,
    required this.hasAppBar,
  }) : super(key: key);

  final Widget widget;
  final bool hasAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hasAppBar ? AppBar() : null,
      backgroundColor: Colors.black,
      body: widget,
    );
  }
}
