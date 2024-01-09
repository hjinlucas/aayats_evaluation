import 'package:flutter/material.dart';

class ErrorBuilder extends StatefulWidget {
  const ErrorBuilder({
    Key? key,
    required this.builder,
    required this.onError,
    required this.child,
  }) : super(key: key);

  final Widget Function(BuildContext, FlutterErrorDetails) builder;
  final void Function(FlutterErrorDetails) onError;
  final Widget child;

  @override
  State<ErrorBuilder> createState() => _ErrorBuilderWidgetState();
}

class _ErrorBuilderWidgetState extends State<ErrorBuilder> {
  @override
  void initState() {
    super.initState();
    FlutterError.onError = widget.onError;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
