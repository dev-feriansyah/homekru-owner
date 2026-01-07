import 'package:dio/dio.dart';
import 'package:homekru_owner/core/network/exceptions/api_exception.dart';
import 'package:homekru_owner/core/network/exceptions/client_exception.dart'
    as custom;
import 'package:homekru_owner/core/network/exceptions/network_exception.dart';
import 'package:homekru_owner/core/network/exceptions/server_exception.dart';
import 'package:homekru_owner/core/network/exceptions/unauthorized_exception.dart';
import 'package:homekru_owner/core/network/interceptors/auth_interceptor.dart';
import 'package:homekru_owner/core/network/interceptors/logging_interceptor.dart';
import 'package:homekru_owner/core/storage/auth_storage.dart';

class ApiClient {
  final Dio _dio;
  final AuthStorage _authStorage;

  ApiClient({
    required String baseUrl,
    required AuthStorage authStorage,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    bool enableLogging = false,
  })  : _authStorage = authStorage,
        _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(AuthInterceptor(_authStorage));

    if (enableLogging) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    try {
      await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  T _handleResponse<T>(Response response, T Function(dynamic)? fromJson) {
    if (fromJson != null) {
      return fromJson(response.data);
    }
    return response.data as T;
  }

  ApiException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Connection timeout');

      case DioExceptionType.connectionError:
        return NetworkException('No internet connection');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return UnauthorizedException('Unauthorized');
        } else if (statusCode != null && statusCode >= 400 && statusCode < 500) {
          final message = error.response?.data is Map
              ? (error.response?.data['message'] ?? 'Client error')
              : 'Client error';
          return custom.ClientException(
            message,
            statusCode: statusCode,
          );
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException('Server error', statusCode: statusCode);
        }
        return ApiException('Unknown error occurred');

      default:
        return ApiException(error.message ?? 'Unknown error');
    }
  }
}
