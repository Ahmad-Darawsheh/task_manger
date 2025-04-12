import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/data/models/task_type_model.dart';

class TaskTypeWidget extends StatelessWidget {
  final TaskTypeModel model;
  const TaskTypeWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.w),
      width: 115.w,
      height: 54.h,
      decoration: BoxDecoration(
        color:
            model.isSelected == true ? Colors.white : ColorsManger.tasksColor,
        borderRadius: BorderRadius.circular(58),
        boxShadow: [
          model.isSelected == true
              ? BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              : BoxShadow()
        ],
      ),
      child: Center(
        child: Text(model.task, style: TextStyles.font14DarkBlueBold),
      ),
    );
  }
}
