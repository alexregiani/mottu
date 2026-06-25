import '../../../../core/network/api_error.dart';
import '../../domain/entities/user.dart';
import '../../domain/failures/user_failure.dart';
import '../../domain/repositories/user_repository.dart';
import '../cache/user_cache.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserCache _cache;

  UserRepositoryImpl({
    required this._remoteDataSource,
    required this._cache,
  });

  @override
  Future<List<User>> getUsers({bool forceRefresh = false}) async {
    if (!forceRefresh && _cache.hasData) {
      return _cache.users!;
    }

    try {
      final models = await _remoteDataSource.fetchUsers();
      final users = models.map((model) => model.toEntity()).toList();
      _cache.save(users);
      return users;
    } on ApiError catch (error) {
      throw _mapFailure(error);
    }
  }

  UserFailure _mapFailure(ApiError error) {
    return switch (error) {
      NetworkError() => const UserNetworkFailure(),
      ServerError(:final statusCode) => UserServerFailure(statusCode),
      ParseError() => const UserParseFailure(),
    };
  }
}
