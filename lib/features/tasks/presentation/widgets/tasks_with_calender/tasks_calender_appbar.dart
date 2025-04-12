import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/images/app_images.dart';

class TasksCalenderAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const TasksCalenderAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: SizedBox.shrink(),
      actions: [
        Transform.translate(
          offset: Offset(0, 13.h),
          child: InkWell(
            child: SvgPicture.asset(
              AppImages.assetsSvgsSearch,
              width: 34.h,
              height: 54.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75.h);
}
