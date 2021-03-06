import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/modul/todo/model/todo_model.dart';
import 'package:todoapp/src/services/fireDB.dart';
import 'package:todoapp/src/widgets/todoalert.dart';

class TodoCard extends StatelessWidget {
  final String? uid;
  final TodoModel? todo;

  const TodoCard({Key? key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo!.todoId!),
      background: Container(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.edit),
              ),
            ],
          )),
      secondaryBackground: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.delete),
              ),
            ],
          )),
      direction: DismissDirection.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          TodoAlert().editTodoDailog(todo!);
          return false;
        } else {
          return true;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          FireDb().deleteTodo(todo!, uid!);
        }
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(10, 7, 10, 2.5),
        child: Container(
          margin: EdgeInsets.all(5),
          child: ListTile(
            trailing: Transform.scale(
              scale: 1.3,
              child: Checkbox(
                activeColor: Colors.green,
                checkColor: Colors.white,
                shape: CircleBorder(),
                value: todo!.done,
                onChanged: (newValue) {
                  todo!.done = newValue;
                  FireDb().updateTodo(
                    todo!,
                    uid!,
                  );
                },
              ),
            ),
            title: GestureDetector(
              onTap: () {
                TodoAlert().editTodoDailog(todo!);
              },
              child: Text(
                todo!.content!,
                style: TextStyle(
                    decoration:
                        (todo!.done!) ? TextDecoration.lineThrough : null,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: (todo!.done!)
                        ? Colors.green
                        : context.isDarkMode
                            ? Colors.white
                            : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
