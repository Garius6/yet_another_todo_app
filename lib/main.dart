import 'dart:math';

import 'package:first_app/models/todo_model.dart';
import 'package:first_app/screens/todo_detail.dart';
import 'package:first_app/screens/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoModel(),
    child: TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (context, todos, child) => TodoList(todos.todos),
    );
  }
}
