import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/routing/app_router.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/core/services/service_locator.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';

class TaskMangerApp extends StatelessWidget {
  final AppRouter appRouter;
  const TaskMangerApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(482, 1043),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task Manager',
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsManger.backgroundWhite,
            appBarTheme: const AppBarTheme(
              backgroundColor: ColorsManger.backgroundWhite,
              elevation: 0,
            ),
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
          initialRoute: Routes.login,
        );
      },
    );
  }
}
