import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/modul/auth/controller/auth_controller.dart';
import 'package:todoapp/src/modul/auth/views/login.dart';
import 'package:todoapp/src/modul/todo/views/todo.dart';
import 'package:todoapp/src/modul/user/controller/user_controller.dart';

class Root extends GetWidget<AuthController> {
  //Just For Switching to Home to Login
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user != null) {
          //Need to Find Controller for user instance
          return Todo();
        } else {
          return Login();
        }
      },
    );
  }
}