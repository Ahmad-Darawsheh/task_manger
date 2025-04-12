import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';

class TimeField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback onTap;

  const TimeField({
    super.key,
    required this.controller,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.font13DarkBlueRegular,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              style: TextStyles.font14DarkBlueRegular,
              cursorColor: ColorsManger.grey,
              decoration: InputDecoration(
                hintText: "Select time",
                hintStyle: TextStyles.font14DarkBlueRegular.copyWith(
                  color: ColorsManger.grey.withOpacity(0.5),
                ),
                // suffixIcon: Icon(Icons.access_time, color: ColorsManger.grey),
                contentPadding: EdgeInsets.only(bottom: 8.h),
                enabledBorder: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorsManger.gradientPurple),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
