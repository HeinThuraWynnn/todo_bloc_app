// lib/ui/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:todo_bloc_app/ui/screens/add_edit_task_screen.dart';
import 'package:todo_bloc_app/ui/screens/task_filter.dart';
import 'package:todo_bloc_app/ui/widgets/task_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEditTaskScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TaskFilterWidget(),
          ),
          Expanded(
            child: TaskList(),
          ),
        ],
      ),
    );
  }
}
