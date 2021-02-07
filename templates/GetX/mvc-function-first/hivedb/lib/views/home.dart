import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/constants.dart';
import 'package:ftg_project_template/controllers/basic.dart';


class HomeView extends GetView<BasicController> {

  @override
  Widget build(context) {
    return Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
      appBar: AppBar(
        title: Obx(
          () => Text("Clicks: ${controller.count}"),
        ),
      ),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Go to simple list"),
              onPressed: () => Get.toNamed(Routes.BASIC),
            ),
            RaisedButton(
              child: Text("Go to Jottings"),
              onPressed: () => Get.toNamed(Routes.JOTTINGS),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.increment,
      ),
    );
  }
}

