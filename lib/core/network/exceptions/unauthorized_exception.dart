import 'package:homekru_owner/core/network/exceptions/api_exception.dart';

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message) : super(statusCode: 401);
}
