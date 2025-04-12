import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/core/firebase_options.dart';
import 'package:todo_task/core/routing/app_router.dart';
import 'package:todo_task/core/utils/app_bloc_observer.dart';
import 'package:todo_task/task_manger_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  
  // Initialize BlocObserver for tracking all bloc and cubit state changes
  Bloc.observer = AppBlocObserver();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
  );
  runApp(
    TaskMangerApp(
      appRouter: AppRouter(),
    ),
  );
}
