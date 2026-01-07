import 'package:homekru_owner/core/network/exceptions/api_exception.dart';

class ServerException extends ApiException {
  ServerException(super.message, {super.statusCode});
}
