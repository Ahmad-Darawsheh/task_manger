import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/helpers/extensions.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/core/widgets/design_circle_bottom_left.dart';
import 'package:todo_task/core/widgets/design_circle_top_right.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_cubit.dart';
import 'package:todo_task/features/tasks/presentation/widgets/create_a_task/purple_area_fields.dart';
import 'package:todo_task/features/tasks/presentation/widgets/create_a_task/white_area_form.dart';

class CreateATaskScreenBody extends StatelessWidget {
  const CreateATaskScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Gradient background with circles
            Container(
              height: screenHeight * 0.55, // 55% of screen height for gradient
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorsManger.gradientPurple,
                    ColorsManger.gradientBlue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Stack(
                children: [
                  DesignCircleTopRight(
                    width: 275,
                    height: 275,
                    top: -100,
                    right: -75,
                  ),
                  DesignCircleBottomLeft(
                    width: 275,
                    height: 275,
                    bottom: 100,
                    left: -75,
                  ),
                ],
              ),
            ),
            
            // Main content column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with navigation
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  height: 80.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 30.sp),
                        onTap: () => context.pop(),
                      ),
                      SizedBox(width: 120.w),
                      Text(
                        'Create a Task',
                        style: TextStyles.font17DarkBlueSemiBold
                            .copyWith(color: Colors.white, fontSize: 18.sp),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                
                // Purple area form fields (name and date)
                PurpleAreaFields(),
                
                // Spacer before white container
                SizedBox(height: screenHeight * 0.03),
                
                // White area form (time, description, category, button)
                WhiteAreaForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
