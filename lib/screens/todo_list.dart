import 'package:yet_another_todo_app/models/todo_model.dart';
import 'package:yet_another_todo_app/screens/todo_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TodoDetail()));
        },
      ),
      body: const SafeArea(
        child: TodoList(),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (context, model, child) {
        return FutureBuilder(
          future: model.todos,
          builder: (context, data) {
            if (!data.hasData) {
              return const Center(
                child: Text("Loading..."),
              );
            }
            var todos = data.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: todos[index].isDone,
                    onChanged: (value) {
                      model.updateAt(
                        todos[index].id,
                        todos[index].copyWith(isDone: value),
                      );
                    },
                  ),
                  title: Text(todos[index].title),
                  subtitle: Text((todos[index].plannedDate == null)
                      ? ""
                      : DateFormat("dd-MM-yyyy HH:mm")
                          .format(todos[index].plannedDate!)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodoDetail(todo: todos[index])),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
