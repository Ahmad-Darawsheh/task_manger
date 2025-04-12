import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/core/services/service_locator.dart';
import 'package:todo_task/features/authentication/data/repositories/firebase_auth_repository.dart';
import 'package:todo_task/features/tasks/data/models/task_minor_details_model.dart';
import 'package:todo_task/features/tasks/data/models/task_type_model.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';
import 'package:todo_task/features/tasks/presentation/screens/settings_screen.dart';
import 'package:todo_task/features/tasks/presentation/screens/tasks_home_screen.dart';
import 'package:todo_task/features/tasks/presentation/screens/tasks_with_calender_screen.dart';
import 'tasks_home_state.dart';

class TasksHomeCubit extends Cubit<TasksHomeState> {
  final BaseTaskRepository taskRepository;
  String _currentUserId = '';

  TasksHomeCubit({BaseTaskRepository? repository})
      : taskRepository = repository ?? sl<BaseTaskRepository>(),
        super(const CarouselInitial()) {
    // Load the current user ID and then load tasks
    _loadCurrentUserId().then((_) => loadTasks());
  }

  // Load current user ID from SharedPreferences
  Future<void> _loadCurrentUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _currentUserId = prefs.getString(FirebaseAuthRepository.userIdKey) ?? '';
      
      if (_currentUserId.isEmpty) {
        emit(TasksError(message: 'No user is logged in'));
      }
    } catch (e) {
      emit(TasksError(message: 'Error loading user ID: $e'));
    }
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
    SettingsScreen(),
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
    
    // Always refresh tasks when changing tabs
    loadTasks();
    
    // Then emit the appropriate state based on which tab we navigated to
    if (navBarIndex == 0) {
      newTaskAdded = false; // Reset flag
      emit(BottomNavBarIndexChangedToTaskHome());
    } else if (navBarIndex == 1) {
      newTaskAdded = false; // Reset flag
      emit(BottomNavBarIndexChangedToCalender());
    } else if (navBarIndex == 2) {
      newTaskAdded = false; // Reset flag
      emit(BottomNavBarIndexChangedToSettings());
    }
  }

  // Load all tasks from the database for the current user
  Future<void> loadTasks() async {
    emit(TasksLoading());

    try {
      if (_currentUserId.isEmpty) {
        await _loadCurrentUserId();
        if (_currentUserId.isEmpty) {
          emit(TasksError(message: 'Unable to load user ID'));
          return;
        }
      }
      
      // Get tasks from repository with user ID
      allTasks = await taskRepository.getAllTasks(_currentUserId);
      ongoingTasks = await taskRepository.getOngoingTasks(_currentUserId);
      completedTasks = await taskRepository.getCompletedTasks(_currentUserId);

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
      if (_currentUserId.isEmpty) {
        await _loadCurrentUserId();
      }
      await taskRepository.markTaskAsCompleted(taskId, _currentUserId);
      await loadTasks(); // Reload tasks after update
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }

  // Mark a task as ongoing
  Future<void> markTaskAsOngoing(int taskId) async {
    try {
      if (_currentUserId.isEmpty) {
        await _loadCurrentUserId();
      }
      await taskRepository.markTaskAsOngoing(taskId, _currentUserId);
      await loadTasks(); // Reload tasks after update
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }

  // Delete a task
  Future<void> deleteTask(int taskId) async {
    try {
      if (_currentUserId.isEmpty) {
        await _loadCurrentUserId();
      }
      await taskRepository.deleteTask(taskId, _currentUserId);
      await loadTasks(); // Reload tasks after deletion
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }
  
  // Get current user ID - useful for other components that need it
  String getCurrentUserId() {
    return _currentUserId;
  }
  
  // Set newTaskAdded flag and emit appropriate state
  void setNewTaskAdded(bool value) {
    newTaskAdded = value;
    if (value && navBarIndex == 0) {
      emit(BottomNavBarIndexChangedToTaskHome());
    } else if (value && navBarIndex == 1) {
      emit(BottomNavBarIndexChangedToCalender());
    }
  }
}
