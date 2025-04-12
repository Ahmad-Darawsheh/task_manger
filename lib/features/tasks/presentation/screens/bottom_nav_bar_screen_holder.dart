import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/core/widgets/home_bottom_navigation_bar.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calendar_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_state.dart';

class BottomNavBarScreenHolder extends StatelessWidget {
  const BottomNavBarScreenHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TasksHomeCubit(),
        ),
        BlocProvider(
          create: (context) => CalendarCubit(),
        ),
        BlocProvider(
          create: (context) => AddTasksCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        final cubit = context.read<TasksHomeCubit>();
        return BlocBuilder<TasksHomeCubit, TasksHomeState>(
          builder: (context, state) {
            log('BottomNavBarState changed: $state');

            // Ensure the UI rebuilds properly when the state changes
            if (state is TasksLoaded || state is BottomNavBarIndexChangedToTaskHome || state is BottomNavBarIndexChangedToCalender) {
              return Scaffold(
                bottomNavigationBar: HomeBottomNavigationBar(),
                body: cubit.routes[cubit.navBarIndex],
              );
            } else if (state is TasksLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TasksError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unexpected state')); // Fallback for unexpected states
            }
          },
        );
      }),
    );
  }
}
