import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';

class EmailAndPasswordFields extends StatefulWidget {
  const EmailAndPasswordFields({super.key});

  @override
  State<EmailAndPasswordFields> createState() => _EmailAndPasswordFieldsState();
}

class _EmailAndPasswordFieldsState extends State<EmailAndPasswordFields> {
  bool _isPasswordVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the initial password visibility from the cubit
    final authCubit = context.read<AuthCubit>();
    setState(() {
      _isPasswordVisible = authCubit.isLoginPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Form(
      key: authCubit.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyles.font16GreyRegularInter,
          ),
          SizedBox(height: 10.h),
          TextFormField(
            controller: authCubit.loginEmailController,
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
          Text(
            'Password',
            style: TextStyles.font16GreyRegularInter,
          ),
          SizedBox(height: 10.h),
          TextFormField(
            controller: authCubit.loginPasswordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey, size: 25.sp,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                  // Still update the cubit to maintain consistent state across the app
                  authCubit.toggleLoginPasswordVisibility();
                },
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
  }
}
