import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/core/firebase_options.dart';
import 'package:todo_task/core/routing/app_router.dart';
import 'package:todo_task/task_manger_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
  );
  runApp(
    TaskMangerApp(
      appRouter: AppRouter(),
    ),
  );
}
