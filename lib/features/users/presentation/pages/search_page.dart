import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/user.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../../../../design_system/ds_card.dart';
import '../../../../design_system/ds_empty_state.dart';
import '../../../../design_system/ds_loading.dart';
import '../../../../design_system/ds_text_field.dart';
import 'user_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuários',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            DSTextField(
              controller: _textController,
              hint: 'Digite nome, email ou username',
              prefixIcon: Icons.search,
              onChanged: (query) {
                context.read<SearchCubit>().onQueryChanged(query);
              },
              onClear: () {
                context.read<SearchCubit>().onClear();
              },
            ),
            const SizedBox(height: AppSpacing.md),
            const Expanded(child: _SearchBody()),
          ],
        ),
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return switch (state) {
          SearchLoading() => const DSLoading(),
          SearchLoaded(:final users) => _UserList(users: users),
          SearchEmpty() => const DSEmptyState(
              icon: Icons.person_off,
              message: 'Nenhum resultado encontrado',
            ),
          SearchFailure(:final message) => DSEmptyState(
              icon: Icons.error_outline,
              message: message,
              iconColor: AppColors.danger,
            ),
        };
      },
    );
  }
}

class _UserList extends StatelessWidget {
  final List<User> users;

  const _UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < users.length - 1 ? AppSpacing.sm : 0,
          ),
          child: DSCard(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => UserDetailPage(user: user),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
