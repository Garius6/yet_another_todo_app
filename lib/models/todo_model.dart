import 'package:flutter/material.dart';

class TodoModel extends ChangeNotifier {
  List<String> _todos = [];

  List<String> get todos => _todos;

  int get length => _todos.length;
  void addTodo(String todo) {
    _todos.add(todo);
    notifyListeners();
  }
}
