import 'package:first_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoDetail extends StatefulWidget {
  TodoDetail({
    super.key,
    this.todo,
  });

  String? todo;
  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  var todoTitleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    todoTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo ?? "New todo"),
      ),
      body: TextField(
        controller: todoTitleController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TodoModel>().addTodo(todoTitleController.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
