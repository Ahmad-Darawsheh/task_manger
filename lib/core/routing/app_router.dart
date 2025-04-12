import 'package:flutter/material.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/features/authentication/presentation/screens/login_screen.dart';
import 'package:todo_task/features/authentication/presentation/screens/register_screen.dart';
import 'package:todo_task/features/onboarding/presentation/onboarding_screen.dart';
import 'package:todo_task/features/tasks/presentation/screens/bottom_nav_bar_screen_holder.dart';
import 'package:todo_task/features/tasks/presentation/screens/create_a_task_screen.dart';
import 'package:todo_task/features/tasks/presentation/screens/tasks_home_screen.dart';
import 'package:todo_task/features/tasks/presentation/screens/tasks_with_calender_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.tasksHome:
        return MaterialPageRoute(builder: (_) => const TasksHomeScreen());
      case Routes.tasksWithCalender:
        return MaterialPageRoute(
            builder: (_) => const TasksWithCalenderScreen());
      case Routes.addATask:
        return MaterialPageRoute(builder: (_) => const CreateATaskScreen());

      case Routes.bottomNavBarScreenHolder:
        return MaterialPageRoute(
            builder: (_) => const BottomNavBarScreenHolder());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(title: const Text('Unknown Route')),
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
