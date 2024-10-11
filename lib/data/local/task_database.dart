// lib/data/local/task_database.dart

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc_app/data/models/task_model.dart';

class TaskDatabase {
  static final TaskDatabase _instance = TaskDatabase._internal();
  factory TaskDatabase() => _instance;
  TaskDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the database
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE tasks (
        id $idType,
        title $textType,
        description $textType,
        isCompleted $boolType
      )
    ''');
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final maps = await db.query('tasks');
    if (maps.isEmpty) return [];
    return maps.map((map) => Task.fromJson(map)).toList();
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<void> deleteAllTasks() async {
    final db = await database;
    await db.delete(
      'tasks',
    );
  }
}
