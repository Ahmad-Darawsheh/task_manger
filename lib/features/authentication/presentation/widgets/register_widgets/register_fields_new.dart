import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_state.dart';

class RegisterFieldsNew extends StatelessWidget {
  const RegisterFieldsNew({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Determine password visibility from state
        final isPasswordVisible = state is PasswordVisibilityChanged
            ? state.isRegisterPasswordVisible
            : authCubit.isRegisterPasswordVisible;

        return Form(
          key: authCubit.registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              Text(
                'Full Name',
                style: TextStyles.font16GreyRegularInter,
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: authCubit.registerNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  errorStyle: TextStyles.font16BlackRegularInter,
                ),
                style: TextStyles.font16BlackRegularInter,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 20.h),
              
              // Email Field
              Text(
                'Email',
                style: TextStyles.font16GreyRegularInter,
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: authCubit.registerEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  errorStyle: TextStyles.font16BlackRegularInter,
                ),
                style: TextStyles.font16BlackRegularInter,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 20.h),
              
              // Password field
              Text(
                'Password',
                style: TextStyles.font16GreyRegularInter,
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: authCubit.registerPasswordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey, size: 25.sp,
                    ),
                    onPressed: () => authCubit.toggleRegisterPasswordVisibility(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  errorStyle: TextStyles.font16BlackRegularInter,
                ),
                style: TextStyles.font16BlackRegularInter,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}