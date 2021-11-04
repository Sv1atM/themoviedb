import 'package:flutter/material.dart';

abstract class AppElementsStyles {
  static InputDecoration dialogInputDecoration({
    String? hintText,
    String? errorText,
  }) {
    const errorBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
    const focusedErrorBorder = OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFCDD2)));
    InputBorder? enabledBorder;
    InputBorder? focusedBorder;

    if (errorText == '') {
      enabledBorder = errorBorder;
      focusedBorder = focusedErrorBorder;
      errorText = null;
    }

    return InputDecoration(
      isCollapsed: true,
      border: const OutlineInputBorder(),
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: focusedErrorBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      hintText: hintText,
      errorText: errorText,
    );
  }
}
