import 'package:flutter/material.dart';

class TextInputAccount extends StatefulWidget {
  int id;
  final String name;
  final String hintText;
  final bool? isRequired;
  final bool? canRemove; // 是否可以删除这个字段
  final bool? canEditTitle; // 是否可以编辑标题字段
  final TextEditingController controller1;
  final TextEditingController controller2;
  final FocusNode? focusNode;
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
      required this.controller1,
      required this.controller2,
      this.focusNode,
      this.hintText = "",
      this.isRequired = false,
      this.canRemove = false,
      this.canEditTitle = true,
      this.onClickRemove});

  @override
  State<StatefulWidget> createState() => TextInputAccountState();

  String titleText = "";
  String contentText = "";

  bool isDefaultField() {
    if (name == TextInputAccount.defaultName ||
        name == TextInputAccount.defaultAccount ||
        name == TextInputAccount.defaultPwd) {
      return true;
    }
    return false;
  }
}

class TextInputAccountState extends State<TextInputAccount> {
  final GlobalKey<FormFieldState> textInputAccountKey = GlobalKey();

  void focusContent() {
    if (widget.focusNode != null) {
      // textInputAccountKey.currentState!.didChange("");
      // textInputAccountKey.currentState!.validate();
      widget.focusNode!.requestFocus();
    }
  }

  @override
  void initState() {
    if (widget.name == TextInputAccount.defaultName) {
      widget.controller1.text = "*" "名称";
    } else if (widget.name == TextInputAccount.defaultAccount) {
      widget.controller1.text = "账号";
    } else if (widget.name == TextInputAccount.defaultPwd) {
      widget.controller1.text = "密码";
    }

    widget.titleText = widget.controller1.text;
    widget.controller1.addListener(() {
      widget.titleText = widget.controller1.text;
    });

    widget.contentText = widget.controller2.text;
    widget.controller2.addListener(() {
      widget.contentText = widget.controller2.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: widget.canEditTitle,
          controller: widget.controller1,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '请输入名称',
          ),
        ),
        TextFormField(
          controller: widget.controller2,
          key: textInputAccountKey,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // 可以自定义圆角大小
            ),
            hintText: widget.hintText,
            suffixIcon:
                widget.controller2.text.isEmpty && !widget.isDefaultField()
                    ? IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // controller1.clear();
                          // controller2.clear();
                          if (widget.onClickRemove != null) {
                            widget.onClickRemove!(widget.id);
                          }
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          // controller1.clear();
                          widget.controller2.clear();
                        },
                      ),
          ),
        ),
      ],
    );
  }
}
