import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/core/constants/app_colors.dart';

final appThemeProvider = Provider.family<ThemeData, Brightness>((
  ref,
  brightness,
) {
  final isDark = brightness == Brightness.dark;
  return _buildTheme(isDark: isDark);
});

ThemeData _buildTheme({required bool isDark}) {
  final scaffoldBackground = isDark ? AppColors.deepNight : AppColors.dawnMist;
  final canvasColor = isDark ? AppColors.midnightBlue : AppColors.pearlWhite;
  final textPrimary = isDark
      ? AppColors.textPrimary
      : AppColors.textPrimaryLight;
  final textSecondary = isDark
      ? AppColors.textSecondary
      : AppColors.textSecondaryLight;
  final cardColor = isDark
      ? AppColors.cardBackground.withValues(alpha: 0.92)
      : AppColors.cardBackgroundLight.withValues(alpha: 0.92);

  final colorScheme = isDark
      ? const ColorScheme.dark(
          primary: AppColors.neonTeal,
          secondary: AppColors.accentBlue,
          tertiary: AppColors.softPurple,
          error: AppColors.errorRed,
          surface: AppColors.cardBackground,
          onPrimary: AppColors.deepNight,
          onSecondary: Colors.white,
          onSurface: AppColors.textPrimary,
          onTertiary: Colors.white,
        )
      : const ColorScheme.light(
          primary: AppColors.accentBlue,
          secondary: AppColors.softPurple,
          tertiary: AppColors.neonTeal,
          error: AppColors.errorRed,
          surface: AppColors.cardBackgroundLight,
          onPrimary: Colors.white,
          onSecondary: AppColors.slateInk,
          onSurface: AppColors.textPrimaryLight,
          onTertiary: AppColors.slateInk,
        );

  final base = ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: scaffoldBackground,
    canvasColor: canvasColor,
    colorScheme: colorScheme,
  );

  final textTheme = base.textTheme.copyWith(
    displayLarge: base.textTheme.displayLarge?.copyWith(
      color: textPrimary,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: base.textTheme.displayMedium?.copyWith(
      color: textPrimary,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: base.textTheme.headlineSmall?.copyWith(
      color: textPrimary,
      letterSpacing: 0.5,
    ),
    titleMedium: base.textTheme.titleMedium?.copyWith(color: textSecondary),
    bodyLarge: base.textTheme.bodyLarge?.copyWith(
      color: textPrimary,
      height: 1.5,
    ),
    bodyMedium: base.textTheme.bodyMedium?.copyWith(
      color: textSecondary,
      height: 1.45,
    ),
    labelLarge: base.textTheme.labelLarge?.copyWith(
      color: textPrimary,
      letterSpacing: 0.6,
    ),
  );

  final translucentBorder = isDark
      ? Colors.white.withValues(alpha: 0.08)
      : Colors.black12;

  return base.copyWith(
    textTheme: textTheme,
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: isDark ? 12 : 8,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      shadowColor: isDark
          ? AppColors.neonTeal.withValues(alpha: 0.15)
          : AppColors.cloudBlue.withValues(alpha: 0.65),
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: isDark
          ? AppColors.midnightBlue.withValues(alpha: 0.7)
          : AppColors.cloudBlue.withValues(alpha: 0.8),
      selectedColor: isDark
          ? AppColors.neonTeal.withValues(alpha: 0.2)
          : AppColors.sunGlow.withValues(alpha: 0.45),
      labelStyle: TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: textPrimary,
      surfaceTintColor: Colors.transparent,
      toolbarTextStyle: textTheme.titleLarge,
      titleTextStyle: textTheme.titleLarge,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? AppColors.neonTeal : AppColors.accentBlue,
        foregroundColor: isDark ? AppColors.deepNight : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
        shadowColor: (isDark ? AppColors.neonTeal : AppColors.accentBlue)
            .withValues(alpha: 0.35),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isDark ? AppColors.neonTeal : AppColors.accentBlue,
          width: 1.5,
        ),
        foregroundColor: isDark ? AppColors.neonTeal : AppColors.accentBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark
          ? AppColors.midnightBlue.withValues(alpha: 0.8)
          : AppColors.pearlWhite.withValues(alpha: 0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: translucentBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: isDark ? AppColors.neonTeal : AppColors.accentBlue,
          width: 1.5,
        ),
      ),
      hintStyle: TextStyle(color: textSecondary),
      labelStyle: TextStyle(color: textSecondary),
    ),
    dividerTheme: DividerThemeData(
      color: isDark ? AppColors.midnightBlue : AppColors.cloudBlue,
      thickness: 1,
      space: 24,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        (isDark ? AppColors.neonTeal : AppColors.accentBlue).withValues(
          alpha: 0.5,
        ),
      ),
      radius: const Radius.circular(12),
      thickness: WidgetStateProperty.all(6),
    ),
    extensions: const [_ElevationOverlay()],
  );
}

class _ElevationOverlay extends ThemeExtension<_ElevationOverlay> {
  const _ElevationOverlay({this.level = 0.0});
  final double level;

  @override
  _ElevationOverlay copyWith({double? level}) {
    return _ElevationOverlay(level: level ?? this.level);
  }

  @override
  _ElevationOverlay lerp(ThemeExtension<_ElevationOverlay>? other, double t) {
    if (other is! _ElevationOverlay) {
      return this;
    }
    return _ElevationOverlay(level: lerpDouble(level, other.level, t) ?? level);
  }
}
