import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_constant.dart';

Widget text24Bold({required String text, bool isGradient = false}) {
  return ShaderMask(
    shaderCallback: (bounds) => isGradient
        ? const LinearGradient(
            colors: [
              Color(0xFFAD2DF2),
              Color(0xFF8714C6),
              Color(0xFF2E65E7),
              Color(0xFF1546BD)
            ],
            stops: [
              0.0,
              0.33,
              0.66,
              1.0
            ], // adjust these values to get the gradient effect you want
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds)
        : const LinearGradient(
            colors: [ColorConstant.textPrimary, ColorConstant.textPrimary],
          ).createShader(bounds),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        // The color must be set to white for this to work
        color: isGradient ? Colors.white : ColorConstant.textSecondary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: "Lato",
      ),
    ),
  );
}

Widget text16Bold(
    {required String text,
    Color color = ColorConstant.textPrimary,
    TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: "Lato",
    ),
  );
}

Widget text20Bold({required String text, bool isGradient = false}) {
  return ShaderMask(
    shaderCallback: (bounds) => isGradient
        ? const LinearGradient(
            colors: [
              Color(0xFFAD2DF2),
              Color(0xFF8714C6),
              Color(0xFF2E65E7),
              Color(0xFF1546BD)
            ],
            stops: [
              0.0,
              0.33,
              0.66,
              1.0
            ], // adjust these values to get the gradient effect you want
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds)
        : const LinearGradient(
            colors: [ColorConstant.textPrimary, ColorConstant.textPrimary],
          ).createShader(bounds),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        // The color must be set to white for this to work
        color: isGradient ? Colors.white : ColorConstant.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Lato",
      ),
    ),
  );
}

Widget text14Normal(
    {required String text,
    Color color = ColorConstant.textPrimary,
    TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: "Lato",
    ),
  );
}

Widget text14NormalSecondary(
    {required String text,
    Color color = ColorConstant.textSecondary,
    TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: "Lato",
    ),
  );
}

Widget text12Normal(
    {required String text,
    Color color = ColorConstant.textPrimary,
    TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: "Lato",
    ),
  );
}
