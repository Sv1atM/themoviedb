import 'package:flutter/material.dart';

class SocialMediaButtonWidget extends IconButton {
  SocialMediaButtonWidget({
    Key? key,
    required void Function()? onPressed,
    required IconData icon,
  }) : super(
    key: key,
    onPressed: onPressed,
    icon: Icon(icon, size: 32),
  );
}
