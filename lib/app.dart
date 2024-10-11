// lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/task_bloc.dart';
import 'package:todo_bloc_app/data/repositories/task_repository.dart';
import 'package:todo_bloc_app/ui/screens/main_screen.dart';
import 'package:todo_bloc_app/utils/constants.dart';

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  const MyApp({super.key, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: taskRepository,
      child: BlocProvider(
        create: (_) => TaskBloc(taskRepository: taskRepository),
        child: MaterialApp(
          title: AppConstants.appName,
          theme: ThemeData(
            primarySwatch:  Colors.blueGrey,
          ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}
