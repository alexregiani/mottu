import '../../domain/entities/user.dart';
import '../../../../core/network/dio_client.dart';

class UserRemoteDataSource {
  final DioClient _client;

  UserRemoteDataSource(this._client);

  Future<List<User>> fetchUsers() async {
    final data = await _client.get('/users') as List<dynamic>;
    return data
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
