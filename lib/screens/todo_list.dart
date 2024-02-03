import 'package:first_app/models/todo_model.dart';
import 'package:first_app/screens/todo_detail.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList(
    this.todos, {
    super.key,
  });

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
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
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              onTap: () {
                print("tapped of ${todos[index]}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoDetail(todo: todos[index])),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
