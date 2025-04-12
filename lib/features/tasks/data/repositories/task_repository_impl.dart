import 'package:todo_task/features/tasks/data/local/database_helper.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';

class TaskRepositoryImpl implements BaseTaskRepository {
  final DatabaseHelper _databaseHelper;

  TaskRepositoryImpl({DatabaseHelper? databaseHelper})
      : _databaseHelper = databaseHelper ?? DatabaseHelper();

  @override
  Future<int> addTask(Task task) async {
    return await _databaseHelper.insertTask(task);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return await _databaseHelper.getTasks();
  }

  @override
  Future<List<Task>> getOngoingTasks() async {
    return await _databaseHelper.getOngoingTasks();
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    return await _databaseHelper.getCompletedTasks();
  }

  @override
  Future<int> updateTask(Task task) async {
    return await _databaseHelper.updateTask(task);
  }

  @override
  Future<int> markTaskAsCompleted(int taskId) async {
    return await _databaseHelper.markTaskAsCompleted(taskId);
  }

  @override
  Future<int> markTaskAsOngoing(int taskId) async {
    return await _databaseHelper.markTaskAsOngoing(taskId);
  }

  @override
  Future<int> deleteTask(int taskId) async {
    return await _databaseHelper.deleteTask(taskId);
  }
}