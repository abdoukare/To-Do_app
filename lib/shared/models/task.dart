class Task {
  final String id;
  final String title;
  final bool status;
  final String description;
  final DateTime deadline;

  Task({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.deadline,
  });

  /// Convert a Task object to JSON map for storage (e.g., SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'description': description,
      'deadline': deadline.toIso8601String(),
    };
  }

  /// Create a Task object from a JSON map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as bool,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
    );
  }

  /// Create a copy of this Task with optional field overrides
  Task copyWith({
    String? id,
    String? title,
    bool? status,
    String? description,
    DateTime? deadline,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
    );
  }

/*
  /// Override the default toString() method to provide a readable string representation
  /// This method is called when you print a Task object or convert it to a string
  /// Example output: Task(id: 1, title: Buy Milk, status: false, ...)
  @override
  String toString() {
    return 'Task(id: $id, title: $title, status: $status, description: $description, deadline: $deadline)';
  }

  /// Override the equality operator (==) to compare two Task objects
  /// This allows you to check if two Task objects have the same values
  /// Usage: if (task1 == task2) { ... }
  ///
  /// - [identical(this, other)] checks if both objects point to the same memory location (same instance)
  /// - [other is Task] checks if the other object is a Task instance
  /// - Then compares all properties (id, title, status, description, deadline)
  /// Returns true only if all properties match
  @override
  bool operator ==(Object other) {
    // If both objects are the same instance in memory, they are definitely equal
    if (identical(this, other)) return true;

    // Check if 'other' is a Task object AND all its properties match this Task's properties
    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.status == status &&
        other.description == description &&
        other.deadline == deadline;
  }

  /// Override the hashCode getter to provide a hash code for this object
  /// Hash codes are used when storing objects in Sets or as Map keys
  /// Objects that are equal (==) must have the same hash code
  ///
  /// The (^) operator is XOR (exclusive OR) - it combines all property hash codes
  /// This creates a unique number based on the object's properties
  /// If any property changes, the hash code changes too
  @override
  int get hashCode {
    // Combine hash codes of all properties using XOR operator (^)
    // This ensures different Tasks will likely have different hash codes
    return id.hashCode ^
        title.hashCode ^
        status.hashCode ^
        description.hashCode ^
        deadline.hashCode;
  }
}
*/ 
}