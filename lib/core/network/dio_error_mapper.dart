import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error.dart';

/// Maps Dio / network errors to [ApiError]. Parse errors belong in the data layer.
abstract final class DioErrorMapper {
  static ApiError fromDioException(DioException exception) {
    if (exception.error is ApiError) {
      return exception.error as ApiError;
    }

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkError();
      case DioExceptionType.badResponse:
        return ServerError(exception.response?.statusCode ?? 0);
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        if (exception.error is SocketException) {
          return const NetworkError();
        }
        return const NetworkError();
    }
  }
}
