import 'dart:convert';
import 'dart:io';
import '../../domain/entities/task_item.dart';
import '../../domain/repositories/task_repository.dart';

class JsonTaskRepository implements TaskRepository {
  JsonTaskRepository(this.filePath);
  final String filePath;

  Future<List<TaskItem>> _read() async {
    final file = File(filePath);
    if (!await file.exists()) return [];

    final decoded = jsonDecode(await file.readAsString());
    if (decoded is! List) {
      throw FormatException('Очікувався JSON-масив у файлі ${file.path}.');
    }

    final tasks = <TaskItem>[];
    for (var index = 0; index < decoded.length; index++) {
      final row = decoded[index];
      if (row is! Map) {
        throw FormatException('Запис №${index + 1} у файлі ${file.path} має бути JSON-об’єктом.');
      }
      try {
        tasks.add(TaskItem.fromJson(Map<String, Object?>.from(row)));
      } catch (error) {
        throw FormatException('Не вдалося прочитати запис №${index + 1} у файлі ${file.path}: $error');
      }
    }
    return tasks;
  }

  Future<void> _write(List<TaskItem> tasks) async {
    final file = File(filePath);
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(tasks.map((task) => task.toJson()).toList()));
  }

  @override
  Future<List<TaskItem>> getAll() => _read();

  @override
  Future<void> save(TaskItem task) async {
    final tasks = await _read();
    if (tasks.any((stored) => stored.id == task.id)) {
      throw StateError('Завдання з ID ${task.id} уже існує.');
    }
    tasks.add(task);
    await _write(tasks);
  }

  @override
  Future<void> replaceAll(List<TaskItem> tasks) => _write(tasks);
}
