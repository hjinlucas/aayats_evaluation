import 'package:aayats_evaluation/view/widgets/toast/params.dart';
import 'package:aayats_evaluation/view/widgets/toast/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:aayats_evaluation/view/widgets/toast/const.dart';

/// ToastContext
extension ToastContext on BuildContext {
  void showToast(
    String message, {
    required TextStyle style,
    Duration duration = const Duration(
      seconds: ToastConst.toastSeconds,
    ),
    Duration? transition = const Duration(
      milliseconds: ToastConst.toastMilliseconds,
    ),
    Color? backgroundColor = Colors.grey,
    BorderRadius? borderRadius = const BorderRadius.all(
      Radius.circular(
        ToastConst.toastBorderRadius,
      ),
    ),
    AlignmentGeometry alignment = Alignment.bottomCenter,
    IconData? icon,
    double? toastSize = ToastConst.toastSize,
    double paddingTop = ToastConst.toastPaddingTop,
    int? maxLines = ToastConst.toastMaxlines,
  }) {
    // Getting the Overlay State
    final overlayState = Overlay.of(this);

    // Create an Overlay Entry using the custom widget
    final toast = OverlayEntry(
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: paddingTop,
        ),
        child: ToastWidget(
          message: message,
          params: ToastParams(
            textStyle: style,
            duration: duration,
            transition: transition,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            alignment: alignment,
            icon: icon,
            toastSize: toastSize,
            maxLines: maxLines,
          ),
        ),
      ),
    );

    // Showing the toast on the screen
    overlayState!.insert(toast);

    // After xx seconds (duration) this widget needs to be removed
    Future.delayed(duration, toast.remove);
  }
}
