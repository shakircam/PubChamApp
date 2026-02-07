import 'dart:io';
import 'package:dio/dio.dart';
import 'exceptions/api_exception.dart';
import 'exceptions/app_exception.dart';
import 'exceptions/data_validation_exception.dart';
import 'exceptions/network_exception.dart';
import 'exceptions/not_found_exception.dart';
import 'exceptions/service_unavailable_exception.dart';
import 'exceptions/timeout_exception.dart';

Exception handleError(String error) {
  //final logger = BuildConfig.instance.config.logger;
  // logger.e("Generic exception: $error");

  // Don't expose technical error messages to users
  if (_isTechnicalError(error)) {
    return AppException(message: "An unexpected error occurred. Please try again.");
  }

  return AppException(message: error);
}

/// Checks if error message contains technical details
bool _isTechnicalError(String message) {
  final lowerMessage = message.toLowerCase();
  final technicalTerms = [
    'exception',
    'stack trace',
    'null pointer',
    'cast error',
    'type error',
    'assertion',
    'undefined',
    'failed assertion',
  ];

  return technicalTerms.any((term) => lowerMessage.contains(term));
}

Exception handleDioError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.cancel:
      return AppException(message: "Request was cancelled. Please try again.");
    case DioExceptionType.connectionTimeout:
      return TimeoutException("Connection timed out. Please check your internet and try again.");
    case DioExceptionType.unknown:
      return NetworkException("No internet connection. Please check your network and try again.");
    case DioExceptionType.receiveTimeout:
      return TimeoutException("The request took too long. Please try again.");
    case DioExceptionType.sendTimeout:
      return TimeoutException("Failed to send request. Please try again.");
    case DioExceptionType.badResponse:
      return _parseDioErrorResponse(dioError);
    case DioExceptionType.badCertificate:
      return AppException(message: "Security certificate error. Please try again later.");
    case DioExceptionType.connectionError:
      return NetworkException("No internet connection. Please check your network and try again.");
  }

}

Exception _parseDioErrorResponse(DioException dioError) {
  //final logger = BuildConfig.instance.config.logger;

  int statusCode = dioError.response?.statusCode ?? -1;
  String? status;
  String? serverMessage;

  try {
    if (statusCode == -1 || statusCode == HttpStatus.ok) {
      statusCode = dioError.response?.data["statusCode"];
    }

    // Check for PubChem API error format (Fault)
    if (dioError.response?.data is Map &&
        dioError.response?.data["Fault"] != null) {
      final fault = dioError.response?.data["Fault"];
      status = fault["Code"]?.toString();
      serverMessage = fault["Message"]?.toString();

      // Get details if available
      if (fault["Details"] != null && fault["Details"] is List) {
        final details = fault["Details"] as List;
        if (details.isNotEmpty) {
          serverMessage = details.first.toString();
        }
      }
    } else {
      // Standard API error format
      status = dioError.response?.data["status"];
      serverMessage = dioError.response?.data["message"];
    }
  } catch (e) {
    //logger.i("$e");
    // logger.i(s.toString());

    serverMessage = "Something went wrong. Please try again later.";
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException("Service Temporarily Unavailable");
    case HttpStatus.notFound:
      return NotFoundException(
          serverMessage ?? "Resource not found", status ?? "");
    default:
      return ApiException(
          httpCode: statusCode,
          status: status ?? "",
          message: serverMessage ?? "Something went wrong. Please try again later.");
  }
}
