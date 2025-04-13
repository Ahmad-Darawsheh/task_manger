import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/helpers/extensions.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/widgets/register_widgets/register_button_new.dart';
import 'package:todo_task/features/authentication/presentation/widgets/register_widgets/register_fields_new.dart';

class RegisterScreenBodyNew extends StatelessWidget {
  const RegisterScreenBodyNew({super.key});

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
                  SizedBox(height: 40.h),
                  Container(
                    height: 800.h,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign Up', style: TextStyles.font54BlackBoldInter),
                        Row(
                          children: [
                            Text("Already have an account?",
                                style: TextStyles.font18GreyRegularInter),
                            TextButton(
                              onPressed: () {
                                context.navigateTo(Routes.login);
                              },
                              child: Text("Login",
                                  style: TextStyles.font18GreyRegularInter
                                      .copyWith(color: Color(0xFF4D81E7))),
                            )
                          ],
                        ),
                        SizedBox(height: 30.h),
                        RegisterFieldsNew(),
                        SizedBox(height: 100.h),
                        RegisterButtonNew(),
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