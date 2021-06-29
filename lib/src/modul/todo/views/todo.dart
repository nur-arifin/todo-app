import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/modul/auth/controller/auth_controller.dart';
import 'package:todoapp/src/modul/todo/controller/todo_controller.dart';
import 'package:todoapp/src/modul/user/controller/user_controller.dart';
import 'package:todoapp/src/services/fireDB.dart';
import 'package:todoapp/src/utils/theme.dart';
import 'package:todoapp/src/widgets/todoalert.dart';
import 'package:todoapp/src/widgets/todocard.dart';

class Todo extends StatelessWidget {
  final AuthController _authController = Get.find();
  final ThemeController _themeController = Get.find();

  getUserName() {
    return GetX<UserController>(
      init: Get.put(UserController()),
      initState: (_) async {
        Get.find<UserController>().user =
            await FireDb().getUser(Get.find<AuthController>().user!.uid);
      },
      builder: (_userController) {
        return Text(
          (_userController.user.id == null)
              ? ""
              : _userController.user.name.toString() + " Todos",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getUserName(),
        centerTitle: false,
        actions: [
          Switch(
            value: _themeController.isDark,
            onChanged: _themeController.changeTheme,
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () {
                 TodoAlert().exitDailog();
              }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.isDarkMode ? Colors.white : Colors.lightBlue,
        child: Icon(Icons.add),
        onPressed: () {
          TodoAlert().addTodoDailog();
        },
      ),
      body: GetX<TodoController>(
        init: Get.put<TodoController>(TodoController()),
        builder: (TodoController todoController) {
          if (todoController.todos.isNotEmpty) {
            return Container(
              child: ListView.builder(
                itemCount: todoController.todos.length,
                itemBuilder: (_, index) {
                  return TodoCard(
                      uid: _authController.user!.uid,
                      todo: todoController.todos[index]);
                },
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
