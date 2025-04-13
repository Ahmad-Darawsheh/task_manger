import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';

class BoxMinorDetailsText extends StatelessWidget {
  const BoxMinorDetailsText({
    super.key, 
    required this.index,
    required this.taskType,
  });
  
  final int index;
  // taskType: 0 = All Tasks, 1 = Ongoing Tasks, 2 = Completed Tasks
  final int taskType;
  
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasksHomeCubit>();
    
    // Get the proper task based on the taskType
    Task task;
    if (taskType == 0) {
      task = cubit.allTasks[index];
    } else if (taskType == 1) {
      task = cubit.ongoingTasks[index];
    } else {
      task = cubit.completedTasks[index];
    }
    
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          task.name,
          style: TextStyles.font24WhiteSemiBold,
        ),
        SizedBox(height: 50.h),
        Text(
          task.date,
          style: TextStyles.font14WhiteRegular,
        ),
      ],
    );
  }
}
