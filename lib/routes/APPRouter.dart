// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safebox/pages/PageAddAccount.dart';

import '../pages/APPNotFoundPage.dart';
import '../pages/PageHome.dart';

///https://www.jianshu.com/p/b9d6ec92926f
class APPRouter {
  static const notFound = '/APPNotFoundPage';
  static const homePage = '/HomePage';
  static const addAccountPage = '/AddAccountPage';
}

class AppPage {
  static const INITIAL = APPRouter.homePage;

  static final unknownRoute = GetPage(
    name: APPRouter.notFound,
    page: () => APPNotFoundPage(),
  );

  static final List<GetPage> routes = [
    unknownRoute,
    GetPage(
      name: APPRouter.homePage,
      page: () => PageHome(),
    ),
    GetPage(
      name: APPRouter.addAccountPage,
      page: () => PageAddAccount(),
    ),
  ];
}
