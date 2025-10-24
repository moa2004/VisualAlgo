import 'package:flutter/material.dart';
import 'package:visual_algo/core/constants/app_colors.dart';

class AppSnackBar {
  const AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    IconData? icon,
  }) {
    final theme = Theme.of(context);
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor:
              (isError ? AppColors.errorRed : AppColors.midnightBlue)
                  .withValues(alpha: isError ? 0.92 : 0.94),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          content: Row(
            children: [
              Icon(
                icon ??
                    (isError
                        ? Icons.error_outline_rounded
                        : Icons.check_circle_outline_rounded),
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
