import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/tasks_home_screen_body.dart';

class TasksHomeScreen extends StatelessWidget {
  const TasksHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksHomeCubit(),
      child: TasksHomeScreenBody(),
    );
  }
}
