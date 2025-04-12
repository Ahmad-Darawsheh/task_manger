import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyles.font14DarkBlueBold,
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: ColorsManger.tasksColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: controller,
            style: TextStyles.font14DarkBlueRegular,
            cursorColor: ColorsManger.grey,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Add a detailed description...",
              hintStyle: TextStyles.font13GreyRegular,
              contentPadding: EdgeInsets.symmetric(vertical: 15.h),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}