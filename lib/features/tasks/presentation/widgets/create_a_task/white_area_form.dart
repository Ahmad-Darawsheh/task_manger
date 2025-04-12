import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_cubit.dart';
import 'package:todo_task/features/tasks/presentation/widgets/create_a_task/category_selection.dart';
import 'package:todo_task/features/tasks/presentation/widgets/create_a_task/description_field.dart';
import 'package:todo_task/features/tasks/presentation/widgets/create_a_task/time_field.dart';

class WhiteAreaForm extends StatelessWidget {
  const WhiteAreaForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddTasksCubit>();
    
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              
              // Time selection row
              Row(
                children: [
                  Expanded(
                    child: TimeField(
                      controller: cubit.taskStartTimeController,
                      label: 'Start Time',
                      onTap: () => cubit.selectTime(context, true),
                    ),
                  ),
                  
                  SizedBox(width: 20.w),
                  Expanded(
                    child: TimeField(
                      controller: cubit.taskEndTimeController,
                      label: 'End Time',
                      onTap: () => cubit.selectTime(context, false),
                    ),
                  ),
                ],
              ),
              Container(
                    width: 400.w,
                    height: 1.h,
                    color: Colors.grey[500],
                  ),
              
              SizedBox(height: 30.h),
              
              // Description field
              DescriptionField(controller: cubit.taskDescriptionController),
              
              SizedBox(height: 30.h),
              
              // Category selection
              CategorySelection(),
              
              SizedBox(height: 40.h),
              
              // Create Task Button
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsManger.gradientPurple,
                        ColorsManger.gradientBlue,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Save task to the database
                      final success = await cubit.validateAndCreateTask();
                      
                      // Show feedback message
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Task created successfully!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.of(context).pop(); // Go back to tasks screen
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please complete all required fields"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Create Task',
                      style: TextStyles.font16WhiteSemiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}