import 'package:yet_another_todo_app/models/todo_model.dart';
import 'package:yet_another_todo_app/screens/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoModel(),
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: MediaQuery.of(context).platformBrightness),
      ),
      home: const TodoListScreen(),
    );
  }
}
