import 'package:homekru_owner/core/network/exceptions/api_exception.dart';
import 'package:homekru_owner/features/task/data/models/create_task_request.dart';
import 'package:homekru_owner/features/task/data/models/task_model.dart';
import 'package:homekru_owner/features/task/data/services/task_service.dart';
import 'package:homekru_owner/shared/utils/logger.dart';

class TaskRepository {
  final TaskService _taskService;

  TaskRepository(this._taskService);

  Future<List<TaskModel>> fetchAllTasks({
    String? status,
    String? assignedTo,
  }) async {
    try {
      return await _taskService.getTasks(
        status: status,
        assignedTo: assignedTo,
      );
    } on ApiException catch (e) {
      Log.e('Failed to fetch tasks', error: e, tag: 'TaskRepository');
      rethrow;
    }
  }

  Future<TaskModel> fetchTaskDetails(String taskId) async {
    try {
      return await _taskService.getTaskById(taskId);
    } on ApiException catch (e) {
      Log.e('Failed to fetch task details', error: e, tag: 'TaskRepository');
      rethrow;
    }
  }

  Future<TaskModel> createNewTask({
    required String title,
    required String description,
    required String assignedTo,
    DateTime? dueDate,
    String? frequency,
    String? room,
    bool requirePhoto = false,
  }) async {
    try {
      if (title.isEmpty) {
        throw ApiException('Title cannot be empty');
      }
      if (description.isEmpty) {
        throw ApiException('Description cannot be empty');
      }
      if (assignedTo.isEmpty) {
        throw ApiException('Assigned to cannot be empty');
      }

      final request = CreateTaskRequest(
        title: title,
        description: description,
        assignedTo: assignedTo,
        dueDate: dueDate,
        frequency: frequency,
        room: room,
        requirePhoto: requirePhoto,
      );

      return await _taskService.createTask(request);
    } on ApiException catch (e) {
      Log.e('Failed to create task', error: e, tag: 'TaskRepository');
      rethrow;
    }
  }

  Future<void> removeTask(String taskId) async {
    try {
      await _taskService.deleteTask(taskId);
    } on ApiException catch (e) {
      Log.e('Failed to delete task', error: e, tag: 'TaskRepository');
      rethrow;
    }
  }

  Future<TaskModel> updateTask(
    String taskId,
    Map<String, dynamic> updates,
  ) async {
    try {
      return await _taskService.updateTask(taskId, updates);
    } on ApiException catch (e) {
      Log.e('Failed to update task', error: e, tag: 'TaskRepository');
      rethrow;
    }
  }
}
