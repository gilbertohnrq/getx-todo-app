import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/TodoController.dart';
import 'package:getx_todo_app/models/Todo.dart';

class TodoPage extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();
  final int index;

  TodoPage({this.index});

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!this.index.isNull) {
      text = todoController.todos[index].text;
    }

    TextEditingController textEditingController =
        TextEditingController(text: text);
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Digite seu todo',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none),
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 999,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 60.0,
                    icon: Icon(Icons.cancel),
                    color: Colors.red,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  IconButton(
                    iconSize: 60.0,
                    icon: Icon((this.index.isNull)
                        ? Icons.add_circle
                        : Icons.check_circle),
                    color: Colors.green,
                    onPressed: () {
                      if (this.index.isNull) {
                        todoController.todos
                            .add(Todo(text: textEditingController.text));
                      } else {
                        var editing = todoController.todos[index];
                        editing.text = textEditingController.text;
                        todoController.todos[index] = editing;
                      }
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
