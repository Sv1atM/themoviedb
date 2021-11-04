import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';

class AppTooltipWidget extends Tooltip {
  AppTooltipWidget({
    Key? key,
    required String message,
    double verticalOffset = -65,
    required Widget child,
  }) : super(
    key: key,
    message: message,
    textStyle: AppTextStyles.em(1, color: Colors.white),
    decoration: BoxDecoration(
      color: AppColors.mainLightBlue.withOpacity(0.95),
      borderRadius: BorderRadius.circular(6),
    ),
    verticalOffset: verticalOffset,
    child: child,
  );
}
