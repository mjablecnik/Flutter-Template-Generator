import 'package:ftg_project_template/src/user_model.dart';

class UserRepository {
  Future<User> user(int id) {
    return Future.delayed(Duration(seconds: 1), () => User(id));
  }

  Future<List<User>> users() {
    return Future.delayed(
      Duration(seconds: 2),
      () => List.generate(20, (index) => User(index)),
    );
  }
}
