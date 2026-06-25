import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/failures/user_failure.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/user_filter.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository _repository;
  Timer? _debounce;
  List<User>? _users;

  SearchCubit(this._repository) : super(SearchLoading()) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    emit(SearchLoading());

    try {
      _users = await _repository.getUsers();
      emit(SearchLoaded(_users!));
    } on UserFailure catch (failure) {
      emit(SearchFailure(failure.message));
    }
  }

  void onQueryChanged(String query) {
    _debounce?.cancel();

    if (_users == null) return;

    if (query.isEmpty) {
      emit(SearchLoaded(_users!));
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final filtered = filterUsers(_users!, query);
      if (filtered.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(filtered));
      }
    });
  }

  void onClear() {
    _debounce?.cancel();
    if (_users != null) {
      emit(SearchLoaded(_users!));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
