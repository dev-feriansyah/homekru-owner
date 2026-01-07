import 'package:homekru_owner/core/network/exceptions/api_exception.dart';

class ClientException extends ApiException {
  ClientException(super.message, {super.statusCode});
}
