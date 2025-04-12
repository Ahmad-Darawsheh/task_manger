class Task {
  final int? id; // Database ID (null for new tasks)
  final String name;
  final String date;
  final String startTime;
  final String endTime;
  final String description;
  final String category;
  final bool isCompleted;
  final String userId; // Added userId field to associate tasks with users

  Task({
    this.id,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.category,
    required this.isCompleted,
    required this.userId,
  });

  // Convert Task object to a map for storing in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
      'category': category,
      'isCompleted': isCompleted ? 1 : 0, // SQLite doesn't have boolean type
      'userId': userId,
    };
  }

  // Create a Task object from a database map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      description: map['description'],
      category: map['category'],
      isCompleted: map['isCompleted'] == 1,
      userId: map['userId'],
    );
  }

  // Create a copy of the task with some fields changed
  Task copyWith({
    int? id,
    String? name,
    String? date,
    String? startTime,
    String? endTime,
    String? description,
    String? category,
    bool? isCompleted,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
    );
  }
}