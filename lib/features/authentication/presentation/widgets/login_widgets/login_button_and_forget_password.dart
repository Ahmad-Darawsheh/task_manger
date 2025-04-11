import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';

class LoginButtonAndForgetPassword extends StatelessWidget {
  const LoginButtonAndForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Login logic will be handled by bloc
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 3,
          ),
          child: Text('Login', style: TextStyles.font16DarkBlueMedium),
        ),
        SizedBox(height: 16.h),

        // Forgot Password
        Center(
          child: TextButton(
            onPressed: () {
              // Forgot password logic will be handled by bloc
            },
            child:
                Text('Forgot Password?', style: TextStyles.font14WhiteRegular),
          ),
        ),
      ],
    );
  }
}
