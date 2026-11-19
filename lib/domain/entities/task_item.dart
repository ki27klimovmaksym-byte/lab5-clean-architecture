class TaskItem {
  const TaskItem({required this.id, required this.title, this.isCompleted = false});
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
