import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_state.dart';
import 'package:todo_task/features/tasks/presentation/widgets/tasks_home_widgets/box_task_minor_details.dart';

class CarouselTasksHome extends StatelessWidget {
  const CarouselTasksHome({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksHomeCubit, TasksHomeState>(
      builder: (context, state) {
        final tasksHomeCubit = context.read<TasksHomeCubit>();
        
        if (state is TasksLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        // Determine which list of tasks to show based on the currentIndex
        List<Task> tasksToShow;
        if (currentIndex == 0) {
          tasksToShow = tasksHomeCubit.allTasks;
        } else if (currentIndex == 1) {
          tasksToShow = tasksHomeCubit.ongoingTasks;
        } else {
          tasksToShow = tasksHomeCubit.completedTasks;
        }
        
        if (tasksToShow.isEmpty) {
          return Center(
            child: Text(
              'No ${currentIndex == 0 ? "Tasks" : currentIndex == 1 ? "In-Progress Tasks" : "Completed Tasks"} Available',
              style: TextStyles.font17DarkBlueSemiBold,
            ),
          );
        }
        
        return CarouselSlider.builder(
          itemCount: tasksToShow.length, // Show all tasks, not just up to 3
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
              tasksHomeCubit.changeIndex(index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: index == tasksHomeCubit.carouselIndex ? 1.0 : 0.5, // Show current item at full opacity
              child: BoxWithTaskMinorDetails(
                index: index,
                taskType: currentIndex,
              ),
            );
          },
        );
      },
    );
  }
}
