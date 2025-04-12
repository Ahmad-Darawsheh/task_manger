import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignCircleBottomLeft extends StatelessWidget {
  final double width;
  final double height;
  final double? bottom;
  final double? left;

  const DesignCircleBottomLeft(
      {super.key,
      required this.width,
      required this.height,
      this.bottom,
      this.left});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom?.h ?? -50.h,
      left: left?.w ?? -50.w,
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
