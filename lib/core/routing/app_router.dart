import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/featurs/home/data/repos/house_Item_repo.dart';
import 'package:moveassist/featurs/home/logic/house_item_cubit.dart';
import 'package:moveassist/featurs/home/ui/screens/add_house_item_screen.dart';
import 'package:moveassist/featurs/home/ui/screens/house_items_screen.dart';
import 'package:moveassist/featurs/login/data/repos/login_repo.dart';
import 'package:moveassist/featurs/login/logic/login_cubit.dart';
import 'package:moveassist/featurs/login/ui/login_screen.dart';
import 'package:moveassist/featurs/sign_up/data/repos/sign_up_repo.dart';
import 'package:moveassist/featurs/sign_up/logic/sign_up_cubit.dart';
import 'package:moveassist/featurs/sign_up/ui/sign_up_screen.dart';

final getIt = GetIt.instance;

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupCubit(getIt<SignupRepo>()),
            child: const SignupScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(getIt<LoginRepo>()),
            child: const LoginScreen(),
          ),
        );
      case Routes.houseItemsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HouseItemCubit(getIt<HouseItemRepo>()),
            child: const HouseItemsScreen(),
          ),
        );
      case Routes.addHouseItemsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HouseItemCubit(getIt<HouseItemRepo>()),
            child: const AddHouseItemScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
