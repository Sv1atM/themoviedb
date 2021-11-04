import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_elements_styles.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/elements/cancel_button_widget.dart';
import 'package:themoviedb/ui/widgets/elements/main_option_button_widget.dart';

class EmailVerificationWidget extends StatelessWidget {
  const EmailVerificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Resend activation email',
              style: AppTextStyles.em(1.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Missing your account verification email? '
                'Enter your email below to have it resent.',
              style: AppTextStyles.em(1),
            ),
            const SizedBox(height: 25),
            Text('Email',
              style: AppTextStyles.em(1, color: AppColors.textDarkBlue),
            ),
            const SizedBox(height: 3),
            TextField(
              //controller: _emailController,
              autofocus: true,
              decoration: AppElementsStyles.dialogInputDecoration(
                hintText: "What's your email?",
              ),
              cursorColor: AppColors.mainLightBlue,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                MainOptionButtonWidget(
                  onPressed: () {},
                  text: 'Send',
                ),
                const SizedBox(width: 15),
                const CancelButtonWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
