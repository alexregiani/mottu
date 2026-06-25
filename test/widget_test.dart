import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mottu_alex_regiani/app.dart';
import 'package:mottu_alex_regiani/features/users/domain/entities/user.dart';
import 'package:mottu_alex_regiani/features/users/domain/repositories/user_repository.dart';
import 'package:mottu_alex_regiani/features/users/presentation/cubit/search_cubit.dart';

class _FakeUserRepository implements UserRepository {
  @override
  Future<List<User>> searchUsers(String query) async {
    return [
      const User(
        id: 1,
        name: 'Leanne Graham',
        username: 'Bret',
        email: 'Sincere@april.biz',
        address: Address(
          street: 'Kulas Light',
          suite: 'Apt. 556',
          city: 'Gwenborough',
          zipcode: '92998-3874',
          geo: Geo(lat: '-37.3159', lng: '81.1496'),
        ),
        phone: '1-770-736-8031 x56442',
        website: 'hildegard.org',
        company: Company(
          name: 'Romaguera-Crona',
          catchPhrase: 'Multi-layered client-server neural-net',
          bs: 'harness real-time e-markets',
        ),
      ),
    ];
  }
}

void main() {
  testWidgets('Search page shows all users on load', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => SearchCubit(_FakeUserRepository()),
        child: const MyApp(),
      ),
    );

    expect(find.text('Usuários'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Leanne Graham'), findsOneWidget);
    expect(find.text('Sincere@april.biz'), findsOneWidget);
  });
}
