import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/modul/auth/controller/auth_controller.dart';
import 'package:todoapp/src/modul/todo/model/todo_model.dart';
import 'package:todoapp/src/modul/user/controller/user_controller.dart';
import 'package:todoapp/src/services/fireDB.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>([]);

  List<TodoModel> get todos => todoList.value;

  @override
  @mustCallSuper
  void onInit() async {
    //var fireUser = Get.find<AuthController>().user;
    clear();
    Get.find<UserController>().user =
        await FireDb().getUser(Get.find<AuthController>().user!.uid);
    var user = Get.find<UserController>().user;

    todoList.bindStream(FireDb()
        .todoStream(user.id!)); //stream coming from firebase For todo List
    super.onInit();
  }

  void clear() {
    this.todoList.value = <TodoModel>[];
  }
}