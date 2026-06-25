import '../../domain/entities/user.dart';

class UserCache {
  List<User>? _users;

  List<User>? get users => _users;
  bool get hasData => _users != null;

  void save(List<User> users) => _users = users;

  void clear() => _users = null;
}
