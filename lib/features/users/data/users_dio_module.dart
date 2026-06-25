import 'package:dio/dio.dart';

import '../../../../core/network/dio_factory.dart';
import 'constants/users_api.dart';

Dio createUsersDio() => DioFactory.create(baseUrl: UsersApi.baseUrl);
