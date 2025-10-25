import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/async_value_widget.dart';
import 'package:visual_algo/core/widgets/glass_app_bar.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';
import 'package:visual_algo/features/algorithms/presentation/widgets/algorithm_visual_player.dart';
import 'package:visual_algo/features/algorithms/providers.dart';
import 'package:visual_algo/features/analytics/providers.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/home/providers.dart';

class AlgorithmDetailScreen extends ConsumerStatefulWidget {
  const AlgorithmDetailScreen({super.key, required this.algorithmId});

  final String algorithmId;

  static const routeSegment = ':algorithmId';
  static const routeName = 'algorithm-detail';

  @override
  ConsumerState<AlgorithmDetailScreen> createState() =>
      _AlgorithmDetailScreenState();
}

class _AlgorithmDetailScreenState extends ConsumerState<AlgorithmDetailScreen> {
  ProviderSubscription<AsyncValue<AlgorithmModel?>>? _detailSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detailSubscription = ref.listenManual<AsyncValue<AlgorithmModel?>>(
        algorithmDetailProvider(widget.algorithmId),
        (previous, next) async {
          if (!next.hasValue) return;
          final algorithm = next.value;
          if (algorithm == null) return;
          if (previous?.value == algorithm) return;
          final user = ref.read(currentUserProvider);
          final progressRepository = ref.read(userProgressRepositoryProvider);
          final analyticsRepository = ref.read(userAnalyticsRepositoryProvider);
          if (user != null) {
            await progressRepository.saveRecentAlgorithm(user, algorithm.id);
            await analyticsRepository.recordAlgorithmView(user, algorithm.id);
          } else {
            await progressRepository.storeLocalPreference(algorithm.id);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _detailSubscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final algorithmAsync = ref.watch(
      algorithmDetailProvider(widget.algorithmId),
    );
    return AppScaffold(
      extendBodyBehindAppBar: false,
      appBar: const GlassAppBar(title: 'Algorithm Studio'),
      body: AsyncValueWidget<AlgorithmModel?>(
        value: algorithmAsync,
        data: (algorithm) {
          if (algorithm == null) {
            return const Center(child: Text('Algorithm not found.'));
          }
          return _AlgorithmDetailBody(algorithm: algorithm);
        },
      ),
    );
  }
}

class _AlgorithmDetailBody extends StatefulWidget {
  const _AlgorithmDetailBody({required this.algorithm});

  final AlgorithmModel algorithm;

  @override
  State<_AlgorithmDetailBody> createState() => _AlgorithmDetailBodyState();
}

class _AlgorithmDetailBodyState extends State<_AlgorithmDetailBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<String> languages;

  @override
  void initState() {
    super.initState();
    languages = widget.algorithm.codeSnippets.keys.toList();
    _tabController = TabController(length: languages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final algorithm = widget.algorithm;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, algorithm),
          const SizedBox(height: 24),
          AlgorithmVisualPlayer(algorithm: algorithm),
          const SizedBox(height: 32),
          Text(
            'Multilingual code walkthrough',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  indicatorColor: AppColors.neonTeal,
                  tabs: [
                    for (final language in languages)
                      Tab(text: language.toUpperCase()),
                  ],
                ),
                SizedBox(
                  height: 320,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      for (final language in languages)
                        _CodeViewer(
                          code: algorithm.codeSnippets[language]!,
                          language: language,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text('Conceptual deep dive', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(algorithm.description, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 18),
          if (algorithm.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: algorithm.tags
                  .map(
                    (tag) => Chip(
                      label: Text(tag),
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, AlgorithmModel algorithm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.neonTeal.withValues(alpha: 0.25),
                child: Icon(
                  _iconForCategory(algorithm.category),
                  size: 32,
                  color: AppColors.neonTeal,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      algorithm.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Chip(
                          label: Text(algorithm.category),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                        ),
                        Chip(
                          label: Text(algorithm.difficulty),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: AppColors.neonTeal.withValues(
                            alpha: 0.18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(algorithm.description, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _ComplexityChip(label: 'Best', value: algorithm.complexity.best),
              _ComplexityChip(
                label: 'Average',
                value: algorithm.complexity.average,
              ),
              _ComplexityChip(
                label: 'Worst',
                value: algorithm.complexity.worst,
              ),
              _ComplexityChip(
                label: 'Space',
                value: algorithm.complexity.space,
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String category) {
    return switch (category) {
      'Graph Theory' => Icons.hub_rounded,
      'Dynamic Programming' => Icons.timeline_rounded,
      'Data Structures' => Icons.account_tree_rounded,
      'Search & Sort' => Icons.search_rounded,
      'Mathematics' => Icons.calculate_rounded,
      'Geometry' => Icons.category_rounded,
      _ => Icons.auto_awesome,
    };
  }
}

class _ComplexityChip extends StatelessWidget {
  const _ComplexityChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: AppColors.neonTeal.withValues(alpha: 0.35)),
      ),
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeViewer extends StatelessWidget {
  const _CodeViewer({required this.code, required this.language});

  final String code;
  final String language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.black.withValues(alpha: 0.4),
      ),
      child: SingleChildScrollView(
        child: SelectableText(
          code,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontFamily: 'SourceCodePro',
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
