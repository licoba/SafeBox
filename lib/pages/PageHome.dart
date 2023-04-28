import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safebox/routes/APPRouter.dart';
import '../widget/ExpandableFab.dart';

// 首页
@immutable
class PageHome extends StatelessWidget {
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

  void _jumpToAddAccount() {
    Get.toNamed(APPRouter.addAccountPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('保险箱'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: 25,
          itemBuilder: (context, index) {
            return FakeItem(isBig: index.isOdd);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print("FloatingActionButton"),
          child: IconButton(
              icon: Icon(Icons.add), onPressed: () => _jumpToAddAccount()),
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
