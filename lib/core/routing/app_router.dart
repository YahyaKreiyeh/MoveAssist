import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/featurs/sign_up/data/repos/sign_up_repo.dart';
import 'package:moveassist/featurs/sign_up/logic/sign_up_cubit.dart';
import 'package:moveassist/featurs/sign_up/ui/sign_up_screen.dart';

final getIt = GetIt.instance;

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navigationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupCubit(getIt<SignupRepo>()),
            child: const SignupScreen(),
          ),
        );

      // case Routes.homeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeScreen(),
      //   );

      default:
        return null;
    }
  }
}
