import 'package:homekru_owner/core/network/api_config.dart';
import 'package:homekru_owner/core/network/api_client.dart';
import 'package:homekru_owner/core/storage/auth_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final authStorage = ref.watch(authStorageProvider);

  return ApiClient(
    baseUrl: ApiConfig.fullBaseUrl,
    authStorage: authStorage,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    enableLogging: ApiConfig.enableApiLogging,
  );
}
