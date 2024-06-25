import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moveassist/core/utils/constants/colors.dart';

class AppOutlinedButton extends StatelessWidget {
  final Widget? child;
  final Size? minimumSize;
  final Color? color;
  final Color? backgroundColor;
  final double? radius;
  final void Function()? onPressed;

  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.minimumSize,
    this.color,
    this.backgroundColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorsManager.scaffoldBackground,
        foregroundColor: ColorsManager.black,
        minimumSize: minimumSize ?? Size(100.w, 56.h),
        side: BorderSide(
          width: color == ColorsManager.fieldBorder ? 1.r : 2.r,
          color: color ?? ColorsManager.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 70.r),
        ),
      ),
      child: child,
    );
  }
}
