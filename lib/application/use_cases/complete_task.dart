import '../../domain/repositories/task_repository.dart';

class CompleteTask {
  const CompleteTask(this._repository);
  final TaskRepository _repository;

  Future<bool> call(String id) async {
    final tasks = await _repository.getAll();
    final index = tasks.indexWhere((task) => task.id == id);
    if (index < 0) return false;
    if (tasks[index].isCompleted) return true;

    final updatedTasks = [
      for (var i = 0; i < tasks.length; i++)
        if (i == index) tasks[i].complete() else tasks[i],
    ];
    await _repository.replaceAll(updatedTasks);
    return true;
  }
}
