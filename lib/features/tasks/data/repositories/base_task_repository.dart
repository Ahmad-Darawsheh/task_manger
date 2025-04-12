import 'package:todo_task/features/tasks/data/models/task_model.dart';

abstract class BaseTaskRepository {
  // Get all tasks for a specific user
  Future<List<Task>> getAllTasks(String userId);
  
  // Get ongoing tasks for a specific user
  Future<List<Task>> getOngoingTasks(String userId);
  
  // Get completed tasks for a specific user
  Future<List<Task>> getCompletedTasks(String userId);
  
  // Add a new task
  Future<int> addTask(Task task);
  
  // Update an existing task
  Future<int> updateTask(Task task);
  
  // Mark a task as completed
  Future<int> markTaskAsCompleted(int taskId, String userId);
  
  // Mark a task as ongoing
  Future<int> markTaskAsOngoing(int taskId, String userId);
  
  // Delete a task
  Future<int> deleteTask(int taskId, String userId);
}