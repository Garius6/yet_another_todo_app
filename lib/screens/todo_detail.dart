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
  var _title = "";
  DateTime? _plannedDate;

  final _formKey = GlobalKey<FormState>();
  var _isNew = false;

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isNew) {
      context.read<TodoModel>().add(_title, plannedDate: _plannedDate);
    } else {
      context.read<TodoModel>().updateAt(
          widget.todo!.copyWith(title: _title, plannedDate: _plannedDate));
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _isNew = widget.todo == null;
    _title = (widget.todo == null) ? "" : widget.todo!.title;
    _plannedDate = (widget.todo == null) ? null : widget.todo!.plannedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.todo == null) ? "New todo" : widget.todo!.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Can`t be empty";
                  }
                  return null;
                },
                onChanged: (text) => setState(() {
                  _title = text;
                }),
              ),
              DateTimeFormField(
                  initialValue: _plannedDate,
                  onChanged: (date) {
                    setState(() {
                      _plannedDate = date;
                    });
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        child: const Icon(Icons.save),
      ),
    );
  }
}
