import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/modul/auth/controller/auth_controller.dart';
import 'package:todoapp/src/modul/todo/model/todo_model.dart';
import 'package:todoapp/src/modul/user/controller/user_controller.dart';
import 'package:todoapp/src/services/fireDB.dart';

class TodoAlert {
  TextEditingController _textEditingController = TextEditingController();
  UserController _userController = Get.find();
  AuthController _authController = Get.find();
  exitDailog() {
    Get.defaultDialog(
        title: "WARNING!!",
        content: Container(
            padding: EdgeInsets.all(5), child: Text('APAKAH MAU KELUAR?')),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(
                  "Ok",
                ),
                onPressed: () {
                  _authController.logOut();
                   Get.back();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ]);
  }

  addTodoDailog() {
    Get.defaultDialog(
        title: "Add",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(
                  "Ok",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    FireDb().addTodo(
                        _textEditingController.text, _userController.user.id!);
                    _textEditingController.clear();
                    Get.back();
                  }
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ]);
  }

  editTodoDailog(TodoModel todoModel) {
    _textEditingController.text = todoModel.content!;
    Get.defaultDialog(
        title: "Edit",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(
                  "Edit",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    todoModel.content = _textEditingController.text;
                    FireDb().updateTodo(todoModel, _userController.user.id!);
                    _textEditingController.clear();
                    Get.back();
                  }
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ]);
  }
}
