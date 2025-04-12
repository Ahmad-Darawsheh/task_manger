import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calender/calendar_cubit.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_with_calender/tasks_with_calender_screen_body.dart';

class TasksWithCalenderScreen extends StatelessWidget {
  const TasksWithCalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarCubit(),
      child: TasksWithCalenderScreenBody(),
    );
  }
}
