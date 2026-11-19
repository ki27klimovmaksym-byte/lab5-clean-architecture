import '../../domain/entities/task_item.dart';
import '../../domain/repositories/task_repository.dart';

class ListTasks {
  const ListTasks(this._repository);
  final TaskRepository _repository;
  Future<List<TaskItem>> call() => _repository.getAll();
}
