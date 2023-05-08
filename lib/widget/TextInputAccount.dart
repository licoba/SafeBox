import 'dart:ffi';

import 'package:flutter/material.dart';

class TextInputAccount extends StatefulWidget {
  final String name;
  final String hintText;
  final bool? isRequired;
  final bool? canRemove; // 是否可以删除这个字段
  final bool? canEditTitle; // 是否可以编辑标题字段

  static String default_name = "default_name";
  static String default_account = "default_account";
  static String default_pwd = "default_pwd";

  TextInputAccount({
    super.key,
    required this.name,
    required this.hintText,
    this.isRequired = false,
    this.canRemove = false,
    this.canEditTitle = true,
  });

  @override
  State<StatefulWidget> createState() => _IconTextFieldState();

  String titleText = "";
  String contentText = "";
}

class _IconTextFieldState extends State<TextInputAccount> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    if (widget.name == TextInputAccount.default_name) {
      _controller1.text ="*""名称";
    } else if (widget.name == TextInputAccount.default_account) {
      _controller1.text = "账号";
    } else if (widget.name == TextInputAccount.default_pwd) {
      _controller1.text = "密码";
    } 

    widget.titleText = _controller1.text;
    widget.contentText = _controller2.text;
    _controller1.addListener(() {
      setState(() {
        widget.titleText = _controller1.text;
      });
    });

    _controller2.addListener(() {
      setState(() {
        widget.contentText = _controller2.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: widget.canEditTitle,
          controller: _controller1,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '请输入...',
          ),
        ),
        TextFormField(
          controller: _controller2,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // 可以自定义圆角大小
            ),
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller2.clear();
              },
            ),
          ),
        ),
      ],
    );
  }
}
