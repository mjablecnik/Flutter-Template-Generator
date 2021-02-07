import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftg_project_template/models/item.dart';
import 'package:ftg_project_template/views/dialog.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/constants.dart';
import 'package:ftg_project_template/controllers/jottings.dart';

class JottingsView extends StatelessWidget {
  final JottingsController controller;

  JottingsView(this.controller);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("HashCode: " + controller.hashCode.toString())),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => controller.goNext(controller.items[index]),
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(5),
                color: controller.getItemColor(controller.items[index].runtimeType),
                child: Center(
                  child: Text(controller.items[index].name),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ButtonBar(
        buttonMinWidth: Get.width / 3.5,
        alignment: MainAxisAlignment.center,
        children: <RaisedButton>[
          buildButton(context, title: "Add note", type: ItemType.note),
          buildButton(context, title: "Add todo", type: ItemType.todo),
          buildButton(context, title: "Add folder", type: ItemType.folder),
        ],
      ),
    );
  }

  RaisedButton buildButton(BuildContext context, {title: String, type: ItemType}) {
    return RaisedButton(
      child: Text(title),
      onPressed: () => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: title,
              model: Item(""),
              onSubmit: (item) => controller.addItem(item.name, type),
            );
          },
        )
      },
    );
  }
}
