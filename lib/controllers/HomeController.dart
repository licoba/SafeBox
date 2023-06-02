import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/DatabaseHelper.dart';
import '../model/AccountBean.dart';
import '../model/LeftImageObject.dart';
import '../widget/ToastUtil.dart';

class HomeController extends GetxController {
  final dbHelper = DatabaseHelper.instance;
  RxBool loading = true.obs;
  RxList<AccountBean> accountList = <AccountBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    // loading.value = true; // 设置为加载状态
    // 模拟异步加载数据
    await (parseJsonFile());
    List<AccountBean> data = await dbHelper.accountBeans();
    accountList.assignAll(data);
    // loading.value = false; // 设置为非加载状态
  }

  // 解析 JSON 文件并映射到 LeftImageObject 对象列表中
  Future<List<LeftImageObject>> parseJsonFile() async {
    String jsonData = await rootBundle.loadString('assets/data/brand_models.json');
    List<dynamic> jsonList = json.decode(jsonData);
    List<LeftImageObject> list = jsonList.map((json) => LeftImageObject.fromJson(json)).toList();
    Get.put(list);
    return list;
  }


  Future<void> deleteAccount(AccountBean bean) async {
    debugPrint('删除账号 $bean');
    int result = await dbHelper.delete(bean);
    debugPrint('删除 $bean 操作已完成，结果：$result');
    _loadData();
    ToastUtil.showSuccess(icon: Icons.delete_outlined, message: "账号已删除");
  }

  Future<void> addAccount(AccountBean bean) async {
    debugPrint('添加账号 $bean');
    await dbHelper.insert(bean);
    _loadData();
  }
}
