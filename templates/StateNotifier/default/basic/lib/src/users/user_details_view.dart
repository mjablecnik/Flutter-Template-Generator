import 'package:flutter/material.dart';
import 'package:ftg_project_template/src/users/user.dart';

class UserDetailsView extends StatelessWidget {
  final User user;

  const UserDetailsView({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Center(
        child: Text('User #${user.id}'),
      ),
    );
  }
}
