import 'package:dio/dio.dart';
import 'package:homekru_owner/shared/utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.i(
      'REQUEST[${options.method}] => ${options.uri}',
      tag: 'API',
    );
    Log.d('Headers: ${options.headers}', tag: 'API');
    if (options.data != null) {
      Log.d('Body: ${options.data}', tag: 'API');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.i(
      'RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}',
      tag: 'API',
    );
    Log.d('Data: ${response.data}', tag: 'API');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e(
      'ERROR[${err.response?.statusCode}] => ${err.requestOptions.uri}',
      error: err,
      stackTrace: err.stackTrace,
      tag: 'API',
    );
    handler.next(err);
  }
}
