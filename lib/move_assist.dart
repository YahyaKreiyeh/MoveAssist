import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moveassist/core/routing/app_router.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/core/utils/constants/colors.dart';

class MoveAssist extends StatelessWidget {
  final AppRouter appRouter;

  const MoveAssist({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Move Assist',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: ColorsManager.scaffoldBackground,
            ),
            primaryColor: ColorsManager.primary,
            scaffoldBackgroundColor: ColorsManager.scaffoldBackground,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.navigationScreen,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
