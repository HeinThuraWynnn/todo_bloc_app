// lib/bloc/task_bloc.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/task_event.dart';
import 'package:todo_bloc_app/bloc/task_state.dart';
import 'package:todo_bloc_app/data/repositories/task_repository.dart';
import 'package:todo_bloc_app/utils/constants.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  Timer? _realTimeUpdateTimer;

  TaskBloc({required this.taskRepository}) : super(TaskState(tasks: [])) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleTaskCompletionEvent>(_onToggleTaskCompletion);
    on<FilterTasksEvent>(_onFilterTasks);
    on<RealTimeUpdateEvent>(_onRealTimeUpdate);

    // Load tasks initially
    add(LoadTasks());

    // Start real-time updates
    _realTimeUpdateTimer = Timer.periodic(
      AppConstants.realTimeUpdateDuration,
      (_) => add(RealTimeUpdateEvent()),
    );
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    final tasks = await taskRepository.fetchTasks();
    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    await taskRepository.addTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    await taskRepository.updateTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await taskRepository.deleteTask(event.taskId);
    add(LoadTasks());
  }

  Future<void> _onToggleTaskCompletion(
      ToggleTaskCompletionEvent event, Emitter<TaskState> emit) async {
    final task = state.tasks.firstWhere((task) => task.id == event.taskId);
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await taskRepository.updateTask(updatedTask);
    add(LoadTasks());
  }

  Future<void> _onFilterTasks(
      FilterTasksEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onRealTimeUpdate(
    RealTimeUpdateEvent event,
    Emitter<TaskState> emit,
  ) async {
    final tasks = await taskRepository.fetchTasksFromApi();
    emit(state.copyWith(tasks: tasks));
    emit(state.copyWith(isRealTimeUpdated: true));
  }

  @override
  Future<void> close() {
    _realTimeUpdateTimer?.cancel();
    return super.close();
  }
}
