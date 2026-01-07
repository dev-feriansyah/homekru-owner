import 'package:homekru_owner/features/task/data/models/task_model.dart';
import 'package:homekru_owner/features/task/data/repositories/task_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<TaskModel>> build() async {
    final repository = ref.read(taskRepositoryProvider);
    return await repository.fetchAllTasks();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(taskRepositoryProvider);
      return await repository.fetchAllTasks();
    });
  }

  Future<void> createTask({
    required String title,
    required String description,
    required String assignedTo,
    DateTime? dueDate,
    String? frequency,
    String? room,
    bool requirePhoto = false,
  }) async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.createNewTask(
      title: title,
      description: description,
      assignedTo: assignedTo,
      dueDate: dueDate,
      frequency: frequency,
      room: room,
      requirePhoto: requirePhoto,
    );
    await refresh();
  }

  Future<void> deleteTask(String taskId) async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.removeTask(taskId);
    await refresh();
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> updates) async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.updateTask(taskId, updates);
    await refresh();
  }
}
