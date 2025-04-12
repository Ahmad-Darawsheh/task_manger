import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_cubit.dart';

class PurpleAreaFields extends StatelessWidget {
  const PurpleAreaFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddTasksCubit>();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          
          SizedBox(height: 30.h),
          _buildNameField(cubit),
          SizedBox(height: 25.h),
          _buildDateField(context, cubit),
        ],
      ),
    );
  }

  Widget _buildNameField(AddTasksCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            'Name',
            style: TextStyles.font16WhiteSemiBold,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: cubit.taskNameController,
          style: TextStyles.font18WhiteRegular,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: "Enter task name",
            hintStyle: TextStyles.font18WhiteRegular.copyWith(
              color: Colors.white.withOpacity(0.5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context, AddTasksCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            'Date',
            style: TextStyles.font16WhiteSemiBold,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => cubit.selectDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: cubit.taskDateController,
              style: TextStyles.font18WhiteRegular,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Select date",
                hintStyle: TextStyles.font18WhiteRegular.copyWith(
                  color: Colors.white.withOpacity(0.5),
                ),
                suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              ),
            ),
          ),
        ),
      ],
    );
  }
}