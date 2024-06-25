import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moveassist/core/helpers/extensions.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/core/utils/constants/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account?',
            style: TextStyles.primaryTextMedium14,
          ),
          TextSpan(
            text: ' Sign Up',
            style: TextStyles.primaryTextSemiBold18,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(Routes.signupScreen);
              },
          ),
        ],
      ),
    );
  }
}
