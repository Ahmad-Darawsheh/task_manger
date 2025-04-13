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
    final cubit = context.read<TasksHomeCubit>();
    
    // Get the appropriate list based on the current task type
    List taskList;
    if (currentIndex == 0) {
      taskList = cubit.allTasks;
    } else if (currentIndex == 1) {
      taskList = cubit.ongoingTasks;
    } else {
      taskList = cubit.completedTasks;
    }
    
    // Get the actual number of tasks for the current task type without limiting
    final int dotsCount = taskList.length;
    final int activeIndex = cubit.carouselIndex < dotsCount ? cubit.carouselIndex : 0;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(dotsCount, (index) {
          return Container(
            width: activeIndex == index ? 24.0.w : 12.0.w,
            height: 12.0.h,
            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
            decoration: BoxDecoration(
              shape:
                  activeIndex == index ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  activeIndex == index ? BorderRadius.circular(6.r) : null,
              color: activeIndex == index
                  ? ColorsManger.gradientBlue
                  : Colors.grey.withValues(alpha: 0.5),
            ),
          );
        }),
      ),
    );
  }
}
