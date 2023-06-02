//
//  APPThemeSettings.dart
//  flutter_templet_project
//
//  Created by shang on 7/14/21 2:18 PM.
//  Copyright © 7/14/21 shang. All rights reserved.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class APPThemeSettings {
  static final APPThemeSettings _instance = APPThemeSettings._();

  APPThemeSettings._();

  factory APPThemeSettings() => _instance;

  static APPThemeSettings get instance => _instance;
  static const Map<int, Color> myBgColorMap = {
    50: Color(0xFFECECEC),
    100: Color(0xFFD8D8D8),
    200: Color(0xFFC4C4C4),
    300: Color(0xFFB1B1B1),
    400: Color(0xFF9D9D9D),
    500: Color(0xFF898989),
    600: Color(0xFF757575),
    700: Color(0xFF626262),
    800: Color(0xFF4E4E4E),
    900: Color(0xFF3A3A3A),
  };

  ThemeData themeData = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    indicatorColor: Colors.white,
    brightness: Brightness.light,
    //设置明暗模式为白天模式
    splashColor: Colors.transparent,
    // 点击时的高亮效果设置为透明
    highlightColor: Colors.grey,
    // 长按时的扩散效果设置为透明
    iconTheme: const IconThemeData(color: Colors.black),//设置icon主题色为黑色
    primaryTextTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 20),
      toolbarTextStyle: TextStyle(color: Colors.black,fontSize: 20),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      // style: ButtonStyle()
    ),
    outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle()
    ),
    scaffoldBackgroundColor: const MaterialColor(0xFFFFFFFF, myBgColorMap),
 
    // primarySwatch: const MaterialColor(
    //   0xFF03A9F4,
    //   <int, Color>{
    //     50: Color(0xFFE1F5FE),
    //     100: Color(0xFFB3E5FC),
    //     200: Color(0xFF81D4FA),
    //     300: Color(0xFF4FC3F7),
    //     400: Color(0xFF29B6F6),
    //     500: Color(0xFF03A9F4),
    //     600: Color(0xFF039BE5),
    //     700: Color(0xFF0288D1),
    //     800: Color(0xFF0277BD),
    //     900: Color(0xFF01579B),
    //   },
    // ), // 创建一个名为myPrimaryColor的自定义颜色，并定义了多个不同的色块,
  );

  // ThemeData? darkThemeData;
  ThemeData darkThemeData = ThemeData.dark().copyWith(
      // accentColor: Colors.tealAccent[200]!,
      // brightness: Brightness.dark,//设置明暗模式为暗色
      // accentColor: Colors.grey[900]!,//(按钮）Widget前景色为黑色
      // primaryColor: Colors.white,//主色调为青色
      // splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
      // highlightColor: Colors.transparent, // 长按时的扩散效果设置为透明
      // iconTheme: IconThemeData(color: Colors.white54),//设置icon主题色为黄色
      // // textTheme: TextTheme(body1: TextStyle(color: Colors.red))//设置文本颜色为红色
      // buttonColor: Colors.tealAccent[200]!,
      // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
      // appBarTheme: ThemeData.dark().appBarTheme.copyWith(
      //   color: Colors.black54,
      // ),
      // indicatorColor: Colors.white,
      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle(
      //     foregroundColor: MaterialStateProperty.all(Colors.tealAccent[200]!),
      //     textStyle: MaterialStateProperty.all(TextStyle(color: Colors.tealAccent[200]!)),
      //   ),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all(Colors.tealAccent[200]!),
      //     )
      // ),
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: ButtonStyle(
      //     foregroundColor: MaterialStateProperty.all(Colors.tealAccent[200]!),
      //     // textStyle: MaterialStateProperty.all(TextStyle(color: e)),
      //   ),
      // ),
      );

  late ScrollController? actionScrollController = ScrollController();

  void showThemePicker({
    required BuildContext context,
    required void Function() callback,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actionScrollController: actionScrollController,
              title: const Text("请选择主题色"),
              // message: Text(message),
              actions: _buildActions(context: context, callback: callback),
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('取消'),
              ),
            ));
  }

  _buildActions({
    required BuildContext context,
    required void Function() callback,
  }) {
    return colors.map((e) {
      final text = e
          .toString()
          .replaceAll('MaterialColor(primary value:', '')
          .replaceAll('MaterialAccentColor(primary value:', '')
          .replaceAll('))', ')');

      return Container(
          color: e,
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {
                  changeThemeLight(e);
                  Navigator.pop(context);
                  callback();
                },
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    backgroundColor: e,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ));
    }).toList();
  }

  void changeTheme() {
    // Get.changeTheme(Get.isDarkMode? ThemeData.light() : ThemeData.dark());
    Get.changeTheme(Get.isDarkMode ? themeData : darkThemeData);
  }

  void changeThemeLight(Color e) {
    themeData = ThemeData.light().copyWith(
      primaryColor: e,
      splashColor: Colors.transparent,
      // 点击时的高亮效果设置为透明
      highlightColor: Colors.transparent,
      // scaffoldBackgroundColor: e,
      appBarTheme: ThemeData.light().appBarTheme.copyWith(color: e),
      indicatorColor: Colors.white,
      iconTheme: ThemeData.light().iconTheme.copyWith(
            color: e,
          ),
      textTheme: ThemeData.light().textTheme.apply(
            // bodyColor: Colors.pink,
            // displayColor: Colors.pink,
            decoration: TextDecoration.none,
          ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(e),
          // textStyle: MaterialStateProperty.all(TextStyle(color: Colors.red)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(e),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(e),
          // textStyle: MaterialStateProperty.all(TextStyle(color: e)),
        ),
      ),
      switchTheme: ThemeData.light().switchTheme.copyWith(
          // thumbColor: e,
          trackColor: MaterialStateProperty.all(e)),
      bottomNavigationBarTheme:
          ThemeData.light().bottomNavigationBarTheme.copyWith(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: e,
                selectedIconTheme: IconThemeData(color: e),
                selectedLabelStyle: const TextStyle(fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontSize: 12),
              ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: e,
        // textTheme:
        // primaryContrastingColor: Colors.red,
        // barBackgroundColor: Colors.red,
        // scaffoldBackgroundColor: Colors.red,
      ),
      colorScheme: ThemeData.light()
          .colorScheme
          .copyWith(secondary: e)
          .copyWith(secondary: e),
    );
    Get.changeTheme(themeData);
  }

  final List<Color> colors = [
    // Colors.black,
    // Colors.red,
    // Colors.teal,
    // Colors.pink,
    // Colors.amber,
    // Colors.orange,
    // Colors.green,
    // Colors.blue,
    // Colors.lightBlue,
    // Colors.purple,
    // Colors.deepPurple,
    // Colors.indigo,
    // Colors.cyan,
    // Colors.brown,
    // Colors.grey,
    // Colors.blueGrey,

    ...Colors.primaries,
    ...Colors.accents,
  ];
}
