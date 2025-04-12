import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_state.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasksHomeCubit>();
    return BlocBuilder<TasksHomeCubit, TasksHomeState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: cubit.bottomNavBarItems,
          currentIndex: cubit.navBarIndex,
          onTap: (value) => cubit.bottomNavBarChangeIndex(value),
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 8,
        );
      },
    );
  }
}
