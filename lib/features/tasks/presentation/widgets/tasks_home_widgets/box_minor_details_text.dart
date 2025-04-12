import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';

class BoxMinorDetailsText extends StatelessWidget {
  const BoxMinorDetailsText({super.key, required this.index});
final int index;
  @override
  Widget build(BuildContext context) {
    final cubit=context.read <TasksHomeCubit>();
    return  Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          cubit.allTasks[index].name,
          style: TextStyles.font24WhiteSemiBold,
        ),
        SizedBox(height: 50.h),
        Text(
          cubit.allTasks[index].date,
          style: TextStyles.font14WhiteRegular,
        ),
      ],
    );
  }
}
