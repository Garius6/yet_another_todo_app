import 'package:first_app/models/todo_model.dart';
import 'package:first_app/screens/todo_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, model, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TodoDetail()));
          },
        ),
        body: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: model.todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: model.todos[index].isDone,
                  onChanged: (value) {
                    model.updateAt(
                      model.todos[index].id,
                      model.todos[index].copyWith(isDone: value),
                    );
                  },
                ),
                title: Text(model.todos[index].title),
                subtitle: Text((model.todos[index].plannedDate == null)
                    ? ""
                    : DateFormat("dd-MM-yyyy HH:mm")
                        .format(model.todos[index].plannedDate!)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TodoDetail(todo: model.todos[index])),
                  );
                },
              );
            },
          ),
        ),
      );
    });
  }
}
