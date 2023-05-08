import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import '../model/AccountBean.dart';
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
  static const columnCustomFields = 'customFields';
  static const columnName = 'name';
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
            $columnCustomFields TEXT
          )
          ''');
  }

  Future<int> insert(AccountBean bean) async {
    Database db = await this.db;
    debugPrint("插入账号 $bean");
    // 将 bean 对象转换成 Map 类型，以便将其存储到数据库中
    final data = {
      columnCustomFields: json.encode(bean.customFields?.map((e) => e.toJson()).toList()),
    };
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 读取数据列表
  Future<List<AccountBean>> accountBeans() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      final id = maps[index][columnId];
      final customFieldsJson = maps[index][columnCustomFields];
      final customFieldsMapList = json.decode(customFieldsJson ?? '') as List<
          dynamic>?;
      final customFields = customFieldsMapList?.map((e) =>
          CustomField.fromJson(e)).toList();
      return AccountBean(
        id: id,
        customFields: customFields,
      );
    });
  }
}
