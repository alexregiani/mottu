import '../../domain/entities/user.dart';

sealed class SearchState {}

class SearchInitialLoading extends SearchState {}

class SearchInitial extends SearchState {
  final List<User> users;

  SearchInitial(this.users);
}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<User> users;

  SearchSuccess(this.users);
}

class SearchEmpty extends SearchState {}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}
