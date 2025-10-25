import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/theme/theme_mode_controller.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final splashColor = (isDark ? Colors.white : onSurface).withValues(alpha: isDark ? 0.2 : 0.15);

    return Tooltip(
      message: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: isDark
                ? [
                    AppColors.midnightBlue.withValues(alpha: 0.95),
                    AppColors.deepNight.withValues(alpha: 0.85),
                  ]
                : [
                    AppColors.sunGlow.withValues(alpha: 0.9),
                    AppColors.auroraSky.withValues(alpha: 0.9),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : AppColors.sunGlow).withValues(alpha: isDark ? 0.35 : 0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: isDark ? 0.12 : 0.08),
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: notifier.toggle,
            splashColor: splashColor,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 550),
                    transitionBuilder: (child, animation) => RotationTransition(
                      turns: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: Icon(
                      isDark
                          ? Icons.wb_sunny_rounded
                          : Icons.nights_stay_rounded,
                      key: ValueKey(themeMode),
                      size: 22,
                      color: isDark
                          ? Colors.amberAccent
                          : AppColors.slateInk.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: onSurface,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                    child: Text(isDark ? 'Light' : 'Dark'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
