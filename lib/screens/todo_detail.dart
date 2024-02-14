import 'package:date_field/date_field.dart';
import 'package:yet_another_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoDetail extends StatefulWidget {
  const TodoDetail({super.key, this.todo, this.index});

  final Todo? todo;
  final int? index;

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  var todoTitleController = TextEditingController();
  var isNew = false;
  DateTime? plannedDate;

  @override
  void initState() {
    super.initState();
    isNew = widget.todo == null;
    todoTitleController.text = (widget.todo == null) ? "" : widget.todo!.title;
    plannedDate = (widget.todo == null) ? null : widget.todo!.plannedDate;
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
      body: Column(
        children: [
          TextField(
            controller: todoTitleController,
          ),
          DateTimeFormField(
              initialValue: plannedDate,
              onChanged: (date) {
                setState(() {
                  plannedDate = date;
                });
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (isNew) {
            context
                .read<TodoModel>()
                .add(todoTitleController.text, plannedDate: plannedDate);
          } else {
            context.read<TodoModel>().updateAt(widget.todo!.copyWith(
                title: todoTitleController.text, plannedDate: plannedDate));
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
