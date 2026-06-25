import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_error_interceptor.dart';

/// Creates a configured [Dio] instance. Does not perform any API calls.
abstract final class DioFactory {
  static Dio create({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 10),
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    dio.interceptors.add(ApiErrorInterceptor());
    return dio;
  }
}
