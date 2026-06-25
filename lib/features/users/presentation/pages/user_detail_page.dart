import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../design_system/ds_card.dart';
import '../../domain/entities/user.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Center(
            child: CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.primary,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          DSCard(
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.person,
                  label: 'Username',
                  value: '@${user.username}',
                ),
                const Divider(color: AppColors.divider),
                _DetailRow(
                  icon: Icons.email,
                  label: 'Email',
                  value: user.email,
                ),
                const Divider(color: AppColors.divider),
                _DetailRow(
                  icon: Icons.phone,
                  label: 'Telefone',
                  value: user.phone,
                ),
                const Divider(color: AppColors.divider),
                _DetailRow(
                  icon: Icons.language,
                  label: 'Website',
                  value: user.website,
                ),
                const Divider(color: AppColors.divider),
                _DetailRow(
                  icon: Icons.business,
                  label: 'Empresa',
                  value: user.companyName,
                ),
                const Divider(color: AppColors.divider),
                _DetailRow(
                  icon: Icons.location_city,
                  label: 'Cidade',
                  value: user.city,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? '—' : value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
