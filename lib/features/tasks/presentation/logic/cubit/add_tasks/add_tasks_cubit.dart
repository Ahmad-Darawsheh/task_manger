import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/core/services/service_locator.dart';
import 'package:todo_task/features/authentication/data/repositories/firebase_auth_repository.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_state.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';

class AddTasksCubit extends Cubit<AddTasksState> {
  final BaseTaskRepository taskRepository;
  final TasksHomeCubit? tasksHomeCubit;
 
  AddTasksCubit({
    BaseTaskRepository? repository,
    this.tasksHomeCubit,
  }) : taskRepository = repository ?? sl<BaseTaskRepository>(),
      super(const AddTasksInitial());

  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController taskStartTimeController = TextEditingController();
  TextEditingController taskEndTimeController = TextEditingController();
  
  // Use lazy initialization for the form key
  GlobalKey<FormState>? _formKey;
  GlobalKey<FormState> get formKey => _formKey ??= GlobalKey<FormState>(debugLabel: 'addTaskFormKey');
  
  // Selected category
  String selectedCategory = '';
  
  // Task categories
  final List<String> categories = [
    'Design',
    'Meeting',
    'Coding',
    'BDE',
    'Testing',
    'Quick Call'
  ];
  
  // Select category
  void selectCategory(String category) {
    selectedCategory = category;
    emit(CategorySelected(category: category));
  }
  
  // Date picker helper
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    
    if (picked != null) {
      final formattedDate = DateFormat('MMM dd, yyyy').format(picked);
      taskDateController.text = formattedDate;
    }
  }

  // Time picker helper
  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    
    if (picked != null) {
      // Format time with AM/PM
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final formattedTime = '$hour:${picked.minute.toString().padLeft(2, '0')} $period';
      
      if (isStartTime) {
        taskStartTimeController.text = formattedTime;
      } else {
        taskEndTimeController.text = formattedTime;
      }
    }
  }
  
  // Get current user ID from SharedPreferences
  Future<String> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(FirebaseAuthRepository.userIdKey) ?? '';
    if (userId.isEmpty) {
      emit(const AddTasksError('User not logged in'));
    }
    return userId;
  }
  
  // Validate and create new task
  Future<bool> validateAndCreateTask() async {
    // Basic validation
    if (taskNameController.text.isEmpty ||
        taskDateController.text.isEmpty ||
        taskStartTimeController.text.isEmpty ||
        taskEndTimeController.text.isEmpty ||
        selectedCategory.isEmpty) {
      return false;
    }
    
    try {
      // Get current user ID
      String userId = await _getCurrentUserId();
      if (userId.isEmpty) {
        return false;
      }
      
      // Create a task object with user ID
      final task = Task(
        name: taskNameController.text,
        date: taskDateController.text,
        startTime: taskStartTimeController.text,
        endTime: taskEndTimeController.text,
        description: taskDescriptionController.text.isEmpty 
            ? 'No description' 
            : taskDescriptionController.text,
        category: selectedCategory,
        isCompleted: false, // New task is ongoing by default
        userId: userId, // Include user ID
      );
      
      // Save to database
      final result = await taskRepository.addTask(task);
      
      // Clear the form after successful save
      if (result > 0) {
        clearForm();
        
        // Update TasksHomeCubit to reload tasks
        if (tasksHomeCubit != null) {
          tasksHomeCubit!.setNewTaskAdded(true);
          tasksHomeCubit!.loadTasks();
        }
        
        // Emit success state
        emit(const TaskCreated());
        
        return true;
      }
      
      return false;
    } catch (e) {
      emit(AddTasksError('Error creating task: $e'));
      return false;
    }
  }
  
  // Clear the form
  void clearForm() {
    taskNameController.clear();
    taskDescriptionController.clear();
    taskDateController.clear();
    taskStartTimeController.clear();
    taskEndTimeController.clear();
    selectedCategory = '';
    _formKey = null; // Reset form key to create a new one next time
    emit(const AddTasksInitial());
  }
  
  @override
  Future<void> close() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    taskDateController.dispose();
    taskStartTimeController.dispose();
    taskEndTimeController.dispose();
    _formKey = null; // Clean up the form key
    return super.close();
  }
}
