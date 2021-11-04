import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';

class TappableWidget extends Material {
  TappableWidget({
    Key? key,
    required void Function() onTap,
  }) : super(
    key: key,
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      splashColor: AppColors.mainLightBlue.withOpacity(0.5),
    ),
  );
}
