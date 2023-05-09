import 'package:flutter/material.dart';

class AccountItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const AccountItem({Key? key, required this.title, required this.subtitle,  this.onTap})
      : super(key: key);

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ListTile(
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        subtitle:
        Text(widget.subtitle, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
