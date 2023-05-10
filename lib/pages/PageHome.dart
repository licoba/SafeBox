import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safebox/model/AccountBean.dart';
import 'package:safebox/routes/APPRouter.dart';
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
