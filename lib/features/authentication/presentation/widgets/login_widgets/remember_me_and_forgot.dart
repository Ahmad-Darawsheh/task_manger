import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';

class RememberMeAndForgotPassword extends StatefulWidget {
  const RememberMeAndForgotPassword({Key? key}) : super(key: key);

  @override
  State<RememberMeAndForgotPassword> createState() => _RememberMeAndForgotPasswordState();
}

class _RememberMeAndForgotPasswordState extends State<RememberMeAndForgotPassword> {
  bool? _rememberMe;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    
    // Initialize _rememberMe with the cubit value if not already set
    _rememberMe ??= authCubit.rememberMe;
    
    return Row(
      children: [
        // Remember Me checkbox
        Row(
          children: [
            SizedBox(
              height: 24.h,
              width: 24.w,
              child: Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  // Update both the local state and the cubit
                  setState(() {
                    _rememberMe = value;
                  });
                  authCubit.setRememberMe(value ?? false);
                },
                activeColor: ColorsManger.gradientBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Remember me',
              style: TextStyles.font13DarkBlueRegular,
            ),
          ],
        ),
        
        // Spacer
        Spacer(),
        
        // Forgot Password link
        TextButton(
          onPressed: () {
            // Handle forgot password
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4D81E7),
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}