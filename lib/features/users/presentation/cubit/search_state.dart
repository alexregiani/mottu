import '../../domain/entities/user.dart';

sealed class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<User> users;

  SearchLoaded(this.users);
}

class SearchEmpty extends SearchState {}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}
