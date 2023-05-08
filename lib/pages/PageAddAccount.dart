import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safebox/model/AccountBean.dart';
import '../helper/DatabaseHelper.dart';
import '../widget/TextInputAccount.dart';

// 添加账号页面
@immutable
class PageAddAccount extends StatefulWidget {
  const PageAddAccount({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PageAddAccountState();
  }
}

class _PageAddAccountState extends State<PageAddAccount> {
  final dbHelper = DatabaseHelper.instance;
  List<Widget> _childWidgets = [];
  final ScrollController _scrollController = ScrollController();
  int itemId = 3; // 从3开始数

  // 初始化组件列表
  List<Widget> _buildItems() {
    List<Widget> items = [
      ElevatedButton(
        onPressed: () async {
          print(await dbHelper.accountBeans());
        },
        child: const Text(
          '查询结果',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 4,
          ),
        ),
      ),
      TextInputAccount(
          id: 0,
          name: TextInputAccount.defaultName,
          hintText: "请输入...",
          isRequired: true,
          canEditTitle: false),
      TextInputAccount(
          id: 1,
          name: TextInputAccount.defaultAccount,
          hintText: "请输入...",
          canEditTitle: false),
      TextInputAccount(
          id: 2,
          name: TextInputAccount.defaultPwd,
          hintText: "请输入...",
          canEditTitle: false)
    ];

    return items;
  }

  // 添加一个自定义的组件
  void _addCustomWidget() {
    setState(() {
      _childWidgets.add(TextInputAccount(
        id: itemId++,
        name: "",
        hintText: "请输入...",
        canEditTitle: true,
        onClickRemove: (int value) {
          debugPrint("删除 $value 的ID的控件");
          _removeCustomWidget(value);
        },
      ));

      print("修改后的 $_childWidgets");
    });

    // 使用animateTo函数将页面滚动到底部
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _removeCustomWidget(int id) {
    setState(() {
      _childWidgets.removeWhere((element) => isNeedToRemove(element, id));
      print("删除后的 $_childWidgets");
    });
  }

  bool isNeedToRemove(Widget element, int id) {
    if (element is TextInputAccount) {
      if (element.id == id) return true;
    }
    return false;
  }

  void _saveAccount() {
    List<CustomField> customFields = [];
    for (var element in _childWidgets) {
      if (element is TextInputAccount) {
        customFields.add(
            CustomField(name: element.titleText, content: element.contentText));
      }
    }
    AccountBean accountBean = AccountBean(customFields: customFields);
    dbHelper.insert(accountBean);
  }

  Future<void> getAllResults() async {
    print(await dbHelper.accountBeans()); // Prints Fido with age 42.
  }

  @override
  void initState() {
    super.initState();
    _childWidgets = _buildItems(); // 初始化_childWidgets
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('添加新账号'),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: SizedBox(
            height: 86,
            width: double.infinity,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    _saveAccount();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 设置圆角弧度
                    ),
                  ),
                  child: Transform.translate(
                    offset: const Offset(0, -1),
                    child: const Text(
                      '保存',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                ),
              ).paddingSymmetric(horizontal: 20),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController, // 将滚动控制器传递给SingleChildScrollView
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(children: [
                ..._childWidgets,
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      _addCustomWidget();
                    },
                    child: const Text(
                      '添加更多字段',
                    ),
                  ).paddingOnly(top: 12, bottom: 10),
                ),
              ])),
        ));
  }
}
