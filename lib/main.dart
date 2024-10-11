// lib/main.dart

import 'package:flutter/material.dart';
import 'package:todo_bloc_app/app.dart';
import 'package:todo_bloc_app/data/local/task_database.dart';
import 'package:todo_bloc_app/data/repositories/task_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final taskDatabase = TaskDatabase();
  final taskRepository = TaskRepository(taskDatabase: taskDatabase);

  runApp(
    MyApp(taskRepository: taskRepository),
  );
}
