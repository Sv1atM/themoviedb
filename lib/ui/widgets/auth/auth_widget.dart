import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_elements_styles.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/elements/main_option_button_widget.dart';
import 'package:themoviedb/ui/widgets/elements/secondary_option_button_widget.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to your account')),
      body: const SingleChildScrollView(child: _AuthFormWidget()),
    );
  }
}

class _AuthFormWidget extends StatelessWidget {
  const _AuthFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(text: TextSpan(
            style: AppTextStyles.em(1),
            children: [
              const TextSpan(text: 'In order to use the editing and rating '
                  'capabilities of TMDb, as well as get personal recommendations'
                  ' you will need to login to your account. If you do not have '
                  'an account, registering for an account is free and simple. ',
              ),
              _clickableText('Click here', onTap: model.signUp),
              const TextSpan(text: ' to get started.\n\n'
                  "If you signed up but didn't get your verification email, ",
              ),
              _clickableText('click here', onTap: model.verifyEmail),
              const TextSpan(text: ' to have it resent.'),
            ],
          )),
          const SizedBox(height: 30),
          const _LoginInputFieldsWidget(),
          Row(
            children: [
              const _AuthButtonWidget(),
              const SizedBox(width: 15),
              SecondaryOptionButtonWidget(
                onPressed: model.resetPassword,
                text: 'Reset password',
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextSpan _clickableText(String text, {
    required void Function() onTap,
  }) {
    return TextSpan(
      text: text,
      style: const TextStyle(color: AppColors.mainLightBlue),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}

class _LoginInputFieldsWidget extends StatelessWidget {
  const _LoginInputFieldsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthModel>();
    final loginErrorText = (model.errorMessage != null) ? '' : null; // '' для активації ErrorBorder
    final passwordErrorText = model.errorMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username',
          style: AppTextStyles.em(1, color: AppColors.textDarkBlue),
        ),
        const SizedBox(height: 3),
        TextField(
          controller: model.loginTextController,
          decoration: AppElementsStyles.dialogInputDecoration(errorText: loginErrorText),
          cursorColor: AppColors.mainLightBlue,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        Text('Password',
          style: AppTextStyles.em(1, color: AppColors.textDarkBlue),
        ),
        const SizedBox(height: 3),
        TextField(
          controller: model.passwordTextController,
          decoration: AppElementsStyles.dialogInputDecoration(errorText: passwordErrorText),
          cursorColor: AppColors.mainLightBlue,
          keyboardType: TextInputType.text,
          obscureText: true,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthModel>();
    final onPressed = model.canStartAuth ? model.auth : null;
    final inProgress = model.isAuthProgress;

    return MainOptionButtonWidget(
      onPressed: onPressed,
      inProgress: inProgress,
      text: 'Login',
    );
  }
}
