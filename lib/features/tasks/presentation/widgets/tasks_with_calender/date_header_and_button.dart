import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calender/calendar_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calender/calendar_state.dart';

class DateHeaderAndButton extends StatelessWidget {
  const DateHeaderAndButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CalendarCubit, CalendarState>(builder: (context, state) {
          DateTime today;
    
          if (state is CalendarInitial) {
            today = state.today;
          } else {
            today = DateTime.now();
          }
    
          final formattedDate = DateFormat('MMM, yyyy').format(today);
    
          return Text(formattedDate,
              style: TextStyles.font36DarkBlueSemiBold);
        }),
        Spacer(),
        InkWell(
          child: Container(
            width: 150.w,
            height: 55.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsManger.gradientBlue,
                  ColorsManger.gradientPurple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 20),
                SizedBox(width: 5),
                Text(
                  'Add Task',
                  style: TextStyles.font16WhiteSemiBold,
                ),
              ],
            ),
          ),
          onTap: () {},
        )
      ],
    );
  }
}
