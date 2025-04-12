import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  
  static Database? _database;
  
  // Table names
  static const String tasksTable = 'tasks';
  
  // Column names
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnDate = 'date';
  static const String columnStartTime = 'startTime';
  static const String columnEndTime = 'endTime';
  static const String columnDescription = 'description';
  static const String columnCategory = 'category';
  static const String columnIsCompleted = 'isCompleted';
  
  DatabaseHelper._internal();
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'tasks_manager.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tasksTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnStartTime TEXT NOT NULL,
        $columnEndTime TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnIsCompleted INTEGER NOT NULL
      )
    ''');
  }
  
  // Insert a new task
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(
      tasksTable,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  // Get all tasks
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tasksTable);
    
    return List.generate(maps.length, (index) {
      return Task.fromMap(maps[index]);
    });
  }
  
  // Get ongoing tasks (not completed)
  Future<List<Task>> getOngoingTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tasksTable,
      where: '$columnIsCompleted = ?',
      whereArgs: [0],
    );
    
    return List.generate(maps.length, (index) {
      return Task.fromMap(maps[index]);
    });
  }
  
  // Get completed tasks
  Future<List<Task>> getCompletedTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tasksTable,
      where: '$columnIsCompleted = ?',
      whereArgs: [1],
    );
    
    return List.generate(maps.length, (index) {
      return Task.fromMap(maps[index]);
    });
  }
  
  // Update a task
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      tasksTable,
      task.toMap(),
      where: '$columnId = ?',
      whereArgs: [task.id],
    );
  }
  
  // Mark task as completed
  Future<int> markTaskAsCompleted(int id) async {
    final db = await database;
    return await db.update(
      tasksTable,
      {columnIsCompleted: 1},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
  
  // Mark task as ongoing (not completed)
  Future<int> markTaskAsOngoing(int id) async {
    final db = await database;
    return await db.update(
      tasksTable,
      {columnIsCompleted: 0},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
  
  // Delete a task
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      tasksTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
  
  // Delete all tasks
  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete(tasksTable);
  }
  
  // Close the database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}