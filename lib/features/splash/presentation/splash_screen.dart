import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/animated_background.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/home/presentation/home_screen.dart';
import 'package:visual_algo/features/auth/presentation/sign_in_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const routePath = '/';
  static const routeName = 'splash';
  static bool animationsEnabled = true;

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late Timer _timer;
  static const _displayDuration = Duration(milliseconds: 2200);

  @override
  void initState() {
    super.initState();
    _timer = Timer(_displayDuration, _handleNavigation);
  }

  void _handleNavigation() {
    final authState = ref.read(authStateChangesProvider);
    final isAuthenticated = authState.asData?.value != null;
    if (!mounted) return;
    if (isAuthenticated) {
      context.go(HomeScreen.routePath);
    } else {
      context.go(SignInScreen.routePath);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              () {
                Widget logo = Image.asset(
                  'assets/images/algorithmat_logo.png',
                  width: 180,
                  height: 180,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(width: 160, height: 160),
                );
                if (SplashScreen.animationsEnabled) {
                  logo = logo
                      .animate(onPlay: (controller) => controller.repeat())
                      .shake(duration: 2200.ms, hz: 0.6)
                      .then(delay: 300.ms)
                      .scaleXY(
                        begin: 0.9,
                        end: 1.05,
                        duration: 1500.ms,
                        curve: Curves.easeInOut,
                      );
                }
                return logo;
              }(),
              const SizedBox(height: 40),
              () {
                Widget title = Text(
                  'AlgorithMat',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: AppColors.neonTeal,
                    letterSpacing: 4,
                  ),
                );
                if (SplashScreen.animationsEnabled) {
                  title = title
                      .animate()
                      .fadeIn(duration: 700.ms)
                      .slideY(begin: 0.4, end: 0);
                }
                return title;
              }(),
              const SizedBox(height: 32),
              () {
                Widget progress = SizedBox(
                  width: 220,
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.neonTeal,
                    backgroundColor: AppColors.midnightBlue,
                  ),
                );
                if (SplashScreen.animationsEnabled) {
                  progress = progress.animate().slideX(
                    begin: -0.3,
                    end: 0,
                    duration: 800.ms,
                  );
                }
                return progress;
              }(),
              const SizedBox(height: 16),
              () {
                Widget subtitle = Text(
                  'Booting immersive algorithm studio...',
                  style: theme.textTheme.bodyMedium,
                );
                if (SplashScreen.animationsEnabled) {
                  subtitle = subtitle.animate().fadeIn(delay: 500.ms);
                }
                return subtitle;
              }(),
            ],
          ),
        ),
      ),
    );
  }
}
