import '../../domain/entities/task_item.dart';
import '../../domain/repositories/task_repository.dart';

class CreateTask {
  CreateTask(this._repository, {String Function()? idFactory})
      : _idFactory = idFactory ?? _timestampId;
  final TaskRepository _repository;
  final String Function() _idFactory;
  static String _timestampId() => DateTime.now().microsecondsSinceEpoch.toString();
  Future<TaskItem> call(String title) async {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty) throw ArgumentError('Назва завдання не може бути порожньою.');
    final task = TaskItem(id: _idFactory(), title: cleanTitle);
    await _repository.save(task);
    return task;
  }
}
