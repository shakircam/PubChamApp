import 'base_exception.dart';

/// Exception thrown when received data doesn't meet business requirements
/// This is different from API errors - the API succeeded but data is invalid
class DataValidationException extends BaseException {
  DataValidationException(String message) : super(message: message);
}
