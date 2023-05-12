import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safebox/model/AccountBean.dart';
import 'package:safebox/routes/APPRouter.dart';
import 'package:safebox/theme/APPThemeSettings.dart';
import 'package:safebox/utils/UIUtils.dart';
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

final dbHelper = DatabaseHelper.instance;

class _PageHomeState extends State<PageHome> {
  List<AccountBean> _items = [];
  bool _loading = false;

  void jumpToAddAccount(AccountBean? accountBean) {
    debugPrint("去添加账号页面 $accountBean");
    Get.toNamed(APPRouter.addAccountPage, arguments: accountBean);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // setState(() => _loading = true);
    // 模拟异步加载数据
    List<AccountBean> data = await dbHelper.accountBeans();
    setState(() {
      // _loading = false;
      _items = data;
    });
  }

  Future<void> _handleRefresh() async {
    await _loadData();
  }

  void _handleListItemTap(int index) {
    debugPrint('Item $index 点击了 ${_items[index]}');
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        builder: (BuildContext context) =>
            CustomBottomSheet(
              user: _items[index],
            ));
  }

  void _handleListItemLongTap(int index) {
    debugPrint('Item $index 长按了 ${_items[index]}');
    AccountBean bean = _items[index];
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        builder: (BuildContext context) =>
            BottomMenuSheet(
              user: bean,
              onConfirmDelete: () {
                showDeleteDialog(context, bean);
              },
              onTapCopAndNew: () {
                jumpToAddAccount(bean);
              },
            ));
  }


  Future<void> deleteAccount(AccountBean bean) async {
    debugPrint('删除账号 $bean');
    int result = await dbHelper.delete(bean);
    debugPrint('删除 $bean 操作已完成，结果：$result');
    if (context.mounted) UIUtils.showSuccessBar(context, "账号已删除");
    _loadData();
  }

  void showDeleteDialog(BuildContext context, AccountBean bean) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text('删除确认',
              style: TextStyle(color: Colors.black87, fontSize: 18)),
          content: Text("您确定要删除账号\"${bean.name}\"？",
              style: TextStyle(color: APPThemeSettings.myBgColorMap[700])),
          actions: <Widget>[
            TextButton(
              child: Text('取消',
                  style: TextStyle(color: APPThemeSettings.myBgColorMap[400])),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('删除', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      deleteAccount(bean);
    }
  }

  Widget _buildListView() {
    return AzListView(
      data: _items,
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) =>
          AccountItem(
            title: _items[index].name,
            subtitle: _items[index].account ?? "无",
            onTap: () => _handleListItemTap(index),
            onLongTap: () => _handleListItemLongTap(index),
          ),
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
              onPressed: () => jumpToAddAccount(null)),
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

  const CustomBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        color: Colors.white,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.8,
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

class BottomMenuSheet extends StatelessWidget {
  final AccountBean user;

  const BottomMenuSheet(
      {super.key, required this.user, this.onConfirmDelete, this.onTapCopAndNew});

  final VoidCallback? onConfirmDelete;
  final VoidCallback? onTapCopAndNew;

  @override
  Widget build(BuildContext context) {
    double menuHeight = 50;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直方向居中对齐
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 12),
            SizedBox(
              width: 88,
              height: 5,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: APPThemeSettings.myBgColorMap[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: menuHeight,
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('加入收藏'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(), // 分割线
            SizedBox(
                height: menuHeight,
                child: ListTile(
                  leading: const Icon(Icons.add_to_photos),
                  title: const Text('复制并新建'),
                  onTap: () {
                    Navigator.pop(context);
                    onTapCopAndNew?.call();
                  },
                )),
            const Divider(), // 分割线
            SizedBox(
                height: menuHeight,
                child: ListTile(
                  leading: const Icon(Icons.content_copy),
                  title: const Text('复制为文本'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
            const Divider(), // 分割线
            SizedBox(
                height: menuHeight,
                child: ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title:
                  const Text('删除此账号', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    onConfirmDelete?.call();
                  },
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
