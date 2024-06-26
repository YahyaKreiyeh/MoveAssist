import 'package:flutter/material.dart';
import 'package:moveassist/core/widgets/loading_indicator.dart';

Future<dynamic> loadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const LoadingIndicator(),
  );
}
