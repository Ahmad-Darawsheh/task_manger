import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';

class BoxMinorDetailsText extends StatelessWidget {
  const BoxMinorDetailsText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          'Project Name',
          style: TextStyles.font24WhiteSemiBold,
        ),
        SizedBox(height: 50.h),
        Text(
          'October 12, 2023',
          style: TextStyles.font14WhiteRegular,
        ),
      ],
    );
  }
}
