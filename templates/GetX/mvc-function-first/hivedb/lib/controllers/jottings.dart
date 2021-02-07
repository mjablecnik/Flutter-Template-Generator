import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/constants.dart';
import 'package:ftg_project_template/controllers/dialog.dart';
import 'package:ftg_project_template/models/folder.dart';
import 'package:ftg_project_template/models/item.dart';
import 'package:ftg_project_template/models/note.dart';
import 'package:ftg_project_template/models/todo.dart';
import 'package:ftg_project_template/views/jottings.dart';

class JottingsController extends GetxController {

  List<Item> items = <Item>[].obs;
  Folder _currentFolder;
  DialogController _dialogController;
  List<JottingsController> _openedFolders = [];

  get dialog => _dialogController;

  get id => _currentFolder.id;

  JottingsController([this._currentFolder]) {
    load();
    _dialogController = DialogController();
  }

  addItem(name, ItemType type) async {
    var item = Item.create(name, path: [..._currentFolder.path, _currentFolder.name], type: type);
    this.items.add(item);
    _currentFolder.items.add(item);
    _currentFolder.save();
  }

  removeItem(int index) {
    this.items.removeAt(index);
  }

  editItem() {}

  _loadRootFolder() {
    _currentFolder = Folder.load(rootFolderName, <String>[]);

    if (_currentFolder != null) {
      this.items.addAll(_currentFolder.items);
    } else {
      _currentFolder = Folder.create(rootFolderName, path: <String>[]);
    }
  }

  load() {
    if (_currentFolder == null) {
      _loadRootFolder();
    } else {
      _currentFolder = Folder.load(_currentFolder.name, _currentFolder.path);
      this.items.addAll(_currentFolder.items);
    }
  }

  goNext(Item item) {
    if (item.runtimeType == Folder) {
      var folder = _openedFolders.firstWhere((e) => e.id == item.id, orElse: () => null);
      if (folder == null) {
        folder = JottingsController(item);
        _openedFolders.add(folder);
      }
      print("Going to next folder..");
      Get.to(JottingsView(folder), preventDuplicates: false);
    }
  }

  getItemColor(Type item) {
    switch (item) {
      case Note:
        return Colors.blue;
        break;
      case TodoList:
        return Colors.green;
        break;
      case Folder:
        return Colors.black38;
        break;
      default:
        return Colors.red;
        break;
    }
  }
}