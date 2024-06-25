import 'package:flutter/material.dart';
import 'package:moveassist/core/utils/constants/colors.dart';

class SnackBarNotifier {
  void _showSnackBar({
    required String message,
    required BuildContext context,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: ColorsManager.white,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
      );
  }

  void success({
    required String message,
    required BuildContext context,
  }) {
    _showSnackBar(
      message: message,
      context: context,
      backgroundColor: ColorsManager.primary,
    );
  }

  void fail({
    required String message,
    required BuildContext context,
  }) {
    _showSnackBar(
      message: message,
      context: context,
      backgroundColor: ColorsManager.red,
    );
  }
}
