import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/core/widgets/task_list_tile.dart';

class TasksInCalenderScreen extends StatelessWidget {
  const TasksInCalenderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 500.h,
            width: double.infinity,
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  TaskListTile(title: 'design 1', daysRemaining: '2'),
              separatorBuilder: (context, index) => SizedBox(height: 5.h),
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
