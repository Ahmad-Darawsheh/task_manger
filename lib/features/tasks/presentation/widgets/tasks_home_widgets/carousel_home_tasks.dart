import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/box_task_minor_details.dart';

class CarouselTasksHome extends StatelessWidget {
  const CarouselTasksHome({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: context.read<TasksHomeCubit>().taskMinorDetails.length,
      options: CarouselOptions(
        height: 250.h,
        autoPlay: false,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        viewportFraction: 0.72,
        padEnds: false,
        initialPage: 0,
        pageSnapping: true,
        enlargeCenterPage: false,
        clipBehavior: Clip.none,
        onPageChanged: (index, reason) {
          context.read<TasksHomeCubit>().changeIndex(index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: currentIndex == index ? 1.0 : 0.5,
          child: BoxWithTaskMinorDetails(),
        );
      },
    );
  }
}
