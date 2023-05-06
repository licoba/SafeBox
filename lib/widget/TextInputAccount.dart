import 'dart:ffi';

import 'package:flutter/material.dart';

class TextInputAccount extends StatefulWidget {
  final String name;
  final String hintText;
  final bool? isRequired;

  final TextEditingController controller;

  const TextInputAccount(
      {super.key,
      required this.name,
      required this.hintText,
      required this.controller,
      this.isRequired = false});

  @override
  State<StatefulWidget> createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<TextInputAccount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.name} ${widget.isRequired! ? "*" : ""} ",
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
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
