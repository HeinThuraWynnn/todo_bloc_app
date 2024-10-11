// lib/ui/widgets/task_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/task_bloc.dart';
import 'package:todo_bloc_app/bloc/task_event.dart';
import 'package:todo_bloc_app/data/models/task_model.dart';
import 'package:todo_bloc_app/ui/screens/add_edit_task_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(task.id));
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Task "${task.title}" deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _toggleCompletion(BuildContext context) {
    BlocProvider.of<TaskBloc>(context).add(ToggleTaskCompletionEvent(task.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            task.isCompleted ? 'Marked as incomplete' : 'Marked as completed'),
      ),
    );
  }

  void _editTask(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => _toggleCompletion(context),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      subtitle: Text(task.description),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit') {
            _editTask(context);
          } else if (value == 'delete') {
            _confirmDelete(context);
          }
        },
        itemBuilder: (ctx) => [
          const PopupMenuItem(
            value: 'edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
