import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const fontFamily = 'SourceSansPro';
  static const mainFontSize = 16.0;

  static TextStyle em(double value, {
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color = Colors.black,
  }) => TextStyle(
    fontSize: mainFontSize * value,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: color,
  );
}
