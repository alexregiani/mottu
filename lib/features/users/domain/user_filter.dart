import 'entities/user.dart';

List<User> filterUsers(List<User> users, String query) {
  if (query.isEmpty) return users;

  final q = query.toLowerCase();
  return users.where((user) {
    return user.name.toLowerCase().contains(q) ||
        user.email.toLowerCase().contains(q) ||
        user.username.toLowerCase().contains(q);
  }).toList();
}
