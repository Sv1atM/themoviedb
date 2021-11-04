import 'package:flutter/material.dart';

class AppScrollbarWidget extends Scrollbar {
  const AppScrollbarWidget({
    Key? key,
    required Widget child,
  }) : super(
    key: key,
    radius: const Radius.circular(30),
    thickness: 6,
    child: child,
  );
}
