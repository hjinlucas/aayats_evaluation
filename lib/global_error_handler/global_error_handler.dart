import 'package:aayats_evaluation/global_error_handler/error_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlobalErrorHandler extends StatefulWidget {
  const GlobalErrorHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<GlobalErrorHandler> createState() => _GlobalErrorHandlerState();
}

class _GlobalErrorHandlerState extends State<GlobalErrorHandler> {
  // ********************************************
  // Common global errors for
  // - UI rendering
  // - Loging
  // - Connectivity
  // - User validations
  // - etc etc
  // ********************************************
  void onError(FlutterErrorDetails errorDetails) {
    // ********************************************
    // Handling global errors
    // ********************************************
    if (kDebugMode) {
      print('Caught error (GlobalErrorHandler): ${errorDetails.exception}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBuilder(
      builder: (context, errorDetails) {
        // ********************************************
        // Depending on error type we can setup
        // different behaviors or screens or
        // Error objects could be created
        // ********************************************
        return Scaffold(
          appBar: AppBar(title: const Text('Global Error')),
          body: const Center(
            child: Text('Something went wrong. Please try again later.'),
          ),
        );
      },
      onError: onError,
      child: widget.child,
    );
  }
}
