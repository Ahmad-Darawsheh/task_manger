import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/helpers/extensions.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/widgets/login_widgets/email_and_password_fields.dart';
import 'package:todo_task/features/authentication/presentation/widgets/login_widgets/login_button.dart';
import 'package:todo_task/features/authentication/presentation/widgets/login_widgets/remember_me_and_forgot.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsManger.gradientPurple,
              ColorsManger.gradientBlue,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AppLogo(),
                  SizedBox(height: 40.h),
                  Container(
                    height: 750.h,
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Login', style: TextStyles.font54BlackBoldInter),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyles.font18GreyRegularInter),
                            TextButton(
                              onPressed: () {
                                context.navigateTo(Routes.register);
                              },
                              child: Text("Sign Up",
                                  style: TextStyles.font18GreyRegularInter
                                      .copyWith(color: Color(0xFF4D81E7))),
                            )
                          ],
                        ),
                        SizedBox(height: 30.h),
                        EmailAndPasswordFields(),
                        SizedBox(height: 20.h),
                        RememberMeAndForgotPassword(),
                        SizedBox(height: 110.h),
                        LoginButton(),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
