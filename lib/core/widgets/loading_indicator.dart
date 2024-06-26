import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moveassist/core/utils/assets_managers/assets.gen.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AssetsManager.lottie.loading.lottie(
        height: 150.w,
        width: 150.w,
      ),
    );
  }
}
