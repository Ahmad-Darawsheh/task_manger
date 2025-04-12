import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/core/services/service_locator.dart';
import 'package:todo_task/core/widgets/home_bottom_navigation_bar.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_state.dart';
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
          create: (context) {
            // Get the TasksHomeCubit from context
            final tasksHomeCubit = context.read<TasksHomeCubit>();
            // Create AddTasksCubit with a reference to TasksHomeCubit
            return AddTasksCubit(tasksHomeCubit: tasksHomeCubit);
          },
        ),
        // Add AuthCubit for settings screen logout functionality
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        final cubit = context.read<TasksHomeCubit>();
        return BlocListener<AddTasksCubit, AddTasksState>(
          listener: (context, state) {
            // Force refresh when a task is created
            if (state is TaskCreated) {
              cubit.loadTasks();
            }
          },
          child: BlocBuilder<TasksHomeCubit, TasksHomeState>(
            builder: (context, state) {
              log('BottomNavBarState changed: $state');

              // Always display the app structure, state changes handle content updates
              return Scaffold(
                bottomNavigationBar: HomeBottomNavigationBar(),
                body: cubit.routes[cubit.navBarIndex],
              );
            },
          ),
        );
      }),
    );
  }
}
