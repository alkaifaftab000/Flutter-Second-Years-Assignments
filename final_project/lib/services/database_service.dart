import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/expense.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'expenses.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY, title TEXT, amount REAL, category TEXT, date TEXT)',
        );
      },
    );
  }

  Future<void> addExpense(Expense expense) async {
    final db = await getDatabase();
    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Expense>> getExpenses() async {
    final db = await getDatabase();
    final maps = await db.query('expenses', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Expense.fromMap(maps[i]));
  }

  Future<void> deleteExpense(int id) async {
    final db = await getDatabase();
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalExpenses() async {
    final db = await getDatabase();
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM expenses',
    );
    final total = result.isNotEmpty ? result.first['total'] : 0;
    return (total as num?)?.toDouble() ?? 0.0;
  }

  Future<List<Expense>> searchExpenses(String query) async {
    final db = await getDatabase();
    final maps = await db.query(
      'expenses',
      where: 'title LIKE ? OR category LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => Expense.fromMap(maps[i]));
  }

  Future<Map<String, double>> getCategoryStats() async {
    final db = await getDatabase();
    final result = await db.rawQuery(
      'SELECT category, SUM(amount) as total FROM expenses GROUP BY category',
    );
    final stats = <String, double>{};
    for (var row in result) {
      stats[row['category'] as String] =
          (row['total'] as num?)?.toDouble() ?? 0.0;
    }
    return stats;
  }

  Future<double> getMonthlyTotal(DateTime date) async {
    final db = await getDatabase();
    final year = date.year;
    final month = date.month;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM expenses WHERE strftime("%Y-%m", date) = ?',
      ['$year-${month.toString().padLeft(2, '0')}'],
    );
    final total = result.isNotEmpty ? result.first['total'] : 0;
    return (total as num?)?.toDouble() ?? 0.0;
  }
}
