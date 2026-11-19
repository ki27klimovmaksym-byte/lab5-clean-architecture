class TaskItem {
  TaskItem({required this.id, required String title, this.isCompleted = false})
      : title = title.trim() {
    if (this.title.isEmpty) {
      throw ArgumentError.value(title, 'title', 'Назва завдання не може бути порожньою.');
    }
  }

  final String id;
  final String title;
  final bool isCompleted;

  TaskItem complete() => TaskItem(id: id, title: title, isCompleted: true);

  Map<String, Object?> toJson() => {'id': id, 'title': title, 'isCompleted': isCompleted};

  factory TaskItem.fromJson(Map<String, Object?> json) => TaskItem(
        id: json['id'] as String,
        title: json['title'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
      );
}
