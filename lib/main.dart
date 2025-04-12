import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/core/firebase_options.dart';
import 'package:todo_task/core/routing/app_router.dart';
import 'package:todo_task/core/services/service_locator.dart';
import 'package:todo_task/core/utils/app_bloc_observer.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/task_manger_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  ServicesLocator().setupLocator();

  ServicesLocator().setupLocator();
  Bloc.observer = AppBlocObserver();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksHomeCubit()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
      ],
      child: TaskMangerApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
