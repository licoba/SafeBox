import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safebox/model/AccountBean.dart';
import 'package:safebox/routes/APPRouter.dart';
import 'package:safebox/theme/APPThemeSettings.dart';
import '../helper/DatabaseHelper.dart';
import '../widget/AccountItem.dart';
import '../widget/ExpandableFab.dart';
import 'package:azlistview/azlistview.dart';

// 首页
@immutable
class PageHome extends StatefulWidget {
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  const PageHome({super.key});

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _PageHomeState();
  }
}

class _PageHomeState extends State<PageHome> {
  final dbHelper = DatabaseHelper.instance;
  List<AccountBean> _items = [];
  bool _loading = false;

  // 数据源
  void _jumpToAddAccount() {
    Get.toNamed(APPRouter.addAccountPage);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    // 模拟异步加载数据
    List<AccountBean> data = await dbHelper.accountBeans();

    setState(() {
      _loading = false;
      _items = data;
    });
  }

  Future<void> _handleRefresh() async {
    await _loadData();
  }

  void _handleListItemTap(int index) {
    print('Item $index 点击了 ${_items[index]}');
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        builder: (BuildContext context) => CustomBottomSheet(
              user: _items[index],
            ));
  }

  Widget _buildListView() {
    return AzListView(
      data: _items,
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) => AccountItem(
        title: _items[index].name,
        subtitle: _items[index].account ?? "无",
        onTap: () => _handleListItemTap(index),
      ),
    );

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return AccountItem(
          title: _items[index].customFields?[0].content ?? "无",
          subtitle: _items[index].customFields?[1].content ?? "无",
          onTap: () => _handleListItemTap(index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('保险箱'),
        ),
        body: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _buildListView()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print("FloatingActionButton"),
          child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _jumpToAddAccount()),
        )
        // floatingActionButton: ExpandableFab(
        //   distance: 112.0,
        //   children: [
        //     ActionButton(
        //       onPressed: () => _showAction(context, 0),
        //       icon: const Icon(Icons.format_size),
        //     ),
        //     ActionButton(
        //       onPressed: () => _showAction(context, 1),
        //       icon: const Icon(Icons.insert_photo),
        //     ),
        //     ActionButton(
        //       onPressed: () => _showAction(context, 2),
        //       icon: const Icon(Icons.videocam),
        //     ),
        //   ],
        // ),
        );
  }
}

class User {
  final String name;
  final String email;

  const User({required this.name, required this.email});
}

class TopText extends StatelessWidget {
  final String? content;

  const TopText({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    String textStr = "";
    if (content == null) {
      textStr = "无";
    } else if (content!.isEmpty) {
      textStr = "无";
    } else {
      textStr = content!;
    }
    return Text(
      textStr,
      style: TextStyle(fontSize: 16, color: APPThemeSettings.myBgColorMap[600]),
    );
  }
}

class BottomText extends StatelessWidget {
  final String? content;

  const BottomText({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    String textStr = "";
    if (content == null) {
      textStr = "无";
    } else if (content!.isEmpty) {
      textStr = "无";
    } else {
      textStr = content!;
    }
    return Text(
      textStr,
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}
class CustomBottomSheet extends StatelessWidget {
  final AccountBean user;

  const CustomBottomSheet({required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 66,
              color: APPThemeSettings.myBgColorMap[50],
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(user.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: (user.customFields?.length ?? 0) + 2,
                  itemBuilder: (context, index) {
                    if (index == 0 || index == 1) {
                      String s1 = index == 0 ? "账号" : "密码";
                      String? s2 = index == 0 ? user.account : user.pwd;
                      return Container(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              TopText(content: s1),
                              const SizedBox(height: 4),
                              BottomText(content: s2)
                            ],
                          ));
                    }
                    CustomField customField = user.customFields![index - 2];
                    return Container(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            TopText(content: customField.name),
                            const SizedBox(height: 4),
                            BottomText(content: customField.content)
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
