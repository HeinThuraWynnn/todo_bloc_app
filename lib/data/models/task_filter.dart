// lib/data/models/task_filter.dart

enum TaskFilter {
  all,        // To show all tasks
  completed,  // To show only completed tasks
  incomplete  // To show only incomplete tasks
}

// You can also add helper methods or extensions if needed

extension TaskFilterExtension on TaskFilter {
  String get name {
    switch (this) {
      case TaskFilter.all:
        return 'All';
      case TaskFilter.completed:
        return 'Completed';
      case TaskFilter.incomplete:
        return 'Incomplete';
    }
  }
}
