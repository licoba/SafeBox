
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/DatabaseHelper.dart';
import '../model/AccountBean.dart';
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
    List<AccountBean> data = await dbHelper.accountBeans();
    accountList.assignAll(data);
    // loading.value = false; // 设置为非加载状态
  }

  Future<void> deleteAccount(AccountBean bean) async {
    debugPrint('删除账号 $bean');
    int result = await dbHelper.delete(bean);
    debugPrint('删除 $bean 操作已完成，结果：$result');
    _loadData();
    ToastUtil.showSuccess("账号已删除");
  }



  Future<void> addAccount(AccountBean bean) async {
    debugPrint('添加账号 $bean');
    await dbHelper.insert(bean);
    _loadData();
    ToastUtil.showSuccess("账号已添加");

  }
}
