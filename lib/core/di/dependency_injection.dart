// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:moveassist/core/networking/dio_factory.dart';
import 'package:moveassist/featurs/home/data/repos/moving_schedule_repo.dart';
import 'package:moveassist/featurs/home/logic/home_cubit.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_cubit.dart';
import 'package:moveassist/featurs/login/data/repos/login_repo.dart';
import 'package:moveassist/featurs/login/logic/login_cubit.dart';
import 'package:moveassist/featurs/sign_up/data/repos/sign_up_repo.dart';
import 'package:moveassist/featurs/sign_up/logic/sign_up_cubit.dart';

final getIt = GetIt.instance;

Future<void> initiateGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // Signup repository and cubit
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // Login repository and cubit
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // MovingSchedule repository and cubit
  getIt.registerLazySingleton<MovingScheduleRepo>(
      () => MovingScheduleRepo(getIt(), getIt(), getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt
      .registerFactory<MovingScheduleCubit>(() => MovingScheduleCubit(getIt()));
}
