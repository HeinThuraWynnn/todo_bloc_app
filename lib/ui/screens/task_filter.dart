// lib/ui/screens/task_filter.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/task_bloc.dart';
import 'package:todo_bloc_app/bloc/task_event.dart';
import 'package:todo_bloc_app/bloc/task_state.dart';
import 'package:todo_bloc_app/data/models/task_filter.dart';

class TaskFilterWidget extends StatelessWidget {
  const TaskFilterWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilterChip(
              label: const Text('All'),
              selected: state.filter == TaskFilter.all,
              onSelected: (_) {
                BlocProvider.of<TaskBloc>(context)
                    .add(FilterTasksEvent(TaskFilter.all));
              },
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('Completed'),
              selected: state.filter == TaskFilter.completed,
              onSelected: (_) {
                BlocProvider.of<TaskBloc>(context)
                    .add(FilterTasksEvent(TaskFilter.completed));
              },
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('Incomplete'),
              selected: state.filter == TaskFilter.incomplete,
              onSelected: (_) {
                BlocProvider.of<TaskBloc>(context)
                    .add(FilterTasksEvent(TaskFilter.incomplete));
              },
            ),
          ],
        );
      },
    );
  }
}
