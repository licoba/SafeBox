import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/APPRouter.dart';
import 'widget/ExpandableFab.dart';

void main() {
  runApp(const MyApp());
}

///全局
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = GetMaterialApp(
      key: navigatorKey,
      title: '保险箱',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
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
