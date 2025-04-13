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
        TextField(
          controller: controller,
          style: TextStyles.font14DarkBlueRegular,
          cursorColor: ColorsManger.grey,
          maxLines: 5,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(top: 15.h, bottom: 15.h, right: 40.w),
            border: InputBorder.none,
          ),
        ),
        Container(
          width: 400.w,
          height: 1.h,
          color: Colors.grey[500],
        ),
      ],
    );
  }
}
