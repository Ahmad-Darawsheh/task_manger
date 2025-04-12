import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calender/calendar_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calender/calendar_state.dart';

class TaskMiniCalender extends StatelessWidget {
  const TaskMiniCalender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        List<DateTime> monthDays = [];
        int todayIndex = 0;

        if (state is CalendarInitial) {
          monthDays = state.weekDays;
          todayIndex = state.selectedDayIndex;
        } else if (state is CalendarDaySelected) {
          monthDays = state.weekDays;
          todayIndex = state.selectedDayIndex;
        }

        return SizedBox(
          height: 80.h,
          child: ListView.builder(
            controller: context.read<CalendarCubit>().scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: monthDays.length,
            itemBuilder: (context, index) {
              final day = monthDays[index];
              // Only highlight today's date
              final isToday = index == todayIndex;

              return Container(
                margin: EdgeInsets.only(right: 15.w),
                width: 60.w,
                decoration: BoxDecoration(
                  color: isToday
                      ? ColorsManger.gradientPurple.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EE')
                          .format(day)
                          .substring(0, 2), // Mo, Tu, We, etc
                      style: TextStyles.font14DarkBlueRegular,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      day.day.toString(),
                      style: TextStyles.font16DarkBlueMedium.copyWith(
                        color: isToday
                            ? ColorsManger.gradientPurple
                            : ColorsManger.grey,
                        fontWeight: isToday ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
