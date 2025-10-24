import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/async_value_widget.dart';
import 'package:visual_algo/core/widgets/glass_app_bar.dart';
import 'package:visual_algo/core/widgets/glass_container.dart';
import 'package:visual_algo/features/analytics/domain/user_analytics.dart';
import 'package:visual_algo/features/analytics/providers.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  static const routeSegment = 'analytics';
  static const routeName = 'analytics';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(userAnalyticsStreamProvider);

    return AppScaffold(
      extendBodyBehindAppBar: false,
      appBar: const GlassAppBar(title: 'Performance Analytics'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: AsyncValueWidget<UserAnalytics>(
          value: analyticsAsync,
          data: (analytics) => _AnalyticsBody(analytics: analytics),
        ),
      ),
    );
  }
}

class _AnalyticsBody extends StatelessWidget {
  const _AnalyticsBody({required this.analytics});

  final UserAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quizHistory = analytics.quizHistory;
    final topicEntries = analytics.topicPerformance.entries.toList()
      ..sort((a, b) => a.value.accuracy.compareTo(b.value.accuracy));
    final recommendations = analytics.buildRecommendations();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionCard(
            title: 'Snapshot',
            child: _SnapshotMetrics(
              metrics: [
                _MetricData(
                  label: 'Total quizzes',
                  value: analytics.totalQuizzes.toString(),
                  icon: Icons.quiz_outlined,
                ),
                _MetricData(
                  label: 'Average score',
                  value:
                      '${(analytics.averageScore * 100).toStringAsFixed(0)}%',
                  icon: Icons.trending_up_rounded,
                ),
                _MetricData(
                  label: 'Best score',
                  value: '${(analytics.bestScore * 100).toStringAsFixed(0)}%',
                  icon: Icons.emoji_events_outlined,
                  accent: AppColors.successGreen,
                ),
                _MetricData(
                  label: 'Latest score',
                  value: '${(analytics.latestScore * 100).toStringAsFixed(0)}%',
                  icon: Icons.history_rounded,
                  accent: AppColors.warningAmber,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (quizHistory.isNotEmpty)
            _SectionCard(
              title: 'Quiz history',
              child: Column(
                children: List.generate(quizHistory.length, (index) {
                  final summary = quizHistory[index];
                  final quizNumber = quizHistory.length - index;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == quizHistory.length - 1 ? 0 : 16,
                    ),
                    child: _QuizHistoryTile(
                      quizNumber: quizNumber,
                      summary: summary,
                    ),
                  );
                }),
              ),
            )
          else
            _SectionCard(
              title: 'Quiz history',
              child: Text(
                'Complete your first quiz to start tracking detailed insights.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          if (topicEntries.isNotEmpty) ...[
            const SizedBox(height: 24),
            _SectionCard(
              title: 'Topic insights',
              child: _TopicInsightsGrid(entries: topicEntries),
            ),
          ],
          const SizedBox(height: 24),
          _SectionCard(
            title: 'Recommendations',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recommendations.isEmpty
                  ? [
                      Text(
                        'Keep taking quizzes to unlock tailored recommendations for your learning path.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ]
                  : recommendations
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () => _showReport(context),
              icon: const Icon(Icons.description_outlined),
              label: const Text('Generate full report'),
            ),
          ),
        ],
      ),
    );
  }

  void _showReport(BuildContext context) {
    final sections = analytics.buildReport();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final bottomInset = MediaQuery.of(context).padding.bottom + 16;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, bottomInset),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            minChildSize: 0.45,
            builder: (context, controller) {
              return GlassContainer(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Performance report',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: sections.length,
                        itemBuilder: (context, index) {
                          final section = sections[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == sections.length - 1 ? 0 : 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  section.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppColors.neonTeal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                ...section.items.map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      '• $item',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _TopicInsightsGrid extends StatelessWidget {
  const _TopicInsightsGrid({required this.entries});

  final List<MapEntry<String, TopicPerformance>> entries;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double cardWidth;
        if (width >= 960) {
          cardWidth = (width - 32) / 3;
        } else if (width >= 640) {
          cardWidth = (width - 16) / 2;
        } else {
          cardWidth = width;
        }
        cardWidth = cardWidth.clamp(220, width);

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: entries.map((entry) {
            return SizedBox(
              width: cardWidth,
              child: _TopicInsightCard(performance: entry.value),
            );
          }).toList(),
        );
      },
    );
  }
}

class _TopicInsightCard extends StatelessWidget {
  const _TopicInsightCard({required this.performance});

  final TopicPerformance performance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accuracy = (performance.accuracy * 100).toStringAsFixed(0);
    final statusColor = performance.isWeak
        ? AppColors.errorRed
        : performance.isStrong
        ? AppColors.successGreen
        : AppColors.textSecondary;
    final statusLabel = performance.isWeak
        ? 'Needs review'
        : performance.isStrong
        ? 'Strong area'
        : 'Keep practising';

    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  performance.topic,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Chip(
                label: Text('$accuracy%'),
                backgroundColor: statusColor.withValues(alpha: 0.12),
                labelStyle: theme.textTheme.labelMedium?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: performance.accuracy.clamp(0, 1),
              minHeight: 10,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              color: statusColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$statusLabel — ${performance.correct}/${performance.total} correct',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizHistoryTile extends StatelessWidget {
  const _QuizHistoryTile({required this.quizNumber, required this.summary});

  final int quizNumber;
  final QuizSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateFormat('MMM d, y — HH:mm').format(summary.timestamp);
    final weakTopics = summary.weakTopics;
    final strongTopics = summary.strongTopics;

    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.neonTeal.withValues(alpha: 0.25),
                child: Text(
                  '#$quizNumber',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.neonTeal,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(summary.percentage).toStringAsFixed(0)}% — ${summary.correctTopics.length}/${summary.totalQuestions} correct',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(date, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (strongTopics.isNotEmpty)
            _TopicChipRow(
              label: 'On point',
              color: AppColors.successGreen,
              topics: strongTopics,
            ),
          if (weakTopics.isNotEmpty) ...[
            const SizedBox(height: 8),
            _TopicChipRow(
              label: 'Revise next',
              color: AppColors.errorRed,
              topics: weakTopics,
            ),
          ],
          if (summary.incorrectTopics.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Incorrect answers came from ${summary.incorrectTopics.join(', ')}. Rewatch the visual walkthroughs and retry within 48 hours.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TopicChipRow extends StatelessWidget {
  const _TopicChipRow({
    required this.label,
    required this.color,
    required this.topics,
  });

  final String label;
  final Color color;
  final List<String> topics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: topics
              .map(
                (topic) => Chip(
                  label: Text(topic),
                  backgroundColor: color.withValues(alpha: 0.12),
                  labelStyle: theme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _SnapshotMetrics extends StatelessWidget {
  const _SnapshotMetrics({required this.metrics});

  final List<_MetricData> metrics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double tileWidth;
        if (width >= 960) {
          tileWidth = (width - 32) / 3;
        } else if (width >= 640) {
          tileWidth = (width - 16) / 2;
        } else {
          tileWidth = width;
        }
        tileWidth = tileWidth.clamp(220, width);

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: metrics.map((metric) {
            return SizedBox(
              width: tileWidth,
              child: _MetricTile(
                label: metric.label,
                value: metric.value,
                icon: metric.icon,
                accent: metric.accent,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _MetricData {
  const _MetricData({
    required this.label,
    required this.value,
    required this.icon,
    this.accent,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? accent;
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.icon,
    this.accent,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = accent ?? AppColors.neonTeal;
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withValues(alpha: 0.18),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(label, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
