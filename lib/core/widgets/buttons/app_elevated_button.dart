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
    return Stack(
      alignment: Alignment.center,
      children: [
        if (onPressed != null)
          Positioned(
            top: 15.h,
            child: CustomPaint(
              painter: GradientShadowPainter(),
              child: Container(
                width: width ?? 0.85.sw,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70.r),
                ),
              ),
            ),
          ),
        Padding(
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
        ),
      ],
    );
  }
}

class GradientShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(0.5),
          Colors.red.withOpacity(0.5),
          Colors.orange.withOpacity(0.5)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final RRect rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(70.r));

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
