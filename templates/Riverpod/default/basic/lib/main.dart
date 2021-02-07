import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:ftg_project_template/src/app.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
