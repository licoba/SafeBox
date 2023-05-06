import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/TextInputAccount.dart';

// 添加账号页面
@immutable
class PageAddAccount extends StatelessWidget {
  const PageAddAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
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
                  onPressed: () {},
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
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 16.0),
              child: Column(
                children: [
                  TextInputAccount(
                      name: "名称", hintText: "请输入...", controller: controller,isRequired:true),
                  const SizedBox(height: 16), //保留间距
                  TextInputAccount(
                      name: "账号", hintText: "请输入...", controller: controller),
                  const SizedBox(height: 16), //保留间距
                  TextInputAccount(
                      name: "密码", hintText: "请输入...", controller: controller),
                  const SizedBox(height: 16), //保留间距
                  TextInputAccount(
                      name: "自定义1", hintText: "请输入...", controller: controller),
                  const SizedBox(height: 26), //保留间距
                  TextInputAccount(
                      name: "自定义2", hintText: "请输入...", controller: controller),
                  const SizedBox(height: 26), //保留间距
                  TextInputAccount(
                      name: "自定义3", hintText: "请输入...", controller: controller),
                  const SizedBox(height: 26), //保留间距
                  TextInputAccount(
                      name: "自定义3", hintText: "请输入...", controller: controller),
                  const SizedBox(height: 26), //保留间距
                  TextInputAccount(
                      name: "自定义3", hintText: "请输入...", controller: controller),
                  const SizedBox(height: 26), //保留间距
                ],
              )),
        ));
  }
}
