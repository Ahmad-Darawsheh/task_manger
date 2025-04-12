import 'package:todo_task/features/tasks/data/local/database_helper.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';

class TaskRepositoryImpl implements BaseTaskRepository {
  final DatabaseHelper _databaseHelper;

  TaskRepositoryImpl({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  @override
  Future<int> addTask(Task task) async {
    return await _databaseHelper.insertTask(task);
  }

  @override
  Future<List<Task>> getAllTasks(String userId) async {
    return await _databaseHelper.getTasks(userId);
  }

  @override
  Future<List<Task>> getOngoingTasks(String userId) async {
    return await _databaseHelper.getOngoingTasks(userId);
  }

  @override
  Future<List<Task>> getCompletedTasks(String userId) async {
    return await _databaseHelper.getCompletedTasks(userId);
  }

  @override
  Future<int> updateTask(Task task) async {
    return await _databaseHelper.updateTask(task);
  }

  @override
  Future<int> markTaskAsCompleted(int taskId, String userId) async {
    return await _databaseHelper.markTaskAsCompleted(taskId, userId);
  }

  @override
  Future<int> markTaskAsOngoing(int taskId, String userId) async {
    return await _databaseHelper.markTaskAsOngoing(taskId, userId);
  }

  @override
  Future<int> deleteTask(int taskId, String userId) async {
    return await _databaseHelper.deleteTask(taskId, userId);
  }
}