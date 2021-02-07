import 'package:flutter/material.dart';
import 'package:ftg_project_template/src/app.dart';
import 'package:ftg_project_template/src/users/user_list_controller.dart';
import 'package:ftg_project_template/src/users/user_repository.dart';

void main() async {
  // Setup Repositories which are responsible for storing and retrieving data
  final repository = UserRepository();

  // Setup Controllers which bind Data Storage (Repositories) to Flutter
  // Widgets.
  final controller = UserListController(repository);

  runApp(UserListApp(controller: controller));
}
