import 'package:lab5_clean_architecture/application/use_cases/complete_task.dart';
import 'package:lab5_clean_architecture/application/use_cases/create_task.dart';
import 'package:lab5_clean_architecture/application/use_cases/list_tasks.dart';
import 'package:lab5_clean_architecture/infrastructure/repositories/json_task_repository.dart';
import 'package:lab5_clean_architecture/presentation/cli/task_cli.dart';

Future<void> main(List<String> args) async {
  final repository = JsonTaskRepository('data/tasks.json');
  final app = TaskCli(
    createTask: CreateTask(repository),
    listTasks: ListTasks(repository),
    completeTask: CompleteTask(repository),
  );
  try {
    await app.run(args);
  } on ArgumentError catch (error) {
    print(error.message);
  } on FormatException catch (error) {
    print('Не вдалося прочитати файл даних: ${error.message}');
  }
}
