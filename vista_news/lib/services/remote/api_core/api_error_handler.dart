import 'package:chopper/chopper.dart';
import 'package:vista_news/services/remote/api_core/api_exception_handler.dart';

class ApiErrorHandler {
  static Response handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.error);
      case 401:
        throw UnAuthorizedException(response.error);
      case 403:
        throw AuthenticationException(response.error);
      case 404:
        throw NotFoundException(response.error);
      case 409:
        throw ConflictException(response.error);
      case 422:
        throw UnprocessableEntityException(response.error);
      case 500:
        throw FetchDataException("Internal Server Error");
      case 503:
        throw ServiceUnavailableException("Service Unavailable");
      default:
        throw DefaultException("Unexpected Error: ${response.statusCode}");
    }
  }
}
