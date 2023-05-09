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
  static const columnName = 'name';
  static const columnAccount = 'account';
  static const columnPwd = 'pwd';
  static const columnCustomFields = 'customFields';
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
    debugPrint("=========初始化数据库=========");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/$databaseName";
    debugPrint("=========数据库路径=========> $path");
    var carsDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return carsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    debugPrint("=========创建表=========");
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT,
            $columnAccount TEXT,
            $columnPwd TEXT,
            $columnCustomFields TEXT
          )
          ''');
  }

  Future<int> insert(AccountBean bean) async {
    Database db = await this.db;
    debugPrint("插入账号 $bean");
    // 将 bean 对象转换成 Map 类型，以便将其存储到数据库中
    final data = {
      columnName: bean.name,
      columnAccount: bean.account,
      columnPwd: bean.pwd,
      columnCustomFields:
      json.encode(bean.customFields?.map((e) => e.toJson()).toList()),
    };
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTable() async {
    Database db = await this.db;
    await db.execute('DROP TABLE IF EXISTS $tableName');
    await db.close();
  }


  // 读取数据列表
  Future<List<AccountBean>> accountBeans() async {
    Database db = await this.db;
    // await deleteTable();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      print("数据：${maps[index]}");
      final id = maps[index][columnId];
      final name = maps[index][columnName];
      final account = maps[index][columnAccount];
      final pwd = maps[index][columnPwd];
      final customFieldsJson = maps[index][columnCustomFields];
      final customFieldsMapList =
      json.decode(customFieldsJson ?? '') as List<dynamic>?;
      final customFields =
      customFieldsMapList?.map((e) => CustomField.fromJson(e)).toList();
      return AccountBean(
        id: id,
        name: name,
        account: account,
        pwd: pwd,
        customFields: customFields,
      );
    });
  }
}
