import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';

class MainOptionButtonWidget extends ElevatedButton {
  MainOptionButtonWidget({
    Key? key,
    required void Function()? onPressed,
    bool inProgress = false,
    required String text,
  }) : super(
    key: key,
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.mainLightBlue),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      )),
      elevation: MaterialStateProperty.all(0),
    ),
    child: inProgress ? const SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(color: Colors.white),
    ) : Text(text,
      style: AppTextStyles.em(1, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
