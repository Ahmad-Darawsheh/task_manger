import 'package:get_it/get_it.dart';
import 'package:todo_task/features/tasks/data/local/database_helper.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';
import 'package:todo_task/features/tasks/data/repositories/task_repository_impl.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void setupLocator() {
    // Database
    sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
    
    // Repositories
    sl.registerLazySingleton<BaseTaskRepository>(() => TaskRepositoryImpl(
      databaseHelper: sl<DatabaseHelper>()
    ));
  }
}