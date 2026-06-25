import 'package:dio/dio.dart';

import 'api_error.dart';

/// Unwraps [ApiError] from [DioException.error]. Mapping is done by [ApiErrorInterceptor].
Future<dynamic> executeDioRequest(
  Future<Response<dynamic>> Function() call,
) async {
  try {
    return (await call()).data;
  } on DioException catch (e) {
    throw e.error as ApiError;
  }
}
