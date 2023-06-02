import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safebox/utils/GlobalData.dart';

class LeftImageObject {
  String name;
  String englishName;
  String imgUrl;

  LeftImageObject(
      {required this.name, required this.englishName, required this.imgUrl});

  factory LeftImageObject.fromJson(Map<String, dynamic> json) {
    return LeftImageObject(
      name: json['name'],
      englishName: json['englishName'],
      imgUrl: json['imgUrl'],
    );
  }

  static String getImgUrl(String name) {
    String url = "";
    Get.find<List<LeftImageObject>>().forEach((element) {
      if (element.name.toLowerCase().contains(name.toLowerCase()) ||
          name.toLowerCase().contains(element.name.toLowerCase())) {
        url = "assets/images/${element.imgUrl}";
      } else if (element.englishName
          .toLowerCase()
          .contains(name.toLowerCase()) || name.toLowerCase().contains(element.englishName.toLowerCase())) {
        url = "assets/images/${element.imgUrl}";
      }
    });
    // debugPrint("url:" + url);
    return url;
  }
}
