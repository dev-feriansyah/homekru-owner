import 'package:homekru_owner/features/task/data/repositories/task_repository.dart';
import 'package:homekru_owner/features/task/data/services/task_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_repository_provider.g.dart';

@riverpod
TaskRepository taskRepository(Ref ref) {
  final taskService = ref.watch(taskServiceProvider);
  return TaskRepository(taskService);
}
