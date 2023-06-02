import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'helper/DatabaseHelper.dart';
import 'routes/APPRouter.dart';
import 'theme/APPThemeSettings.dart';
import 'widget/ExpandableFab.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

///全局
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //Warning: Don't arbitrarily adjust the position of calling the BotToastInit function
  final botToastBuilder = BotToastInit(); //1. call BotToastInit
  @override
  Widget build(BuildContext context) {
    final app = GetMaterialApp(
      key: navigatorKey,
      title: '保险箱',
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
      debugShowCheckedModeBanner: false,
      theme: APPThemeSettings.instance.themeData,
      // theme: ThemeData.light() ,
      // darkTheme: APPThemeSettings.instance.darkThemeData,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // initialRoute: "/MyHomePage",
      // routes: kRoutes,
      initialRoute: AppPage.INITIAL,
      getPages: AppPage.routes,
      unknownRoute: AppPage.unknownRoute,
      routingCallback: (routing) {
        // if (routing != null) {
        //   ddlog([routing.previous, routing.current]);
        // }
      },
      // routes: {
      //     "/": (context) => MyHomePage(),
      //     "/TwoPage": (context) => TwoPage(),
      //   },
    );
    return app;
  }
}

