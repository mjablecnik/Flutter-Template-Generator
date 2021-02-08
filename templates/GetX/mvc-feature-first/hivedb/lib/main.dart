import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ftg_project_template/common/constants.dart';
import 'package:ftg_project_template/items/item_controller.dart';
import 'package:ftg_project_template/jottings/jottings_controller.dart';
import 'package:ftg_project_template/jottings/models/todo.dart';
import 'package:ftg_project_template/jottings/models/note.dart';
import 'package:ftg_project_template/jottings/models/folder.dart';
import 'package:ftg_project_template/home/home_view.dart';
import 'package:ftg_project_template/jottings/jottings_view.dart';
import 'package:ftg_project_template/items/item_view.dart';
import 'package:ftg_project_template/dialog/dialog_controller.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(NoteAdapter())
    ..registerAdapter(TodoListAdapter())
    ..registerAdapter(TodoItemAdapter())
    ..registerAdapter(FolderAdapter());

  await Hive.openBox<Note>(ItemType.note.toString());
  await Hive.openBox<TodoList>(ItemType.todo.toString());
  await Hive.openBox<Folder>(ItemType.folder.toString());

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
        GetPage(name: Routes.JOTTINGS, page: () => JottingsView(JottingsController())),
      ]),
  );
}
