import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';

class CarouselDots extends StatelessWidget {
  const CarouselDots({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    // Get the number of tasks and limit to 3 dots, or 1 dot if less than 3 tasks
    final int dotsCount = context.read<TasksHomeCubit>().allTasks.length >= 3
        ? 3
        : context.read<TasksHomeCubit>().allTasks.length;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(dotsCount, (index) {
          return Container(
            width: currentIndex == index ? 24.0.w : 12.0.w,
            height: 12.0.h,
            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
            decoration: BoxDecoration(
              shape:
                  currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  currentIndex == index ? BorderRadius.circular(6.r) : null,
              color: currentIndex == index
                  ? ColorsManger.gradientBlue
                  : Colors.grey.withValues(alpha: 0.5),
            ),
          );
        }),
      ),
    );
  }
}
