import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/layout/responsive_layout.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/async_value_widget.dart';
import 'package:visual_algo/core/widgets/glass_container.dart';
import 'package:visual_algo/core/widgets/glass_app_bar.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_complexity.dart';
import 'package:visual_algo/features/algorithms/presentation/algorithm_detail_screen.dart';
import 'package:visual_algo/features/algorithms/providers.dart';
import 'package:visual_algo/features/auth/providers.dart';

class AlgorithmCatalogScreen extends ConsumerStatefulWidget {
  const AlgorithmCatalogScreen({super.key});

  static const routeSegment = 'algorithms';
  static const routeName = 'algorithm-catalog';

  @override
  ConsumerState<AlgorithmCatalogScreen> createState() =>
      _AlgorithmCatalogScreenState();
}

class _AlgorithmCatalogScreenState
    extends ConsumerState<AlgorithmCatalogScreen> {
  final _searchController = TextEditingController();
  String _difficultyFilter = 'All';
  String _categoryFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(algorithmCatalogProvider);
    final user = ref.watch(currentUserProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      extendBodyBehindAppBar: false,
      appBar: GlassAppBar(
        title: 'Algorithm Atlas',
        actions: [
          if (user != null)
            IconButton(
              tooltip: 'Sign out',
              onPressed: () =>
                  ref.read(authViewModelProvider.notifier).signOut(),
              icon: const Icon(Icons.logout_rounded),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore 50+ expertly curated algorithms with cinematic visualisations.',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            _buildFilters(theme),
            const SizedBox(height: 18),
            Expanded(
              child: AsyncValueWidget<List<AlgorithmModel>>(
                value: catalogAsync,
                data: (algorithms) {
                  final filtered = _applyFilters(algorithms);
                  return ResponsiveLayout(
                    builder: (context, size) {
                      final crossAxisCount = switch (size) {
                        LayoutSize.expanded => 3,
                        LayoutSize.medium => 2,
                        LayoutSize.compact => 1,
                      };
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 24),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: size == LayoutSize.compact
                              ? 3 / 2
                              : 16 / 11.5,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final algorithm = filtered[index];
                          return _AlgorithmCard(
                            algorithm: algorithm,
                            locked: user == null,
                            onTap: () =>
                                _handleAlgorithmTap(context, algorithm, user),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(ThemeData theme) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search by name, concept, or tag...',
            ),
          ),
        ),
        DropdownButton<String>(
          value: _difficultyFilter,
          dropdownColor: theme.colorScheme.surface,
          items: const [
            DropdownMenuItem(
              value: 'All',
              child: Text('All difficulty levels'),
            ),
            DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
            DropdownMenuItem(
              value: 'Intermediate',
              child: Text('Intermediate'),
            ),
            DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
          ],
          onChanged: (value) => setState(() {
            _difficultyFilter = value ?? 'All';
          }),
        ),
        DropdownButton<String>(
          value: _categoryFilter,
          dropdownColor: theme.colorScheme.surface,
          items: const [
            DropdownMenuItem(value: 'All', child: Text('All categories')),
            DropdownMenuItem(
              value: 'Graph Theory',
              child: Text('Graph Theory'),
            ),
            DropdownMenuItem(
              value: 'Dynamic Programming',
              child: Text('Dynamic Programming'),
            ),
            DropdownMenuItem(
              value: 'Data Structures',
              child: Text('Data Structures'),
            ),
            DropdownMenuItem(
              value: 'Search & Sort',
              child: Text('Search & Sort'),
            ),
            DropdownMenuItem(value: 'Geometry', child: Text('Geometry')),
            DropdownMenuItem(value: 'Mathematics', child: Text('Mathematics')),
          ],
          onChanged: (value) => setState(() {
            _categoryFilter = value ?? 'All';
          }),
        ),
      ],
    );
  }

  List<AlgorithmModel> _applyFilters(List<AlgorithmModel> algorithms) {
    final query = _searchController.text.trim().toLowerCase();
    return algorithms.where((algorithm) {
      final matchesQuery =
          query.isEmpty ||
          algorithm.name.toLowerCase().contains(query) ||
          algorithm.tags.any((tag) => tag.toLowerCase().contains(query));
      final matchesDifficulty =
          _difficultyFilter == 'All' ||
          algorithm.difficulty == _difficultyFilter;
      final matchesCategory =
          _categoryFilter == 'All' || algorithm.category == _categoryFilter;
      return matchesQuery && matchesDifficulty && matchesCategory;
    }).toList();
  }

  Future<void> _handleAlgorithmTap(
    BuildContext context,
    AlgorithmModel algorithm,
    dynamic user,
  ) async {
    if (user == null) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign in required'),
          content: const Text(
            'Create a free AlgorithMat account to unlock interactive visualisations, '
            'track your progress, and sync across devices.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                GoRouter.of(context).go('/auth/sign-up');
              },
              child: const Text('Create account'),
            ),
          ],
        ),
      );
      return;
    }
    if (!mounted) return;
    context.pushNamed(
      AlgorithmDetailScreen.routeName,
      pathParameters: {'algorithmId': algorithm.id},
    );
  }
}

class _AlgorithmCard extends StatelessWidget {
  const _AlgorithmCard({
    required this.algorithm,
    required this.onTap,
    required this.locked,
  });

  final AlgorithmModel algorithm;
  final VoidCallback onTap;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight * 0.9,
                  maxHeight: constraints.maxHeight + 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: theme.colorScheme.secondary
                              .withValues(alpha: 0.12),
                          child: Icon(
                            _iconForCategory(algorithm.category),
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                algorithm.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                algorithm.category,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Chip(
                          label: Text(algorithm.difficulty),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: theme.colorScheme.primary.withValues(
                            alpha: 0.15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      algorithm.description,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    _ComplexitySummary(complexity: algorithm.complexity),
                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: algorithm.tags.take(4).map((tag) {
                        return Chip(
                          label: Text(tag),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        locked
                            ? Icons.lock_outline
                            : Icons.play_circle_fill_rounded,
                        color: locked
                            ? Colors.orangeAccent
                            : Colors.greenAccent,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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

class _ComplexitySummary extends StatelessWidget {
  const _ComplexitySummary({required this.complexity});

  final AlgorithmComplexity complexity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      ('Best', complexity.best),
      ('Avg', complexity.average),
      ('Worst', complexity.worst),
      ('Space', complexity.space),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(
                  color: AppColors.neonTeal.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                '${item.$1}: ${item.$2}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
