import 'package:homekru_owner/core/network/api_client.dart';
import 'package:homekru_owner/features/task/data/models/create_task_request.dart';
import 'package:homekru_owner/features/task/data/models/task_model.dart';

class TaskService {
  final ApiClient _apiClient;

  TaskService(this._apiClient);

  Future<List<TaskModel>> getTasks({
    String? status,
    String? assignedTo,
  }) async {
    return await _apiClient.get<List<TaskModel>>(
      '/tasks',
      queryParameters: {
        if (status != null) 'status': status,
        if (assignedTo != null) 'assigned_to': assignedTo,
      },
      requiresAuth: true,
      fromJson: (data) =>
          (data as List).map((json) => TaskModel.fromJson(json)).toList(),
    );
  }

  Future<TaskModel> getTaskById(String taskId) async {
    return await _apiClient.get<TaskModel>(
      '/tasks/$taskId',
      requiresAuth: true,
      fromJson: (data) => TaskModel.fromJson(data),
    );
  }

  Future<TaskModel> createTask(CreateTaskRequest request) async {
    return await _apiClient.post<TaskModel>(
      '/tasks',
      data: request.toJson(),
      requiresAuth: true,
      fromJson: (data) => TaskModel.fromJson(data),
    );
  }

  Future<TaskModel> updateTask(
    String taskId,
    Map<String, dynamic> updates,
  ) async {
    return await _apiClient.put<TaskModel>(
      '/tasks/$taskId',
      data: updates,
      requiresAuth: true,
      fromJson: (data) => TaskModel.fromJson(data),
    );
  }

  Future<void> deleteTask(String taskId) async {
    await _apiClient.delete(
      '/tasks/$taskId',
      requiresAuth: true,
    );
  }
}
