import 'dart:ffi';

import 'package:flutter/material.dart';

class TextInputAccount extends StatefulWidget {
  int id;
  final String name;
  final String hintText;
  final bool? isRequired;
  final bool? canRemove; // 是否可以删除这个字段
  final bool? canEditTitle; // 是否可以编辑标题字段

  static String defaultName = "default_name";
  static String defaultAccount = "default_account";
  static String defaultPwd = "default_pwd";

  final void Function(int)? onClickRemove; // 点击删除的回调

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return '输入框id:$id';
  }

  TextInputAccount(
      {super.key,
      required this.id,
      required this.name,
      this.hintText = "",
      this.isRequired = false,
      this.canRemove = false,
      this.canEditTitle = true,
      this.onClickRemove});

  @override
  State<StatefulWidget> createState() => _IconTextFieldState();

  String titleText = "";
  String contentText = "";
}

class _IconTextFieldState extends State<TextInputAccount> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  bool isDefaultField() {
    if (widget.name == TextInputAccount.defaultName ||
        widget.name == TextInputAccount.defaultAccount ||
        widget.name == TextInputAccount.defaultPwd) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    // 销毁 TextEditingController
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }


  @override
  void initState() {
    if (widget.name == TextInputAccount.defaultName) {
      _controller1.text = "*" "名称";
    } else if (widget.name == TextInputAccount.defaultAccount) {
      _controller1.text = "账号";
    } else if (widget.name == TextInputAccount.defaultPwd) {
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
            hintText: '请输入名称',
          ),
        ),
        TextFormField(
          controller: _controller2,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // 可以自定义圆角大小
            ),
            hintText: widget.hintText,
            suffixIcon: _controller2.text.isEmpty && !isDefaultField()
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // _controller1.clear();
                      // _controller2.clear();
                      if (widget.onClickRemove != null) {
                        widget.onClickRemove!(widget.id);
                      }
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      // _controller1.clear();
                      _controller2.clear();
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
