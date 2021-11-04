import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';

class LoadingProgressIndicatorWidget extends Center {
  const LoadingProgressIndicatorWidget({Key? key}) : super(
    key: key,
    child: const CircularProgressIndicator(color: AppColors.mainLightBlue),
  );
}
