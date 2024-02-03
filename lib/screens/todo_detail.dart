import 'package:first_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoDetail extends StatefulWidget {
  TodoDetail({super.key, this.todo, this.index});

  final Todo? todo;
  final int? index;

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  var todoTitleController = TextEditingController();
  var isNew = false;

  @override
  void initState() {
    super.initState();
    isNew = widget.todo == null;
    todoTitleController.text = (widget.todo == null) ? "" : widget.todo!.title;
  }

  @override
  void dispose() {
    super.dispose();
    todoTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.todo == null) ? "New todo" : widget.todo!.title),
      ),
      body: TextField(
        controller: todoTitleController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isNew) {
            context.read<TodoModel>().add(
                  todoTitleController.text,
                );
          } else {
            context.read<TodoModel>().updateAt(widget.todo!.id,
                widget.todo!.copyWith(title: todoTitleController.text));
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
