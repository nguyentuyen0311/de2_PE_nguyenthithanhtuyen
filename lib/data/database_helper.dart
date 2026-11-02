import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;


  final List<Expense> _webExpenses = [
    Expense(id: 1, title: 'Ăn uống', amount: 150000, category: 'Sinh hoạt', date: '29/10/2026'),
    Expense(id: 2, title: 'Di chuyển', amount: 50000, category: 'Đi lại', date: '28/10/2026'),
    Expense(id: 3, title: 'Mua sách', amount: 200000, category: 'Học tập', date: '27/10/2026'),
    Expense(id: 4, title: 'Mua sắm', amount: 1500000, category: 'Sinh hoạt', date: '25/10/2026'),
    Expense(id: 5, title: 'Khám bệnh', amount: 3550000, category: 'Sức khỏe', date: '22/10/2026'),
  ];

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.insert('expenses', {
      'title': 'Ăn uống',
      'amount': 150000,
      'category': 'Sinh hoạt',
      'date': '29/10/2026'
    });
    await db.insert('expenses', {
      'title': 'Di chuyển',
      'amount': 50000,
      'category': 'Đi lại',
      'date': '28/10/2026'
    });
    await db.insert('expenses', {
      'title': 'Mua sách',
      'amount': 200000,
      'category': 'Học tập',
      'date': '27/10/2026'
    });
    await db.insert('expenses', {
      'title': 'Mua sắm',
      'amount': 1500000,
      'category': 'Sinh hoạt',
      'date': '25/10/2026'
    });
    await db.insert('expenses', {
      'title': 'Khám bệnh',
      'amount': 3550000,
      'category': 'Sức khỏe',
      'date': '22/10/2026'
    });
  }

  Future<List<Expense>> getExpenses() async {
    if (kIsWeb) {
      return List.from(_webExpenses);
    }
    final db = await instance.database;
    final result = await db.query('expenses', orderBy: 'id ASC');
    return result.map((json) => Expense.fromMap(json)).toList();
  }

  Future<int> updateExpense(Expense expense) async {
    if (kIsWeb) {
      final index = _webExpenses.indexWhere((e) => e.id == expense.id);
      if (index != -1) {
        _webExpenses[index] = expense;
      }
      return 1;
    }
    final db = await instance.database;
    return db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }
}
