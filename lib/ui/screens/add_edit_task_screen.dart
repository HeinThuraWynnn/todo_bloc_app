// lib/ui/screens/add_edit_task_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/task_bloc.dart';
import 'package:todo_bloc_app/bloc/task_event.dart';
import 'package:todo_bloc_app/data/models/task_model.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final task = Task(
        id: widget.task?.id,
        title: _title,
        description: _description,
        isCompleted: widget.task?.isCompleted ?? false,
      );

      if (widget.task == null) {
        BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(task));
      } else {
        BlocProvider.of<TaskBloc>(context).add(UpdateTaskEvent(task));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!.trim(),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!.trim(),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? 'Update Task' : 'Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
