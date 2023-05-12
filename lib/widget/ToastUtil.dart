import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safebox/theme/APPThemeSettings.dart';

class ToastUtil {
  static void showSuccess({IconData? icon = Icons.check, required String message}) {
    debugPrint("showSuccess $message");
    int seconds = 1;
    bool crossPage = true;
    bool clickClose = false;
    bool ignoreContentClick = false;
    bool onlyOne = true;
    int backgroundColor = 0x00000000;
    int animationMilliseconds = 200;
    int animationReverseMilliseconds = 200;
    BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;
    BotToast.showText(text: message);

    BotToast.showCustomText(
      duration: Duration(seconds: seconds),
      onlyOne: onlyOne,
      clickClose: clickClose,
      crossPage: crossPage,
      ignoreContentClick: ignoreContentClick,
      backgroundColor: Color(backgroundColor),
      backButtonBehavior: backButtonBehavior,
      animationDuration: Duration(milliseconds: animationMilliseconds),
      animationReverseDuration:
          Duration(milliseconds: animationReverseMilliseconds),
      toastBuilder: (_) => Align(
        alignment: const Alignment(0, 0.8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  icon ?? Icons.check,
                  color: Colors.green,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(message),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showToast(String message) {
    debugPrint("showToast $message");
    int seconds = 1;
    bool crossPage = true;
    bool clickClose = false;
    bool ignoreContentClick = false;
    bool onlyOne = true;
    int backgroundColor = 0x00000000;
    int animationMilliseconds = 200;
    int animationReverseMilliseconds = 200;
    BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;
    BotToast.showText(text: message);

    BotToast.showCustomText(
      duration: Duration(seconds: seconds),
      onlyOne: onlyOne,
      clickClose: clickClose,
      crossPage: crossPage,
      ignoreContentClick: ignoreContentClick,
      backgroundColor: Color(backgroundColor),
      backButtonBehavior: backButtonBehavior,
      animationDuration: Duration(milliseconds: animationMilliseconds),
      animationReverseDuration:
          Duration(milliseconds: animationReverseMilliseconds),
      toastBuilder: (_) => Align(
        alignment: const Alignment(0, 0.8),
        child: Card(
          elevation: 4.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(message),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showLongToast() {
    debugPrint("showLongToast");
    Fluttertoast.showToast(
      msg: "This is Long Toast",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.black54,
      fontSize: 18.0,
    );
  }

  static void showWebColoredToast() {
    Fluttertoast.showToast(
      msg: "This is Colored Toast with android duration of 5 Sec",
      toastLength: Toast.LENGTH_SHORT,
      webBgColor: "#e74c3c",
      textColor: Colors.white,
      backgroundColor: Colors.black54,
      timeInSecForIosWeb: 5,
    );
  }

  static void showColoredToast() {
    Fluttertoast.showToast(
        msg: "This is Colored Toast with android duration of 5 Sec",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  static void showShortToast() {
    Fluttertoast.showToast(
        msg: "This is Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black54,
        timeInSecForIosWeb: 1);
  }

  static void showTopShortToast() {
    Fluttertoast.showToast(
        msg: "This is Top Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1);
  }

  static void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  static void cancelToast() {
    Fluttertoast.cancel();
  }
}
