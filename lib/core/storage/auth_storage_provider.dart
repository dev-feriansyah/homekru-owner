import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homekru_owner/core/storage/auth_storage.dart';
import 'package:homekru_owner/core/storage/auth_storage_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_storage_provider.g.dart';

@riverpod
AuthStorage authStorage(Ref ref) {
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  return AuthStorageImpl(storage);
}
