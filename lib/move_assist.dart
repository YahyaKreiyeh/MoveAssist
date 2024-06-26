import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moveassist/core/routing/app_router.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/core/utils/constants/colors.dart';
import 'package:moveassist/featurs/home/data/repos/moving_schedule_repo.dart';
import 'package:moveassist/featurs/home/logic/home_cubit.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_cubit.dart';

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
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeCubit(getIt<MovingScheduleRepo>())
                  ..fetchMovingSchedules(),
              ),
              BlocProvider(
                create: (context) =>
                    MovingScheduleCubit(getIt<MovingScheduleRepo>()),
              ),
            ],
            child: MaterialApp(
              title: 'Move Assist',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  color: ColorsManager.scaffoldBackground,
                ),
                primaryColor: ColorsManager.primary,
                scaffoldBackgroundColor: ColorsManager.scaffoldBackground,
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: getInitialRoute(),
              onGenerateRoute: appRouter.generateRoute,
            ));
      },
    );
  }

  String getInitialRoute() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Routes.homeScreen;
    } else {
      return Routes.loginScreen;
    }
  }
}
