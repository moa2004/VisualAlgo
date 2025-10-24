import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.height = 64,
  });

  final dynamic title; 
  final List<Widget>? actions;
  final Widget? leading;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canPop = Navigator.of(context).canPop();
    final resolvedLeading =
        leading ??
        (canPop
            ? IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                ),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : null);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.midnightBlue.withValues(alpha: 0.92),
                AppColors.deepNight.withValues(alpha: 0.88),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border(
              bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconTheme(
                data: IconThemeData(color: AppColors.textPrimary),
                child: Row(
                  children: [
                    if (resolvedLeading != null) resolvedLeading,
                    if (resolvedLeading == null) const SizedBox(width: 8),

                    /// ✅ دعم النص أو الويجتس هنا
                    Expanded(
                      child: DefaultTextStyle(
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: title is String
                            ? Text(title)
                            : (title ?? const SizedBox.shrink()),
                      ),
                    ),

                    if (actions != null) ...[
                      const SizedBox(width: 8),
                      ...actions!,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
