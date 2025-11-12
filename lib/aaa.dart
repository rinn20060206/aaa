import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tasksTableName = "products";
  final String _tasksIdColumnName = "id";
  final String _taskContentColumnName = "content";
  final String _tasksStatusColumnName = "day";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tasksTableName (
            $_tasksIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_taskContentColumnName TEXT NOT NULL,
            $_tasksStatusColumnName INTEGER NOT NULL
          )
        ''');
      },
    );
    return database;
  }

  Future<void> addTask(String content, int day) async {
    final db = await database;
    await db.insert(
      _tasksTableName,
      {
        _taskContentColumnName: content,
        _tasksStatusColumnName: day,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await database;
    return await db.query(_tasksTableName);
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _tasksTableName,
      where: '$_tasksIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getItemByName(String name) async {
    final db = await database;
    return await db.query(
      _tasksTableName,
      where: '$_taskContentColumnName = ?',
      whereArgs: [name],
    );
  }
}
