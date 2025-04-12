import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';

class CustomFormTextFieldTasks extends StatelessWidget {
  final TextEditingController controller;
  // final int fieldType; // 1 for date, 2 for time, 0 for text
  final String labelText;

  const CustomFormTextFieldTasks(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 35.0.w),
          child: Text(labelText, style: TextStyles.font24WhiteBold),
        ),
        Center(
          child: Container(
            width: 400.w,
            height: 75.h,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              cursorColor: Colors.white,
              style: TextStyles.font18WhiteRegular,
            ),
          ),
        ),
      ],
    );
  }
}
