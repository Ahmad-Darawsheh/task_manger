import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/core/widgets/day_calculation_and_menu.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_state.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/carousel_dots.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/carousel_home_tasks.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/main_tasks_appbar.dart';
import 'package:todo_task/core/widgets/task_list_tile.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/task_type_widget.dart';

class TasksHomeScreenBody extends StatelessWidget {
  const TasksHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasksHomeCubit>();
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      // bottomNavigationBar: HomeBottomNavigationBar(),
      appBar: MainTasksAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyles.font36DarkBlueSemiBold,
            ),
            Text(
              'Have a nice day',
              style: TextStyles.font18GreyRegular,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40.h),
            // Task type selector buttons with BlocBuilder to react to state changes
            BlocBuilder<TasksHomeCubit, TasksHomeState>(
              buildWhen: (previous, current) => 
                current is TasksTypeChanged || 
                current is CarouselPageChanged || 
                current is CarouselInitial,
              builder: (context, state) {
                // Get current index from state
                final currentIndex = state is CarouselPageChanged 
                    ? state.currentIndex 
                    : state is TasksTypeChanged 
                        ? state.currentIndex 
                        : 0;
                
                return Row(
                  children: List.generate(
                    cubit.taskTypes.length,
                    (index) => TaskTypeWidget(
                      model: cubit.taskTypes[index],
                      onTap: () {
                        // Use the new selectTaskType method
                        cubit.selectTaskType(index);
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            BlocBuilder<TasksHomeCubit, TasksHomeState>(
              builder: (context, state) {
                // Get current index from state or use default
                final currentIndex =
                    state is CarouselPageChanged ? state.currentIndex : 
                    state is TasksTypeChanged ? state.currentIndex : 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      child: CarouselTasksHome(currentIndex: currentIndex),
                    ),
                    SizedBox(height: 20.h),
                    CarouselDots(currentIndex: currentIndex),
                  ],
                );
              },
            ),
            SizedBox(height: 20.h),
            Text(
              'Progress',
              style: TextStyles.font24DarkBlueSemiBold.copyWith(fontSize: 26),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<TasksHomeCubit, TasksHomeState>(
                builder: (context, state) {
                  if (state is TasksLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TasksError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    // Always show ongoing tasks in the Progress section regardless of selected tab
                    final ongoingTasks = context.read<TasksHomeCubit>().ongoingTasks;

                    if (ongoingTasks.isEmpty) {
                      return Center(
                          child: Text(
                              'No ongoing tasks',
                              style: TextStyles.font17DarkBlueSemiBold));
                    }

                    return ListView.builder(
                      itemCount: ongoingTasks.length,
                      itemBuilder: (context, index) {
                        final task = ongoingTasks[index];
                        // Create a GlobalKey for each task item
                        final GlobalKey menuKey = GlobalKey();

                        // Calculate days remaining
                        final String daysInfo =
                            calculateDaysRemaining(task.date);

                        return TaskListTile(
                          title: task.name,
                          daysRemaining: daysInfo,
                          menuKey: menuKey, // Pass the key to the TaskListTile
                          onMenuPressed: () {
                            // Use the key to access the button's context and position
                            showTaskOptions(context, task.id!, menuKey);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
