import '../entities/task_item.dart';

abstract interface class TaskRepository {
  Future<List<TaskItem>> getAll();
  Future<void> save(TaskItem task);
  Future<void> replaceAll(List<TaskItem> tasks);
}
