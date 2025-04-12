import 'package:todo_task/features/tasks/data/models/task_model.dart';

abstract class BaseTaskRepository {
  // Get all tasks
  Future<List<Task>> getAllTasks();
  
  // Get ongoing tasks
  Future<List<Task>> getOngoingTasks();
  
  // Get completed tasks
  Future<List<Task>> getCompletedTasks();
  
  // Add a new task
  Future<int> addTask(Task task);
  
  // Update an existing task
  Future<int> updateTask(Task task);
  
  // Mark a task as completed
  Future<int> markTaskAsCompleted(int taskId);
  
  // Mark a task as ongoing
  Future<int> markTaskAsOngoing(int taskId);
  
  // Delete a task
  Future<int> deleteTask(int taskId);
}