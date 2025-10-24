import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/glass_app_bar.dart';
import 'package:visual_algo/core/widgets/async_value_widget.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';
import 'package:visual_algo/features/algorithms/presentation/algorithm_catalog_screen.dart';
import 'package:visual_algo/features/algorithms/presentation/algorithm_detail_screen.dart';
import 'package:visual_algo/features/algorithms/providers.dart';
import 'package:visual_algo/features/analytics/presentation/analytics_screen.dart';
import 'package:visual_algo/features/analytics/providers.dart';
import 'package:visual_algo/features/analytics/domain/user_analytics.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/home/domain/user_progress.dart';
import 'package:visual_algo/features/home/providers.dart';
import 'package:visual_algo/features/quizzes/presentation/quiz_setup_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const routePath = '/home';
  static const routeName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final progressAsync = ref.watch(userProgressStreamProvider);
    final algorithmsAsync = ref.watch(algorithmCatalogProvider);

    return AppScaffold(
      extendBodyBehindAppBar: false,
      appBar: GlassAppBar(
        title: Text(
          'AlgorithMat',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: AppColors.neonTeal,
            letterSpacing: 0.5,
          ),
        ),
        leading: null,
        actions: [
          Tooltip(
            message: 'Explore Algorithms',
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.blueAccent.withValues(alpha: 0.12),
              ),
              onPressed: () =>
                  context.push('/home/${AlgorithmCatalogScreen.routeSegment}'),
              icon: const Icon(
                Icons.memory_rounded,
                color: Colors.blueAccent,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Tooltip(
            message: 'Start Adaptive Quiz',
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent.withValues(
                  alpha: 0.12,
                ),
              ),
              onPressed: () =>
                  context.push('/home/${QuizSetupScreen.routeSegment}'),
              icon: const Icon(
                Icons.psychology_alt_rounded,
                color: Colors.deepPurpleAccent,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Tooltip(
            message: 'Performance Analytics',
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.tealAccent.withValues(alpha: 0.12),
              ),
              onPressed: () =>
                  context.push('/home/${AnalyticsScreen.routeSegment}'),
              icon: const Icon(
                Icons.auto_graph_rounded,
                color: AppColors.neonTeal,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Tooltip(
            message: 'Profile & Settings',
            child: Consumer(
              builder: (context, ref, _) {
                final user = ref.watch(currentUserProvider);
                final photoUrl = user?.photoUrl;

                return IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                  ),
                  onPressed: () => context.push('/home/profile'),
                  icon: photoUrl != null
                      ? Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(photoUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white70,
                          size: 27,
                        ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroHeader(userDisplayName: user?.displayName),
              const SizedBox(height: 24),
              AsyncValueWidget<UserProgress>(
                value: progressAsync,
                data: (progress) => _ProgressOverview(progress: progress),
              ),
              const SizedBox(height: 24),
              AsyncValueWidget<UserAnalytics>(
                value: ref.watch(userAnalyticsStreamProvider),
                data: (analytics) => _InsightsCard(analytics: analytics),
              ),
              const SizedBox(height: 32),
              _ActionRow(
                isAuthenticated: user != null,
                onExplore: () => context.push(
                  '/home/${AlgorithmCatalogScreen.routeSegment}',
                ),
                onStartQuiz: () =>
                    context.push('/home/${QuizSetupScreen.routeSegment}'),
              ),
              const SizedBox(height: 32),
              AsyncValueWidget<List<AlgorithmModel>>(
                value: algorithmsAsync,
                data: (algorithms) => AsyncValueWidget<UserProgress>(
                  value: progressAsync,
                  data: (progress) => _RecentAlgorithms(
                    algorithms: algorithms,
                    progress: progress,
                    isLocked: user == null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.userDisplayName});

  final String? userDisplayName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final greeting = userDisplayName == null
        ? 'Welcome to AlgorithMat'
        : 'Welcome back, ${toBeginningOfSentenceCase(userDisplayName) ?? userDisplayName}';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dive into immersive algorithm visualisations, track your mastery, '
                  'and challenge yourself with adaptive quizzes.',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          const Icon(
            Icons.auto_graph_rounded,
            size: 72,
            color: AppColors.neonTeal,
          ),
        ],
      ),
    );
  }
}

class _ProgressOverview extends StatelessWidget {
  const _ProgressOverview({required this.progress});

  final UserProgress progress;

  @override
  Widget build(BuildContext context) {
    Widget masteryCard() => _MetricCard(
      title: 'Mastery',
      value: '${progress.masteredAlgorithms}/${progress.totalAlgorithms}',
      subtitle: 'Algorithms mastered',
      progressValue: progress.completionRatio,
      icon: Icons.auto_awesome_motion,
    );

    Widget consistencyCard() => _MetricCard(
      title: 'Consistency',
      value: '${progress.activeDays} days',
      subtitle: 'Active learning streak',
      progressValue: (progress.activeDays / 30).clamp(0, 1),
      icon: Icons.local_fire_department_rounded,
      accentColor: Colors.orangeAccent,
    );

    Widget accuracyCard() => _MetricCard(
      title: 'Quiz accuracy',
      value: '${(progress.quizAccuracy * 100).round()}%',
      subtitle: 'Average across recent quizzes',
      progressValue: progress.quizAccuracy,
      icon: Icons.bolt_rounded,
      accentColor: Colors.amberAccent,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width >= 960) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: masteryCard()),
              const SizedBox(width: 16),
              Expanded(child: consistencyCard()),
              const SizedBox(width: 16),
              Expanded(child: accuracyCard()),
            ],
          );
        }
        if (width >= 640) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: masteryCard()),
                  const SizedBox(width: 16),
                  Expanded(child: consistencyCard()),
                ],
              ),
              const SizedBox(height: 16),
              accuracyCard(),
            ],
          );
        }
        return Column(
          children: [
            masteryCard(),
            const SizedBox(height: 16),
            consistencyCard(),
            const SizedBox(height: 16),
            accuracyCard(),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.progressValue,
    required this.icon,
    this.accentColor = AppColors.neonTeal,
  });

  final String title;
  final String value;
  final String subtitle;
  final double progressValue;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 32, color: accentColor),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: accentColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progressValue.clamp(0, 1),
            minHeight: 6,
            color: accentColor,
            backgroundColor: Colors.white.withValues(alpha: 0.07),
          ),
        ],
      ),
    );
  }
}

