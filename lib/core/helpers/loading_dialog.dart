import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moveassist/core/utils/assets_managers/assets.gen.dart';

Future<dynamic> loadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: AssetsManager.lottie.loading.lottie(
        repeat: false,
        height: 150.w,
        width: 150.w,
      ),
    ),
  );
}
