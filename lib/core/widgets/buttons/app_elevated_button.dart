import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moveassist/core/utils/constants/colors.dart';

class AppElevatedButton extends StatelessWidget {
  final double? width;
  final String text;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0).h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(70).r,
          ),
          minimumSize: Size(0.9.sw, 56.h),
          side: onPressed != null
              ? BorderSide(
                  width: 1.r,
                  color: ColorsManager.black,
                )
              : null,
          padding: const EdgeInsets.all(14.6).r,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: ColorsManager.white,
          ),
        ),
      ),
    );
  }
}
