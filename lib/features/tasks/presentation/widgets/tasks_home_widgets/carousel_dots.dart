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
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: context
            .read<TasksHomeCubit>()
            .taskMinorDetails
            .asMap()
            .entries
            .map((entry) {
          return Container(
            width: currentIndex == entry.key ? 24.0.w : 12.0.w,
            height: 12.0.h,
            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
            decoration: BoxDecoration(
              shape: currentIndex == entry.key
                  ? BoxShape.rectangle
                  : BoxShape.circle,
              borderRadius:
                  currentIndex == entry.key ? BorderRadius.circular(6.r) : null,
              color: currentIndex == entry.key
                  ? ColorsManger.gradientBlue
                  : Colors.grey.withValues(alpha: 0.5),
            ),
          );
        }).toList(),
      ),
    );
  }
}
