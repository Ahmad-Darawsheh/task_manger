import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterTextFields extends StatelessWidget {
  const RegisterTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            labelStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            prefixIcon: Icon(Icons.person_outline, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
        SizedBox(height: 20.h),

        // Email field
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
        SizedBox(height: 20.h),

        // Password field
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
            suffixIcon: Icon(Icons.visibility_off, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
        SizedBox(height: 20.h),

        // Confirm Password field
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
            suffixIcon: Icon(Icons.visibility_off, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
