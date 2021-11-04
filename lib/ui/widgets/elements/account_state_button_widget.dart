import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';

class AccountStateButtonWidget extends ElevatedButton {
  AccountStateButtonWidget({
    Key? key,
    required void Function()? onPressed,
    bool state = false,
    Color trueStateColor = Colors.white,
    required IconData icon,
  }) : super(
    key: key,
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.mainDarkBlue),
      shape: MaterialStateProperty.all(const CircleBorder()),
      padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
      minimumSize: MaterialStateProperty.all(Size.zero),
    ),
    child: Icon(icon,
      size: 16,
      color: state ? trueStateColor : Colors.white,
    ),
  );
}
