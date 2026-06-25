import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/network/dio_client.dart';
import 'features/users/data/datasources/user_remote_datasource.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/presentation/cubit/search_cubit.dart';

void main() {
  final dioClient = DioClient();
  final repository = UserRepositoryImpl(
    UserRemoteDataSource(dioClient),
  );

  runApp(
    BlocProvider(
      create: (_) => SearchCubit(repository),
      child: const MyApp(),
    ),
  );
}
