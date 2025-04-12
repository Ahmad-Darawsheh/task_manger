import 'package:get_it/get_it.dart';
import 'package:todo_task/features/authentication/data/repositories/firebase_auth_repository.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:todo_task/features/tasks/data/local/database_helper.dart';
import 'package:todo_task/features/tasks/data/repositories/base_task_repository.dart';
import 'package:todo_task/features/tasks/data/repositories/task_repository_impl.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void setupLocator() {
    // Register Firebase Auth Repository
    sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepository(),
    );

    // Register Auth Cubit
    sl.registerFactory<AuthCubit>(
      () => AuthCubit(authRepository: sl()),
    );
  
    sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
    
    // Repositories
    sl.registerLazySingleton<BaseTaskRepository>(() => TaskRepositoryImpl(
      databaseHelper: sl<DatabaseHelper>()
    ));
  }
}