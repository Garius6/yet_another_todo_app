import 'package:flutter/material.dart';
import 'package:yet_another_todo_app/data/repository/todo_repository.dart';

class TodoModel extends ChangeNotifier {
  final TodoDatabase _todoDatabase = TodoDatabase();

  Future<List<Todo>> get todos => _todoDatabase.getAllTodos();

  int _lastTodoId = 0;

  void add(String title, {bool isDone = false, DateTime? plannedDate}) {
    var todo = Todo(
        id: _lastTodoId++,
        title: title,
        isDone: isDone,
        plannedDate: plannedDate);
    _todoDatabase.addTodo(todo);
    notifyListeners();
  }

  void updateAt(int id, Todo todo) {
    _todoDatabase.updateTodo(todo);
    notifyListeners();
  }
}

@immutable
class Todo {
  const Todo(
      {required this.title, this.isDone = true, this.plannedDate, this.id = 0});

  final int id;
  final String title;
  final bool isDone;
  final DateTime? plannedDate;

  Todo copyWith(
          {int? id, String? title, bool? isDone, DateTime? plannedDate}) =>
      Todo(
          id: id ?? this.id,
          title: title ?? this.title,
          isDone: isDone ?? this.isDone,
          plannedDate: plannedDate ?? this.plannedDate);
}
