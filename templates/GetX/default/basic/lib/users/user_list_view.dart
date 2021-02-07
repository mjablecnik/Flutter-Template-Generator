import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/constants.dart';
import 'package:ftg_project_template/users/user.dart';
import 'package:ftg_project_template/users/user_list_controller.dart';

class UserListView extends GetView<UserController> {

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Obx(() {
          if (controller.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              var user = controller.users[index];

              return ListTile(
                title: Text('User #${user.id}'),
                onTap: () => Get.toNamed(Routes.USER_DETAIL, arguments: user),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final newUser = User(Random().nextInt(1000));
          controller.addUser(newUser);
        },
      ),
    );
  }
}
