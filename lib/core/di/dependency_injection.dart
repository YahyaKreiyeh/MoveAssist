import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moveassist/core/networking/dio_factory.dart';
import 'package:moveassist/featurs/sign_up/data/apis/signup_api_service.dart';
import 'package:moveassist/featurs/sign_up/data/repos/sign_up_repo.dart';
import 'package:moveassist/featurs/sign_up/logic/sign_up_cubit.dart';

final getIt = GetIt.instance;

Future<void> initiateGetIt() async {
  // Register FirebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<SignupApiService>(() => SignupApiService(dio));

  // Signup repository and cubit
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
}
