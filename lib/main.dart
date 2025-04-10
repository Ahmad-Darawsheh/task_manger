import 'package:flutter/material.dart';
import 'package:todo_task/core/routing/app_router.dart';
import 'package:todo_task/task_manger_app.dart';

void main() {
  runApp(TaskMangerApp(
    appRouter: AppRouter(),
  ));
}
