import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/images/app_images.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const AppLogo({
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.assetsImagesAppLogo,
      width: 200.w,
      height: 200.h,
    );
  }
}
