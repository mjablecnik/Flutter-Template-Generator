import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ftg_project_template/src/user.dart';
import 'package:ftg_project_template/src/user_details.dart';
import 'package:ftg_project_template/src/user_list_controller.dart';

class UserListPage extends StatefulWidget {
  final UserController controller;

  const UserListPage({Key key, @required this.controller}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    // Begin loading the users when the User List is first shown.
    widget.controller.loadUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Observer(
        builder: (context) {
          if (widget.controller.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (widget.controller.hasError) {
            return Center(child: Icon(Icons.error));
          }

          return ListView.builder(
            itemCount: widget.controller.users.length,
            itemBuilder: (context, index) {
              var user = widget.controller.users[index];

              return Dismissible(
                key: ObjectKey(user),
                onDismissed: (_) => widget.controller.removeUser(user),
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text('User #${user.id}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailsPage(user: user),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          widget.controller.addUser(User(Random().nextInt(1000)));
        },
      ),
    );
  }
}
