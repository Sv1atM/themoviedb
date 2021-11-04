import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';

class SecondaryOptionButtonWidget extends TextButton {
  SecondaryOptionButtonWidget({
    Key? key,
    required void Function()? onPressed,
    required String text,
  }) : super(
    key: key,
    onPressed: onPressed,
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColors.mainLightBlue),
    ),
    child: Text(text, style: AppTextStyles.em(1)),
  );
}
