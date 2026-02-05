import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pubchem/app/network/exceptions/app_exception.dart';
import 'package:pubchem/flavors/build_config.dart';
import '../../network/dio_provider.dart';
import '../../network/error_handlers.dart';
import '../../network/exceptions/base_exception.dart';

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.client;

  //final logger = BuildConfig.instance.config.logger;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;

      if (response.statusCode != HttpStatus.ok) {
        // TODO
      } else if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        if (data['statusCode'] != null && data['statusCode'] != HttpStatus.ok) {
          // TODO
        }
      }

      return response;
    } on DioException catch (dioError) {
      Exception exception = handleDioError(dioError);
      // logger.e(
      //     "Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}");
      throw exception;
    } catch (error) {
      //logger.e("Generic error: >>>>>>> $error");

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
