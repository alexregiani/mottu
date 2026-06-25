import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class DSLoading extends StatelessWidget {
  const DSLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}
