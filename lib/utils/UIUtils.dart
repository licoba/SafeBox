import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class UIUtils {
  static void showSnackBar(BuildContext context, String text) {
    // ScaffoldMessenger.of(context)
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(SnackBar(
    //     content: Text(text),
    //     duration: const Duration(seconds: 1),
    //   ));
    Flushbar(
      title: 'Hello',
      message: 'This is a demo of Another Flushbar!',
      duration: const Duration(seconds: 1),
      icon: Icon(Icons.info_outline, color: Colors.blue[300]),
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);

  }

  static void showSuccessBar(BuildContext context, String text) {
    FlushbarHelper.createSuccess(
            message: text, duration: const Duration(seconds: 1))
        .show(context);
  }
}
