import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/core/theme/app_theme.dart';
import 'package:visual_algo/core/theme/theme_mode_controller.dart';
import 'package:visual_algo/routes/app_router.dart';

class AlgorithMatApp extends ConsumerWidget {
  const AlgorithMatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final platformBrightness =
        MediaQuery.maybeOf(context)?.platformBrightness ?? Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);
    final targetBrightness = switch (themeMode) {
      ThemeMode.system => platformBrightness,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.light => Brightness.light,
    };

    final baseTheme = ref.watch(appThemeProvider(targetBrightness));

    final theme = baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(fontFamily: 'PlusJakartaSans'),
      primaryTextTheme: baseTheme.primaryTextTheme.apply(
        fontFamily: 'PlusJakartaSans',
      ),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        titleTextStyle:
            baseTheme.appBarTheme.titleTextStyle?.copyWith(
              fontFamily: 'PlusJakartaSans',
            ) ??
            baseTheme.textTheme.titleMedium?.copyWith(
              fontFamily: 'PlusJakartaSans',
            ),
      ),
    );

    return MaterialApp.router(
      title: 'AlgorithMat',
      debugShowCheckedModeBanner: false,
      theme: theme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
