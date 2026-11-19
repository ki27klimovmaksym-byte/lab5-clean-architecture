import '../../domain/repositories/task_repository.dart';

class CompleteTask {
  const CompleteTask(this._repository);
  final TaskRepository _repository;
  Future<bool> call(String id) async {
    final tasks = await _repository.getAll();
    final index = tasks.indexWhere((task) => task.id == id);
    if (index < 0) return false;
    tasks[index] = tasks[index].complete();
    await _repository.replaceAll(tasks);
    return true;
  }
}
