import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create Account',
          style: TextStyles.font24WhiteBold,
        ),
        SizedBox(height: 8.h),
        Text(
          'Sign up to get started',
          style: TextStyles.font14WhiteRegular,
        ),
      ],
    );
  }
}
