import 'package:homekru_owner/core/network/api_provider.dart';
import 'package:homekru_owner/features/task/data/services/task_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_service_provider.g.dart';

@riverpod
TaskService taskService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TaskService(apiClient);
}
