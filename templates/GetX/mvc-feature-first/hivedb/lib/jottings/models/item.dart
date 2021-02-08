
import 'package:ftg_project_template/jottings/models/note.dart';
import 'package:ftg_project_template/jottings/models/todo.dart';
import 'package:hive/hive.dart';
import 'package:ftg_project_template/common/constants.dart';

import 'folder.dart';


class Item {

  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> path = List<String>();

  @HiveField(2)
  DateTime created = DateTime.now();

  @HiveField(3)
  DateTime lastChange = DateTime.now();

  get id => [...this.path, name].join("/");

  Item(this.name, {this.path, this.created, this.lastChange});


  static String getKeyByItem(Item item) {
    if (item.path != null && item.path.isNotEmpty) {
      return pathSeparator + item.path.join(pathSeparator) + pathSeparator + item.name;
    } else {
      return pathSeparator + item.name;
    }
  }

  static String getKey(String name, List<String> path) {
    return getKeyByItem(Item(name, path: path));
  }

  factory Item.create(name, { List<String> path, ItemType type }) {
    switch (type) {
      case ItemType.note:
        return Note.create(name, path: path);
        break;
      case ItemType.todo:
        return TodoList.create(name, path: path);
        break;
      case ItemType.folder:
        return Folder.create(name, path: path);
        break;
      default:
        return null;
        break;
    }
  }
}