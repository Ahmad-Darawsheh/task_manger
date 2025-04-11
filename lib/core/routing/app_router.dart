import 'package:flutter/material.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/features/authentication/presentation/screens/login_screen.dart';
import 'package:todo_task/features/authentication/presentation/screens/register_screen.dart';
import 'package:todo_task/features/onboarding/presentation/onboarding_screen.dart';
import 'package:todo_task/features/tasks/presentation/screens/tasks_home_screen.dart';

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
