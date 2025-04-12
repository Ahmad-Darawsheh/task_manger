import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/widgets/home_bottom_navigation_bar.dart';
import 'package:todo_task/core/widgets/tasks_in_calender_screen.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_with_calender/date_header_and_button.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_with_calender/task_mini_calender.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_with_calender/tasks_calender_appbar.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calender/calendar_cubit.dart';

class TasksWithCalenderScreenBody extends StatelessWidget {
  const TasksWithCalenderScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CalendarCubit();
        // Initialize scrolling after the cubit is created
        WidgetsBinding.instance.addPostFrameCallback((_) {
          cubit.scrollToHighlightedDay();
        });
        return cubit;
      },
      child: Scaffold(
        // bottomNavigationBar: HomeBottomNavigationBar(),
        appBar: TasksCalenderAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              height: 250.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  DateHeaderAndButton(),
                  SizedBox(height: 25.h),
                  TaskMiniCalender(),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            TasksInCalenderScreen(),
          ],
        ),
      ),
    );
  }
}
