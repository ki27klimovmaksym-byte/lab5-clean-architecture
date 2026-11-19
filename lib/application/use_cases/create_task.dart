import '../../domain/entities/task_item.dart';
import '../../domain/repositories/task_repository.dart';

class CreateTask {
  const CreateTask(this._repository);
  final TaskRepository _repository;
  Future<TaskItem> call(String title) async {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty) throw ArgumentError('Назва завдання не може бути порожньою.');
    final task = TaskItem(id: DateTime.now().microsecondsSinceEpoch.toString(), title: cleanTitle);
    await _repository.save(task);
    return task;
  }
}
