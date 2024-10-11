// lib/data/repositories/task_repository.dart

import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:todo_bloc_app/data/local/task_database.dart';
import 'package:todo_bloc_app/data/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:todo_bloc_app/utils/constants.dart';

class TaskRepository {
  final TaskDatabase taskDatabase;
  List<Task> _tasks = [];

  TaskRepository({required this.taskDatabase});
  Future<List<Task>> fetchTasksFromApi() async {
    final response = await http.get(Uri.parse(AppConstants.baseUrl.toString()));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Task> tasksFromApi =
          List<Task>.from(data.map((json) => Task.fromJson(json)));
      return tasksFromApi;
    } else {
      throw Exception('Failed to load tasks from API');
    }
  }

  Future<List<Task>> fetchTasks() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Internet is available, fetch tasks from API
      try {
        _tasks = await fetchTasksFromApi();

        await taskDatabase.deleteAllTasks();
        for (var task in _tasks) {
          await taskDatabase.insertTask(task);
        }
      } catch (e) {
        throw Exception('Failed to fetch tasks from API: $e');
      }
    } else {
      // No internet, fetch tasks from local database
      
    }
    return await taskDatabase.getTasks();
  }

  Future<Map<String, dynamic>> createTask(Task task) async {
    final response = await http.post(
      Uri.parse(AppConstants.baseUrl.toString()),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': task.title,
        'description': task.description,
        'isCompleted': false,
      }),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      final responseCreated = await createTask(task);
      final createdTask = Task.fromJson(responseCreated);
      await taskDatabase.insertTask(createdTask);
      _tasks.add(createdTask);
    } catch (e) {
      throw Exception('Failed to add task');
    }
  }

  Future<Map<String, dynamic>> updateTaskAPI(Task task) async {
    // Use PUT for updating an existing task
    final response = await http.put(
      Uri.parse(AppConstants.baseUrl + '/${task.id}'.toString()),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': task.title,
        'description': task.description,
        'isCompleted': task.isCompleted,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<void> updateTask(Task task) async {
    final responseUpdated = await updateTaskAPI(task);
    final updatedTask = Task.fromJson(responseUpdated);
    await taskDatabase.updateTask(updatedTask);
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  Future<void> deleteTaskAPI(String taskId) async {
    final response = await http.delete(
      Uri.parse(AppConstants.baseUrl + '/$taskId'.toString()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> deleteTask(String taskId) async {
    await deleteTaskAPI(taskId);
    await taskDatabase.deleteTask(taskId);
    _tasks.removeWhere((task) => task.id == taskId);
  }
}
