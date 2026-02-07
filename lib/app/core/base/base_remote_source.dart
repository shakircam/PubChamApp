import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pubchem/app/network/exceptions/api_exception.dart';
import 'package:pubchem/app/network/exceptions/app_exception.dart';
import 'package:pubchem/flavors/build_config.dart';
import '../../network/dio_provider.dart';
import '../../network/error_handlers.dart';
import '../../network/exceptions/base_exception.dart';

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.client;

  final logger = BuildConfig.instance.config.logger;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;

      // Check response status code
      if (response.statusCode != HttpStatus.ok) {
        final statusCode = response.statusCode ?? 500;
        final message = _extractErrorMessage(response.data) ??
                       'Request failed with status code $statusCode';

        logger.e("API Error: Status code $statusCode - $message");

        throw ApiException(
          httpCode: statusCode,
          status: statusCode.toString(),
          message: message,
        );
      }

      // Check nested status code in response data
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        if (data['statusCode'] != null && data['statusCode'] != HttpStatus.ok) {
          final nestedStatusCode = data['statusCode'] as int;
          final message = data['message']?.toString() ??
                         data['error']?.toString() ??
                         'Request failed with nested status code $nestedStatusCode';

          logger.e("API Error: Nested status code $nestedStatusCode - $message");

          throw ApiException(
            httpCode: nestedStatusCode,
            status: nestedStatusCode.toString(),
            message: message,
          );
        }
      }

      return response;
    } on DioException catch (dioError) {
      Exception exception = handleDioError(dioError);
      if (exception is BaseException) {
        logger.e("Throwing error from repository: >>>>>>> $exception : ${exception.message}");
      } else {
        logger.e("Throwing error from repository: >>>>>>> $exception");
      }
      throw exception;
    } catch (error) {
      logger.e("Generic error: >>>>>>> $error");

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }

  /// Extracts error message from response data
  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      // Try common error message fields
      return data['message']?.toString() ??
             data['error']?.toString() ??
             data['errorMessage']?.toString();
    }

    if (data is String) {
      return data;
    }

    return null;
  }
}
