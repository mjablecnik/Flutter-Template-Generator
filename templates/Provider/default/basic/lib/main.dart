import 'package:flutter/material.dart';
import 'package:ftg_project_template/src/app.dart';
import 'package:ftg_project_template/src/users/user_list_controller.dart';
import 'package:ftg_project_template/src/users/user_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserController(UserRepository()),
      child: MyApp(),
    ),
  );
}
