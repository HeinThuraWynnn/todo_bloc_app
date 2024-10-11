// lib/ui/widgets/task_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/task_bloc.dart';
import 'package:todo_bloc_app/bloc/task_state.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.isRealTimeUpdated) {
          // Show SnackBar when tasks are updated via real-time updates
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tasks have been updated every 10s in real-time.'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.filteredTasks.isEmpty) {
          return const Center(child: Text('No tasks available.'));
        }

        return ListView.builder(
          itemCount: state.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = state.filteredTasks[index];
            return TaskItem(task: task);
          },
        );
      },
    );
  }
}
