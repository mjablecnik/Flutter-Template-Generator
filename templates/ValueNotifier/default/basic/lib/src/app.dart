import 'package:flutter/material.dart';
import 'package:ftg_project_template/src/users/user_list_controller.dart';
import 'package:ftg_project_template/src/users/user_list_view.dart';

class UserListApp extends StatelessWidget {
  final UserListController controller;

  const UserListApp({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List/Detail Demo',
      theme: ThemeData.dark(),
      home: UserListView(controller: controller),
    );
  }
}
