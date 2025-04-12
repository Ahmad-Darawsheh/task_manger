import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_task/core/images/app_images.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';

class TaskListTile extends StatelessWidget {
  final String title;
  final String daysRemaining;
  final VoidCallback? onMenuPressed;

  const TaskListTile({
    super.key,
    required this.title,
    required this.daysRemaining,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        leading: Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorsManger
                    .gradientPurple, // Assuming these colors from your ColorsManger
                ColorsManger.gradientBlue,
              ],
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppImages.assetsSvgsToDoList,
              width: 28.w,
              height: 28.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        title: Text(
          title,
          style:
              TextStyles.font17DarkBlueSemiBold, // Assuming this style exists
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text("$daysRemaining days ago",
              style: TextStyles.font14WhiteRegular.copyWith(
                  color: Color(0xffBFC8E8)) // Assuming this style exists
              ),
        ),
        trailing: InkWell(
          onTap: onMenuPressed,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: SvgPicture.asset(
              AppImages.assetsSvgs3dots,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ),
    );
  }
}
