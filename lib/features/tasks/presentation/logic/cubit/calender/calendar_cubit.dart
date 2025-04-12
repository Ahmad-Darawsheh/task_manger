import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/calender/calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final ScrollController scrollController = ScrollController();

  CalendarCubit()
      : super(CalendarInitial(
          today: DateTime.now(),
          weekDays: _generateMonthDays(),

          selectedDayIndex:
              DateTime.now().day - 1, // 0-based index for the current day
        ));

  static List<DateTime> _generateMonthDays() {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return List.generate(
      daysInMonth,
      (index) => firstDayOfMonth.add(Duration(days: index)),
    );
  }

  // Scroll to center the highlighted day
  void scrollToHighlightedDay() {
    // Wait for the UI to be built
    Future.delayed(Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;

      // Get today's index from the state
      int todayIndex = 0;
      if (state is CalendarInitial) {
        todayIndex = (state as CalendarInitial).selectedDayIndex;
      }

      final itemWidth = 75.w;
      double scrollOffset = todayIndex * itemWidth;

      // Adjust to center in the viewport
      if (scrollController.hasClients &&
          scrollController.position.hasViewportDimension) {
        final viewportWidth = scrollController.position.viewportDimension;
        scrollOffset = scrollOffset - (viewportWidth / 2) + (itemWidth / 2);

        // Ensure we don't scroll beyond bounds
        scrollOffset =
            scrollOffset.clamp(0.0, scrollController.position.maxScrollExtent);

        // Animate to the calculated position
        scrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
