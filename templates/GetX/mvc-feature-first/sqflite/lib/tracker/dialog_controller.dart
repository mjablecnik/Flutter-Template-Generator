import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class DialogController extends GetxController {

  final TextEditingController dialogInput = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var model;
  String title;
  Function onSubmit;

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      onSubmit.call(model);
      clearText();
      Get.back();
    }
  }

  void clearText() => dialogInput.text = "";

}
