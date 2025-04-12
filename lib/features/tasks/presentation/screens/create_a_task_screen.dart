import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_cubit.dart';
import 'package:todo_task/features/tasks/presentation/widgets/create_a_task/create_a_task_screen_body.dart';

class CreateATaskScreen extends StatelessWidget {
  const CreateATaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTasksCubit(),
      child: CreateATaskScreenBody(),
    );
  }
}
