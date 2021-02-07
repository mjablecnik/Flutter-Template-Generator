import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftg_project_template/models/item.dart';
import 'package:ftg_project_template/views/dialog.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/controllers/basic.dart';

class BasicView extends GetView<BasicController> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.simpleList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              margin: const EdgeInsets.all(5),
              color: Colors.amber[600],
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
                title: "Add new tracker",
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
