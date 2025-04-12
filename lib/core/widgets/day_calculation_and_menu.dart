 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';


void showTaskOptions(
      BuildContext context, int taskId, GlobalKey menuKey) {
    final cubit = context.read<TasksHomeCubit>();

    // Get the render box from the key
    final RenderBox renderBox = menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    // Calculate position based on the actual button position
    final position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height,
      offset.dx + renderBox.size.width,
      offset.dy,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.check_circle_outline, color: Colors.green),
            title: Text('Complete Task'),
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
          onTap: () => cubit.markTaskAsCompleted(taskId),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('Remove Task'),
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
          onTap: () => cubit.deleteTask(taskId),
        ),
      ],
    );
  }

  String calculateDaysRemaining(String dateString) {
    try {
      // Parse the date string in "MMM dd, yyyy" format to a DateTime object
      final dateFormat = DateFormat("MMM dd, yyyy");
      final taskDate = dateFormat.parse(dateString);
      final now = DateTime.now();
      
      // Strip time components to compare just the dates
      final taskDateOnly = DateTime(taskDate.year, taskDate.month, taskDate.day);
      final nowDateOnly = DateTime(now.year, now.month, now.day);
      
      final difference = taskDateOnly.difference(nowDateOnly).inDays;
      
      if (difference > 0) {
        return '$difference days remaining';
      } else if (difference == 0) {
        return 'Due today';
      } else {
        return '${-difference} days ago';
      }
    } catch (e) {
      // If there's an error parsing the date, return a fallback message
      return 'Date unknown';
    }
  }

