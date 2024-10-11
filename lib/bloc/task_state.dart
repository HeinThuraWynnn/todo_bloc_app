// lib/bloc/task_state.dart

import 'package:todo_bloc_app/data/models/task_filter.dart';
import 'package:todo_bloc_app/data/models/task_model.dart';

class TaskState {
  final List<Task> tasks;
  final TaskFilter filter;
  final bool isLoading;
  final bool isRealTimeUpdated;  

  TaskState({
    required this.tasks,
    this.filter = TaskFilter.all,
    this.isLoading = false,
    this.isRealTimeUpdated = false,
  });

  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.incomplete:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.all:
      default:
        return tasks;
    }
  }

  TaskState copyWith({
    List<Task>? tasks,
    TaskFilter? filter,
    bool? isLoading,
    bool? isRealTimeUpdated,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      isRealTimeUpdated: isRealTimeUpdated ?? this.isRealTimeUpdated,
    );
  }
}
