import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/TodoController.dart';
import 'package:getx_todo_app/pages/TodoPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
        appBar: AppBar(
          title: Text('Página Inicial'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(TodoPage());
          },
        ),
        body: Container(
          child: Obx(() => ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      var removed = todoController.todos[index];
                      todoController.todos.removeAt(index);
                      Get.snackbar('Task Removida',
                          'A task ${removed.text} foi removida com sucesso!',
                          mainButton: FlatButton(
                              child: Text('Desfazer'),
                              onPressed: () {
                                if (removed.isNull) {
                                  return;
                                }
                                todoController.todos.insert(index, removed);
                                removed = null;
                                if (Get.isSnackbarOpen) {
                                  Get.back();
                                }
                              }));
                    },
                    child: ListTile(
                      title: Text(todoController.todos[index].text,
                          style: (todoController.todos[index].done)
                              ? TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough)
                              : TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color,
                                )),
                      onTap: () {
                        Get.to(TodoPage(
                          index: index,
                        ));
                      },
                      leading: Checkbox(
                        value: todoController.todos[index].done,
                        onChanged: (v) {
                          var changedController = todoController.todos[index];
                          changedController.done = v;
                          todoController.todos[index] = changedController;
                        },
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
              separatorBuilder: (_, __) => Divider(),
              itemCount: todoController.todos.length)),
        ));
  }
}
