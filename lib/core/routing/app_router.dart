import 'package:flutter/material.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/features/onboarding/presentation/onboarding_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    

    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      // case Routes.login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
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
