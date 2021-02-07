import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:ftg_project_template/src/users/user.dart';
import 'package:ftg_project_template/src/users/user_list_controller.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    // Begin loading the users when the User List is first shown.
    context.read(userControllerProvider).loadUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Consumer(
        builder: (context, watch, child) {
          final controller = watch(userControllerProvider);

          if (controller.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              var user = controller.users[index];

              return ListTile(
                title: Text('User #${user.id}'),
                onTap: () =>
                    Navigator.pushNamed(context, '/user', arguments: user),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final newUser = User(Random().nextInt(1000));
          context.read(userControllerProvider).addUser(newUser);
        },
      ),
    );
  }
}
