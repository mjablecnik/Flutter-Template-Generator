import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftg_project_template/jottings/models/item.dart';
import 'package:ftg_project_template/dialog/dialog_view.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/items/item_controller.dart';

class BasicView extends GetView<BasicController> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.simpleList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              color: Colors.amber[600],
              margin: const EdgeInsets.all(3),
              child: Center(
                child: Text(controller.simpleList[index].name),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                title: "Add new item",
                model: Item(""),
                onSubmit: (item) => controller.addItem(item),
              );
            },
          )
        },
      ),
    );
  }
}
