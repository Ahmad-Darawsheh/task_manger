import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/core/widgets/task_list_tile.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_state.dart';

class TasksInCalenderScreen extends StatelessWidget {
  const TasksInCalenderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasksHomeCubit>();
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tasks',
            style: TextStyles.font24DarkBlueSemiBold.copyWith(
              fontSize: 28.sp,
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<TasksHomeCubit, TasksHomeState>(
            builder: (context, state) {
              if (state is TasksLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TasksError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                final tasks = cubit.ongoingTasks;

                if (tasks.isEmpty) {
                  return Center(
                    child: Text('No tasks for this day',
                        style: TextStyles.font17DarkBlueSemiBold),
                  );
                }

                return SizedBox(
                  height: 500.h,
                  width: double.infinity,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final GlobalKey menuKey = GlobalKey();
                      final String daysInfo =
                          _calculateDaysRemaining(task.date);

                      return TaskListTile(
                        title: task.name,
                        daysRemaining: daysInfo,
                        menuKey: menuKey,
                        onMenuPressed: () {
                          _showTaskOptions(context, task.id!, menuKey);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                    itemCount: tasks.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  String _calculateDaysRemaining(String dateString) {
    try {
      final taskDate = DateFormat('MMM dd, yyyy').parse(dateString);
      final today = DateTime.now();
      final difference = taskDate.difference(today).inDays;

      if (difference < 0) {
        return 'Overdue by ${difference.abs()} days';
      } else if (difference == 0) {
        return 'Due today';
      } else if (difference == 1) {
        return 'Due tomorrow';
      } else {
        return '$difference days remaining';
      }
    } catch (e) {
      // If there's an error parsing the date, return a fallback message
      return 'Date unknown';
    }
  }

  void _showTaskOptions(BuildContext context, int taskId, GlobalKey menuKey) {
    final cubit = context.read<TasksHomeCubit>();

    // Get the render box from the key
    final RenderBox renderBox =
        menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    // Calculate position based on the actual button position
    final position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height,
      offset.dx + renderBox.size.width,
      offset.dy,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.check_circle_outline, color: Colors.green),
            title: Text('Complete Task'),
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
          onTap: () {
            // Mark as completed and force refresh
            Future.delayed(Duration.zero, () {
              cubit.markTaskAsCompleted(taskId);
            });
          },
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('Remove Task'),
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
          onTap: () {
            // Delete and force refresh
            Future.delayed(Duration.zero, () {
              cubit.deleteTask(taskId);
            });
          },
        ),
      ],
    );
  }
}
