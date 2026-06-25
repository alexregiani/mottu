import 'package:dio/dio.dart';

import 'dio_error_mapper.dart';

/// Maps every failed request to a typed [ApiError] attached to [DioException.error].
class ApiErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      err.copyWith(error: DioErrorMapper.fromDioException(err)),
    );
  }
}
