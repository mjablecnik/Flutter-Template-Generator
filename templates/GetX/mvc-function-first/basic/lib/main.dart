import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ftg_project_template/constants.dart';
import 'package:ftg_project_template/controllers/basic.dart';
import 'package:ftg_project_template/controllers/dialog.dart';
import 'package:ftg_project_template/views/home.dart';
import 'package:ftg_project_template/views/basic.dart';


Future<void> main() async {

  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      initialRoute: Routes.HOME,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BasicController(), fenix: true);
        Get.lazyPut(() => DialogController(), fenix: true);
      }),
      getPages: [
        GetPage(name: Routes.HOME, page: () => HomeView()),
        GetPage(name: Routes.BASIC, page: () => BasicView()),
      ]),
  );
}
