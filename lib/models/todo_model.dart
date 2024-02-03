import 'package:flutter/material.dart';

class TodoModel extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  int _lastTodoId = 0;

  int get length => _todos.length;

  void add(String title, [bool isDone = false]) {
    var todo = Todo(id: _lastTodoId++, title: title, isDone: isDone);
    _todos.add(todo);
    notifyListeners();
  }

  void updateAt(int id, Todo todo) {
    var index = _todos.indexWhere((t) => t.id == id);
    _todos[index] = todo;
    notifyListeners();
  }
}

@immutable
class Todo {
  const Todo({required this.id, required this.title, this.isDone = true});

  final int id;
  final String title;
  final bool isDone;

  Todo copyWith({int? id, String? title, bool? isDone}) => Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone);
}
