import '../../application/use_cases/complete_task.dart';
import '../../application/use_cases/create_task.dart';
import '../../application/use_cases/list_tasks.dart';

class TaskCli {
  const TaskCli({required this.createTask, required this.listTasks, required this.completeTask});
  final CreateTask createTask;
  final ListTasks listTasks;
  final CompleteTask completeTask;

  Future<void> run(List<String> args) async {
    if (args.isEmpty || args.first == 'list') {
      final tasks = await listTasks();
      if (tasks.isEmpty) {
        print('Список завдань порожній.');
        return;
      }
      for (final task in tasks) {
        print('${task.isCompleted ? '[x]' : '[ ]'} ${task.id} — ${task.title}');
      }
      return;
    }
    switch (args.first) {
      case 'add':
        if (args.length < 2) throw ArgumentError('Використання: add "назва завдання"');
        final task = await createTask(args.skip(1).join(' '));
        print('Додано: ${task.title} (${task.id})');
      case 'done':
        if (args.length != 2 || args[1].trim().isEmpty) {
          throw ArgumentError('Використання: done ID');
        }
        final changed = await completeTask(args[1]);
        print(changed ? 'Завдання позначено виконаним.' : 'Завдання з таким ID не знайдено.');
      case 'help':
        print('Команди: list | add "назва" | done ID | help');
      default:
        print('Невідома команда. Команди: list | add "назва" | done ID | help');
    }
  }
}
