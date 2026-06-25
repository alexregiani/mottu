import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'features/users/data/cache/user_cache.dart';
import 'features/users/data/datasources/user_remote_datasource.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/data/users_dio_module.dart';
import 'features/users/presentation/cubit/search_cubit.dart';

void main() {
  final repository = UserRepositoryImpl(
    remoteDataSource: UserRemoteDataSource(createUsersDio()),
    cache: UserCache(),
  );

  runApp(
    BlocProvider(
      create: (_) => SearchCubit(repository),
      child: const MyApp(),
    ),
  );
}
