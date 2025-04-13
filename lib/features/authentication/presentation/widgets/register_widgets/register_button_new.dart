import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_state.dart';

class RegisterButtonNew extends StatelessWidget {
  const RegisterButtonNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful! Welcome to the app.'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate directly to home screen after registration
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bottomNavBarScreenHolder,
            (route) => false, // Remove all previous routes
          );
        } else if (state is AuthError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF4D81E7).withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: state is AuthLoading
                ? null
                : () {
                    if (authCubit.registerFormKey.currentState?.validate() ??
                        false) {
                      authCubit.registerWithForm();
                    } else {
                      // Show a message for form validation issues
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please fill in all required fields correctly'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManger.gradientPurple,
              disabledBackgroundColor: Colors.grey.shade400,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: state is AuthLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Sign Up',
                    style: TextStyles.font16WhiteSemiBold,
                  ),
          ),
        );
      },
    );
  }
}
