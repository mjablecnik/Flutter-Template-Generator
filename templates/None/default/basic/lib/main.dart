import 'package:flutter/material.dart';
import 'package:ftg_project_template/src/user_list.dart';
import 'package:ftg_project_template/src/user_repository.dart';

void main() {
  runApp(MyApp(
    repository: UserRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository repository;

  const MyApp({Key key, @required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List/Detail Demo',
      theme: ThemeData.dark(),
      home: MyListPage(repository: repository),
    );
  }
}
