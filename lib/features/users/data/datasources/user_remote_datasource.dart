import 'package:dio/dio.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/dio_request.dart';
import '../constants/users_api.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  Future<List<UserModel>> fetchUsers() async {
    final data = await executeDioRequest(
      () => _dio.get<dynamic>(UsersApi.usersPath),
    );

    try {
      return (data as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on TypeError {
      throw const ParseError();
    }
  }
}
