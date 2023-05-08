import 'dart:ffi';

import 'package:flutter/material.dart';

class TextInputAccount extends StatefulWidget {
  final String name;
  final String hintText;
  final bool? isRequired;
  final bool? canRemove; // 是否可以删除这个字段
  final bool? canEditTitle; // 是否可以编辑标题字段

  final TextEditingController controller;

  const TextInputAccount(
      {super.key,
      required this.name,
      required this.hintText,
      required this.controller,
      this.isRequired = false,
      this.canRemove = false,
      this.canEditTitle = true});

  @override
  State<StatefulWidget> createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<TextInputAccount> {
  @override
  Widget build(BuildContext context) {
    String titleText = "";
    if (widget.name.isNotEmpty) {
      titleText = "${widget.isRequired! ? "*" : ""} ${widget.name}";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: widget.canEditTitle,
          controller: TextEditingController(text: titleText),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '请输入...',
          ),
        ),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // 可以自定义圆角大小
            ),
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                widget.controller.clear();
              },
            ),
          ),
        ),
      ],
    );
  }
}
