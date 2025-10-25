import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/theme_toggle_button.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.height = 64,
    this.showThemeToggle = true,
  });

  final dynamic title;
  final List<Widget>? actions;
  final Widget? leading;
  final double height;
  final bool showThemeToggle;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final canPop = Navigator.of(context).canPop();
    final resolvedLeading =
        leading ??
        (canPop
            ? IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: colorScheme.onSurface,
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
              colors: isDark
                  ? [
                      AppColors.midnightBlue.withValues(alpha: 0.92),
                      AppColors.deepNight.withValues(alpha: 0.88),
                    ]
                  : [
                      AppColors.auroraSky.withValues(alpha: 0.9),
                      AppColors.dawnMist.withValues(alpha: 0.88),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : AppColors.slateInk.withValues(alpha: 0.08),
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconTheme(
                data: IconThemeData(color: colorScheme.onSurface),
                child: Row(
                  children: [
                    if (resolvedLeading != null) resolvedLeading,
                    if (resolvedLeading == null) const SizedBox(width: 8),

                    /// ✅ دعم النص أو الويجتس هنا
                    Expanded(
                      child: DefaultTextStyle(
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: title is String
                            ? Text(title)
                            : (title ?? const SizedBox.shrink()),
                      ),
                    ),

                    if (_hasTrailing)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 8),
                          ...?_buildActions(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get _hasTrailing => (actions?.isNotEmpty ?? false) || showThemeToggle;

  List<Widget>? _buildActions() {
    final trailing = <Widget>[];
    if (actions != null) {
      trailing.addAll(actions!);
    }
    if (showThemeToggle) {
      if (trailing.isNotEmpty) {
        trailing.add(const SizedBox(width: 8));
      }
      trailing.add(const ThemeToggleButton());
    }
    return trailing;
  }
}
