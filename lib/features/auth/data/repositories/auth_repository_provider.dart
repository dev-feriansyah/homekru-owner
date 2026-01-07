import 'package:homekru_owner/core/storage/auth_storage_provider.dart';
import 'package:homekru_owner/features/auth/data/repositories/auth_repository.dart';
import 'package:homekru_owner/features/auth/data/services/auth_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  final authStorage = ref.watch(authStorageProvider);
  return AuthRepository(authService, authStorage);
}
