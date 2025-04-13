import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/images/app_images.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/core/widgets/design_circle_bottom_left.dart';
import 'package:todo_task/core/widgets/design_circle_top_right.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/box_minor_details_text.dart';

class BoxWithTaskMinorDetails extends StatelessWidget {
  const BoxWithTaskMinorDetails({
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
    
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: 275.w,
          height: 275.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [ColorsManger.gradientPurple, ColorsManger.gradientBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset(
                      AppImages.assetsSvgsLightBulb,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Project ${task.id}',
                    style: TextStyles.font17DarkBlueSemiBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              BoxMinorDetailsText(index: index, taskType: taskType),
            ],
          ),
        ),
        DesignCircleTopRight(
          width: 175,
          height: 175,
        ),

        // Bottom left half circle
        DesignCircleBottomLeft(
          width: 175,
          height: 175,
        ),
      ],
    );
  }
}
