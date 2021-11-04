import 'package:flutter/material.dart';

TextPainter textPainter({
  required Text textWidget,
  required double layoutWidth,
}) {
  return TextPainter(
    text: TextSpan(text: textWidget.data, style: textWidget.style),
    maxLines: textWidget.maxLines,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: layoutWidth);
}
