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
    if (decoded is! List<Object?>) {
      throw FormatException('Очікувався JSON-масив у файлі ${file.path}.');
    }
    return decoded
        .map((row) => TaskItem.fromJson(Map<String, Object?>.from(row! as Map)))
        .toList();
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
