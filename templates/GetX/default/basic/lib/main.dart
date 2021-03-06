import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/users/user_details_view.dart';
import 'package:ftg_project_template/users/user_list_controller.dart';
import 'package:ftg_project_template/users/user_list_view.dart';
import 'package:ftg_project_template/users/user_repository.dart';

import 'constants.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'List/Detail Demo',
      smartManagement: SmartManagement.full,
      initialRoute: Routes.USER_LIST,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => UserController(), fenix: true);
        Get.lazyPut(() => UserRepository(), fenix: true);
      }),
      getPages: [
        GetPage(name: Routes.USER_LIST, page: () => UserListView()),
        GetPage(name: Routes.USER_DETAIL, page: () => UserDetailsView()),
      ],
    ),
  );
}
