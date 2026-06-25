import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class DSEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color? iconColor;

  const DSEmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: iconColor ?? AppColors.muted),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
