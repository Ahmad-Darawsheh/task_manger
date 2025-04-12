import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';

class DatabaseHelper {
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
  static const String columnUserId = 'userId'; // Added userId column
  
  Database? _database;
  
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
      version: 2, // Updated version number to trigger migration
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
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
        $columnIsCompleted INTEGER NOT NULL,
        $columnUserId TEXT NOT NULL
      )
    ''');
  }
  
  // Handle database migrations
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add userId column to existing table
      await db.execute('ALTER TABLE $tasksTable ADD COLUMN $columnUserId TEXT DEFAULT ""');
    }
  }
  
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(
      tasksTable,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<List<Task>> getTasks(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tasksTable,
      where: '$columnUserId = ?',
      whereArgs: [userId],
    );
    
    return List.generate(maps.length, (index) {
      return Task.fromMap(maps[index]);
    });
  }
  
  Future<List<Task>> getOngoingTasks(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tasksTable,
      where: '$columnIsCompleted = ? AND $columnUserId = ?',
      whereArgs: [0, userId],
    );
    
    return List.generate(maps.length, (index) {
      return Task.fromMap(maps[index]);
    });
  }
  
  Future<List<Task>> getCompletedTasks(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tasksTable,
      where: '$columnIsCompleted = ? AND $columnUserId = ?',
      whereArgs: [1, userId],
    );
    
    return List.generate(maps.length, (index) {
      return Task.fromMap(maps[index]);
    });
  }
  
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      tasksTable,
      task.toMap(),
      where: '$columnId = ? AND $columnUserId = ?',
      whereArgs: [task.id, task.userId],
    );
  }
  
  Future<int> markTaskAsCompleted(int id, String userId) async {
    final db = await database;
    return await db.update(
      tasksTable,
      {columnIsCompleted: 1},
      where: '$columnId = ? AND $columnUserId = ?',
      whereArgs: [id, userId],
    );
  }
  
  Future<int> markTaskAsOngoing(int id, String userId) async {
    final db = await database;
    return await db.update(
      tasksTable,
      {columnIsCompleted: 0},
      where: '$columnId = ? AND $columnUserId = ?',
      whereArgs: [id, userId],
    );
  }
  
  Future<int> deleteTask(int id, String userId) async {
    final db = await database;
    return await db.delete(
      tasksTable,
      where: '$columnId = ? AND $columnUserId = ?',
      whereArgs: [id, userId],
    );
  }
  
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}