import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error.dart';

class DioClient {
  final Dio _dio;

  DioClient({
    String baseUrl = 'https://jsonplaceholder.typicode.com',
    Duration timeout = const Duration(seconds: 10),
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: timeout,
            receiveTimeout: timeout,
            sendTimeout: timeout,
          ),
        );

  Future<dynamic> get(String path) async {
    try {
      final response = await _dio.get<dynamic>(path);
      final statusCode = response.statusCode ?? 0;
      if (statusCode < 200 || statusCode >= 300) {
        throw ServerError(statusCode);
      }
      return response.data;
    } on ApiError {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on FormatException {
      throw const ParseError();
    } on TypeError {
      throw const ParseError();
    } catch (e) {
      if (e is SocketException) {
        throw const NetworkError();
      }
      throw const NetworkError();
    }
  }

  ApiError _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkError();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        return ServerError(statusCode);
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return const NetworkError();
        }
        return const NetworkError();
    }
  }
}
