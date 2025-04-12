import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/data/models/task_minor_details_model.dart';
import 'package:todo_task/features/tasks/data/models/task_type_model.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';
import 'tasks_home_state.dart';

class TasksHomeCubit extends Cubit<TasksHomeState> {
  final BaseTaskRepository _taskRepository;
  
  TasksHomeCubit({BaseTaskRepository? repository})
      : _taskRepository = repository ?? TaskRepositoryImpl(),
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
  
  void changeIndex(int index) {
    emit(CarouselPageChanged(currentIndex: index));
  }
  
  // Load all tasks from the database
  Future<void> loadTasks() async {
    emit(TasksLoading());
    
    try {
      // Get tasks from repository
      allTasks = await _taskRepository.getAllTasks();
      ongoingTasks = await _taskRepository.getOngoingTasks();
      completedTasks = await _taskRepository.getCompletedTasks();
      
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
      await _taskRepository.markTaskAsCompleted(taskId);
      await loadTasks(); // Reload tasks after update
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }
  
  // Mark a task as ongoing
  Future<void> markTaskAsOngoing(int taskId) async {
    try {
      await _taskRepository.markTaskAsOngoing(taskId);
      await loadTasks(); // Reload tasks after update
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }
  
  // Delete a task
  Future<void> deleteTask(int taskId) async {
    try {
      await _taskRepository.deleteTask(taskId);
      await loadTasks(); // Reload tasks after deletion
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }
}
