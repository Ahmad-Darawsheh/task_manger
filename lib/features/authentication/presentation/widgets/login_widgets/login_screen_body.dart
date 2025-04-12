import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/helpers/extensions.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/core/widgets/app_logo.dart';
import 'package:todo_task/features/authentication/presentation/widgets/login_widgets/email_and_password_fields.dart';
import 'package:todo_task/features/authentication/presentation/widgets/login_widgets/login_button_and_forget_password.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.backgroundWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLogo(),
                SizedBox(height: 40.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorsManger.gradientPurple,
                        ColorsManger.gradientBlue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManger.gradientBlue.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back', style: TextStyles.font24WhiteBold),
                      SizedBox(height: 8.h),
                      Text('Login to continue',
                          style: TextStyles.font14WhiteRegular),
                      SizedBox(height: 30.h),
                      EmailAndPasswordFields(),
                      SizedBox(height: 30.h),
                      LoginButton()
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyles.font14DarkBlueRegular),
                    TextButton(
                      onPressed: () {
                        context.navigateTo(Routes.register);
                      },
                      child: Text("Register",
                          style: TextStyles.font14DarkBlueBold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
