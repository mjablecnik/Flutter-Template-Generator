import 'package:ftg_project_template/models/item.dart';
import 'package:get/get.dart';

class BasicController extends GetxController {
  var count = 0.obs;
  List<Item> simpleList = [Item("test1"), Item("test2")].obs;

  increment() => count++;

  addItem(Item item) {
    simpleList.add(item);
  }
}