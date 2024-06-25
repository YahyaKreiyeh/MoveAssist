import 'package:flutter/material.dart';
import 'package:moveassist/core/utils/constants/styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: TextStyles.primaryTextMedium14,
          ),
          TextSpan(
            text: ' Login',
            style: TextStyles.primaryTextSemiBold18,
            // recognizer: TapGestureRecognizer()
            //   ..onTap = () {
            //     context.pushReplacementNamed(Routes.loginScreen);
            //   },
          ),
        ],
      ),
    );
  }
}
