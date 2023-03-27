enum Priority {
  low,
  normal,
  high,
}

class Task {
  final String dateAdded;
  final String title;
  final String description;
  final bool isDone;
  final int priority;
  final String taskId;

  Task(
      {required this.dateAdded,
      required this.title,
      required this.description,
      required this.isDone,
      required this.priority,
      required this.taskId});

  factory Task.fromFirebase(Map<String, dynamic> task) {
    return Task(
        dateAdded: task['dateAdded'],
        title: task['title'],
        description: task['description'],
        isDone: task['isDone'],
        priority: task['priority'],
        taskId: task['taskId']);
  }
  Map<String, dynamic> get toJson {
    return {
      'dateAdded': dateAdded,
      'title': title,
      'description': description,
      'isDone': isDone,
      'priority': priority,
      'taskId': taskId,
    };
  }
}
