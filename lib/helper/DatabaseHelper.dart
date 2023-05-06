import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import '../model/Account.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// 参考博客：
/// https://www.tutorialkart.com/flutter/flutter-sqlite-tutorial/
/// https://github.com/OpenFlutter/flutter_database_demo
/// https://flutter.cn/docs/cookbook/persistence/sqlite  (官方)
class DatabaseHelper {
  static const databaseName = "account_database.db";
  static const databaseVersion = 1;
  static const tableName = 'account_table';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnAccount = 'account';
  static const columnPwd = 'pwd';
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get db async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + databaseName;
    var carsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return carsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnAccount TEXT,
            $columnPwd TEXT
          )
          ''');
  }

  Future<int> insert(AccountBean bean) async {
    Database db = await this.db;
    debugPrint("插入账号 $bean");
    return await db.insert(
      tableName,
      bean.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 读取数据列表
  Future<List<AccountBean>> accountBeans() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return AccountBean(
        id: maps[i]['id'],
        name: maps[i]['name'],
        account: maps[i]['account'],
        pwd: maps[i]['pwd'],
      );
    });
  }
}
