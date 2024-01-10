import 'package:flutter/material.dart';

class ToastParams {
  ToastParams({
    required this.textStyle,
    this.duration,
    this.transition,
    this.backgroundColor,
    this.borderRadius,
    this.alignment,
    this.icon,
    this.toastSize,
    this.maxLines,
  });

  final TextStyle textStyle;
  final Duration? duration;
  final Duration? transition;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final AlignmentGeometry? alignment;
  final IconData? icon;
  final double? toastSize;
  final int? maxLines;
}
