import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ftg_project_template/common/constants.dart';
import 'package:ftg_project_template/items/item_controller.dart';
import 'package:ftg_project_template/dialog/dialog_controller.dart';
import 'package:ftg_project_template/home/home_view.dart';
import 'package:ftg_project_template/items/item_view.dart';


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
        GetPage(name: Routes.ITEMS, page: () => BasicView()),
      ]),
  );
}
