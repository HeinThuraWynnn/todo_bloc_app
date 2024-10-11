// lib/bloc/task_event.dart

import 'package:todo_bloc_app/bloc/task_state.dart';
import 'package:todo_bloc_app/data/models/task_filter.dart';
import 'package:todo_bloc_app/data/models/task_model.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {

}

class AddTaskEvent extends TaskEvent {
  final Task task;

  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent(this.taskId);
}

class ToggleTaskCompletionEvent extends TaskEvent {
  final String taskId;

  ToggleTaskCompletionEvent(this.taskId);
}

class FilterTasksEvent extends TaskEvent {
  final TaskFilter filter;

  FilterTasksEvent(this.filter);
}

class RealTimeUpdateEvent extends TaskEvent {
  
}

class TaskError extends TaskEvent {
  final String message;
  TaskError(this.message);
}