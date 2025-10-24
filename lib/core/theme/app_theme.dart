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
  final base = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.deepNight,
    canvasColor: AppColors.midnightBlue,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.neonTeal,
      secondary: AppColors.accentBlue,
      tertiary: AppColors.softPurple,
      error: AppColors.errorRed,
      surface: AppColors.cardBackground,
      onPrimary: AppColors.deepNight,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      onTertiary: Colors.white,
    ),
  );

  final textTheme = base.textTheme.copyWith(
    displayLarge: base.textTheme.displayLarge?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: base.textTheme.displayMedium?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: base.textTheme.headlineSmall?.copyWith(
      color: AppColors.textPrimary,
      letterSpacing: 0.5,
    ),
    titleMedium: base.textTheme.titleMedium?.copyWith(
      color: AppColors.textSecondary,
    ),
    bodyLarge: base.textTheme.bodyLarge?.copyWith(
      color: AppColors.textPrimary,
      height: 1.5,
    ),
    bodyMedium: base.textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      height: 1.45,
    ),
    labelLarge: base.textTheme.labelLarge?.copyWith(
      color: AppColors.textPrimary,
      letterSpacing: 0.6,
    ),
  );

  return base.copyWith(
    textTheme: textTheme,
    cardTheme: CardThemeData(
      color: AppColors.cardBackground.withValues(alpha: 0.92),
      elevation: 12,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: AppColors.midnightBlue.withValues(alpha: 0.7),
      selectedColor: AppColors.neonTeal.withValues(alpha: 0.2),
      labelStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.neonTeal,
        foregroundColor: AppColors.deepNight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
        shadowColor: AppColors.neonTeal.withValues(alpha: 0.4),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.neonTeal, width: 1.5),
        foregroundColor: AppColors.neonTeal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.midnightBlue.withValues(alpha: 0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.neonTeal, width: 1.5),
      ),
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      labelStyle: const TextStyle(color: AppColors.textSecondary),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.midnightBlue,
      thickness: 1,
      space: 24,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        AppColors.neonTeal.withValues(alpha: 0.5),
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
