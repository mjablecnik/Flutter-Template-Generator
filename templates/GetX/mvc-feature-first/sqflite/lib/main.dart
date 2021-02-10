import 'package:flutter/material.dart';
import 'package:ftg_project_template/tracker/dialog_controller.dart';
import 'package:ftg_project_template/tracker/list_controller.dart';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ftg_project_template/constants.dart';
import 'package:ftg_project_template/tracker/repository.dart';
import 'package:ftg_project_template/tracker/table.dart';
import 'package:ftg_project_template/home/home_view.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'tracker.db');

  var db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(TrackerTable.createQuery);
    },
  );

  runApp(
    GetMaterialApp(
        smartManagement: SmartManagement.full,
        initialRoute: Routes.HOME,
        initialBinding: BindingsBuilder(() {
          Get.lazyPut(() => TrackerRepository(db), fenix: true);
          Get.lazyPut(() => TrackerListController(), fenix: true);
          Get.lazyPut(() => DialogController(), fenix: true);
          Get.lazyPut(() => ScrollController(), fenix: true);
        }),
        getPages: [
          GetPage(name: Routes.HOME, page: () => HomeView()),
        ]),
  );
}
