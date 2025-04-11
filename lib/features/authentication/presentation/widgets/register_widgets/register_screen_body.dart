import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/helpers/extensions.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/widgets/register_widgets/register_button.dart';
import 'package:todo_task/features/authentication/presentation/widgets/register_widgets/register_text.dart';
import 'package:todo_task/features/authentication/presentation/widgets/register_widgets/register_text_fields.dart';

class RegisterScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.backgroundWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo/icon at the top
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              ColorsManger.gradientBlue.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.person_add_outlined,
                      size: 60.r,
                      color: ColorsManger.gradientBlue,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Register container with gradient
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
                          color:
                              ColorsManger.gradientBlue.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RegisterText(),
                        SizedBox(height: 30.h),
                        RegisterTextFields(),
                        SizedBox(height: 30.h),
                        RegisterButton(),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyles.font14DarkBlueRegular,
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          "Login",
                          style: TextStyles.font14DarkBlueBold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
