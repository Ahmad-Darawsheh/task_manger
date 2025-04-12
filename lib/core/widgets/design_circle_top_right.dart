import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignCircleTopRight extends StatelessWidget {
  final double width;
  final double height;
  final double? top;
  final double? right;

  const DesignCircleTopRight(
      {super.key,
      required this.width,
      required this.height,
      this.top,
      this.right});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top?.h ?? -50.h,
      right: right?.w ?? -50.w,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: Color(0xFF2E3A59).withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
