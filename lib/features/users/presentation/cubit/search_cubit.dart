import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_error.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository _repository;
  Timer? _debounce;
  List<User>? _allUsers;

  SearchCubit(this._repository) : super(SearchInitialLoading()) {
    loadInitialUsers();
  }

  Future<void> loadInitialUsers() async {
    emit(SearchInitialLoading());

    try {
      final users = await _repository.searchUsers('');
      _allUsers = users;
      emit(SearchInitial(users));
    } on ApiError catch (e) {
      emit(SearchFailure(e.message));
    }
  }

  void onQueryChanged(String query) {
    _debounce?.cancel();

    if (query.isEmpty) {
      if (_allUsers != null) {
        emit(SearchInitial(_allUsers!));
      } else {
        loadInitialUsers();
      }
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search(query);
    });
  }

  void onClear() {
    _debounce?.cancel();
    if (_allUsers != null) {
      emit(SearchInitial(_allUsers!));
    } else {
      loadInitialUsers();
    }
  }

  Future<void> _search(String query) async {
    emit(SearchLoading());

    try {
      final users = await _repository.searchUsers(query);
      if (users.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchSuccess(users));
      }
    } on ApiError catch (e) {
      emit(SearchFailure(e.message));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
