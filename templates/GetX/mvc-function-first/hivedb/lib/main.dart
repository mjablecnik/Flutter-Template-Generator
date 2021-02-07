import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ftg_project_template/constants.dart';
import 'package:ftg_project_template/controllers/basic.dart';
import 'package:ftg_project_template/controllers/jottings.dart';
import 'package:ftg_project_template/models/todo.dart';
import 'package:ftg_project_template/models/note.dart';
import 'package:ftg_project_template/models/folder.dart';
import 'package:ftg_project_template/views/home.dart';
import 'package:ftg_project_template/views/jottings.dart';
import 'package:ftg_project_template/views/basic.dart';
import 'package:ftg_project_template/controllers/dialog.dart';
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
        GetPage(name: Routes.BASIC, page: () => BasicView()),
        GetPage(name: Routes.JOTTINGS, page: () => JottingsView(JottingsController())),
      ]),
  );
}