class _InsightsCard extends StatelessWidget {
  const _InsightsCard({required this.analytics});

  final UserAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recommendations = analytics.buildRecommendations();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal insights',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (recommendations.isEmpty)
            Text(
              'Take a quiz to unlock personalized recommendations.',
              style: theme.textTheme.bodyMedium,
            )
          else
            ...recommendations.map(
              (insight) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.amber),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(insight, style: theme.textTheme.bodyLarge),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.isAuthenticated,
    required this.onExplore,
    required this.onStartQuiz,
  });

  final bool isAuthenticated;
  final VoidCallback onExplore;
  final VoidCallback onStartQuiz;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ready for your next breakthrough?',
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: onExplore,
                icon: const Icon(Icons.explore_rounded),
                label: const Text('Explore algorithms'),
              ),
              OutlinedButton.icon(
                onPressed: onStartQuiz,
                icon: const Icon(Icons.quiz_outlined),
                label: const Text('Start adaptive quiz'),
              ),
              if (!isAuthenticated)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Text(
                    'Create a free account to sync progress across devices.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentAlgorithms extends StatelessWidget {
  const _RecentAlgorithms({
    required this.algorithms,
    required this.progress,
    required this.isLocked,
  });

  final List<AlgorithmModel> algorithms;
  final UserProgress progress;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recentAlgorithms = progress.recentAlgorithmIds
        .map((id) => algorithms.firstWhereOrNull((algo) => algo.id == id))
        .whereType<AlgorithmModel>()
        .toList();
    if (recentAlgorithms.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withValues(alpha: 0.04),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent explorations',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Open an algorithm walkthrough to see it appear here.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continue your journey',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: recentAlgorithms.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final algorithm = recentAlgorithms[index];
              return SizedBox(
                width: 280,
                child: GestureDetector(
                  onTap: () async {
                    if (isLocked) {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Sign in required'),
                          content: const Text(
                            'Sign in to resume your interactive walkthroughs and save progress.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                GoRouter.of(context).go('/auth/sign-in');
                              },
                              child: const Text('Sign in'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    GoRouter.of(context).pushNamed(
                      AlgorithmDetailScreen.routeName,
                      pathParameters: {'algorithmId': algorithm.id},
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.neonTeal.withValues(
                                alpha: 0.2,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors.neonTeal,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                algorithm.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: Text(
                            algorithm.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Chip(
                                label: Text(
                                  '${algorithm.category} | ${algorithm.difficulty}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.06,
                                ),
                              ),
                            ),
                            Icon(
                              isLocked
                                  ? Icons.lock_outline
                                  : Icons.arrow_forward_rounded,
                              color: AppColors.neonTeal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
