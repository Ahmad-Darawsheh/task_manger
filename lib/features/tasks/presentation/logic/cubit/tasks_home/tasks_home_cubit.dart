import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/core/services/service_locator.dart';
import 'package:todo_task/features/tasks/data/models/task_minor_details_model.dart';
import 'package:todo_task/features/tasks/data/models/task_type_model.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';
import 'package:todo_task/features/tasks/presentation/screens/tasks_home_screen.dart';
import 'package:todo_task/features/tasks/presentation/screens/tasks_with_calender_screen.dart';
import 'tasks_home_state.dart';

class TasksHomeCubit extends Cubit<TasksHomeState> {
  final BaseTaskRepository taskRepository;

  TasksHomeCubit({BaseTaskRepository? repository})
      : taskRepository = repository ?? sl<BaseTaskRepository>(),
        super(const CarouselInitial()) {
    // Load tasks when the cubit is created
    loadTasks();
  }

  List<TaskTypeModel> taskTypes = [
    TaskTypeModel(
      task: 'My Tasks',
      isSelected: true,
    ),
    TaskTypeModel(
      task: 'In-Progress',
    ),
    TaskTypeModel(
      task: 'Completed',
    ),
  ];
  List<Widget> routes = [
    TasksHomeScreen(),
    TasksWithCalenderScreen(),
    Scaffold(
      appBar: AppBar(title: const Text('Unknown Route')),
      body: Center(child: Text('No route defined')),
    ),
    // Routes.settings,
  ];

  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<TaskMinorDetailsModel> taskMinorDetails = [
    TaskMinorDetailsModel(
      task: 'My Tasks',
      date: 'October 12, 2023',
    ),
    TaskMinorDetailsModel(
      task: 'In-Progress',
      date: 'October 12, 2023',
    ),
    TaskMinorDetailsModel(
      task: 'Completed',
      date: 'October 12, 2023',
    ),
  ];

  // Lists to store tasks from database
  List<Task> allTasks = [];
  List<Task> ongoingTasks = [];
  List<Task> completedTasks = [];

  int navBarIndex = 0;
  bool newTaskAdded = false;
  
  void changeIndex(int index) {
    emit(CarouselPageChanged(currentIndex: index));
  }

  void bottomNavBarChangeIndex(int index) {
    navBarIndex = index;
    if (navBarIndex == 0) {
      newTaskAdded == true ? loadTasks() : null;
      log('should\'ve loaded');
      newTaskAdded == true ? newTaskAdded = false : null;
      emit(BottomNavBarIndexChangedToTaskHome());
    } else if (navBarIndex == 1) {
      newTaskAdded == true ? loadTasks() : null;
      emit(BottomNavBarIndexChangedToCalender());
    }
  }

  // Load all tasks from the database
  Future<void> loadTasks() async {
    emit(TasksLoading());

    try {
      // Get tasks from repository
      allTasks = await taskRepository.getAllTasks();
      ongoingTasks = await taskRepository.getOngoingTasks();
      completedTasks = await taskRepository.getCompletedTasks();

      emit(TasksLoaded(
        allTasks: allTasks,
        ongoingTasks: ongoingTasks,
        completedTasks: completedTasks,
      ));
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }

  // Mark a task as completed
  Future<void> markTaskAsCompleted(int taskId) async {
    try {
      await taskRepository.markTaskAsCompleted(taskId);
      await loadTasks(); // Reload tasks after update
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }

  // Mark a task as ongoing
  Future<void> markTaskAsOngoing(int taskId) async {
    try {
      await taskRepository.markTaskAsOngoing(taskId);
      await loadTasks(); // Reload tasks after update
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }

  // Delete a task
  Future<void> deleteTask(int taskId) async {
    try {
      await taskRepository.deleteTask(taskId);
      await loadTasks(); // Reload tasks after deletion
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }
}
