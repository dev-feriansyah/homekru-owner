import 'package:dio/dio.dart';
import 'package:homekru_owner/core/storage/auth_storage.dart';

class AuthInterceptor extends Interceptor {
  final AuthStorage _authStorage;

  static const _publicEndpoints = [
    '/auth/login',
    '/auth/signup',
    '/auth/forgot-password',
    '/auth/verify-otp',
    '/auth/reset-password',
  ];

  AuthInterceptor(this._authStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresAuth = options.extra['requiresAuth'] as bool? ?? true;

    final isPublicEndpoint = _publicEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );

    if (requiresAuth && !isPublicEndpoint) {
      final token = await _authStorage.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }
}
