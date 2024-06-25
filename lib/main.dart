import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moveassist/core/di/dependency_injection.dart';
import 'package:moveassist/core/routing/app_router.dart';
import 'package:moveassist/move_assist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  await initiateGetIt();
  runApp(
    MoveAssist(
      appRouter: AppRouter(),
    ),
  );
}
