import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/images/app_images.dart';

class MainTasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainTasksAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            AppImages.assetsSvgsMenuHome,
            width: 24.w,
            height: 18.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 30.w),
          child: InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              AppImages.assetsSvgsProfileHome,
              width: 40.w,
              height: 40.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
      // Give more space for the leading widget with padding
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75.h);
}
