import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/async_value_widget.dart';
import 'package:visual_algo/core/widgets/glass_app_bar.dart';
import 'package:visual_algo/core/widgets/glass_container.dart';
import 'package:visual_algo/features/algorithms/providers.dart';
import 'package:visual_algo/features/quizzes/domain/quiz_models.dart';
import 'package:visual_algo/features/quizzes/presentation/quiz_run_screen.dart';

class QuizSetupScreen extends ConsumerStatefulWidget {
  const QuizSetupScreen({super.key});

  static const routeSegment = 'quiz';
  static const routeName = 'quiz-setup';

  @override
  ConsumerState<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends ConsumerState<QuizSetupScreen> {
  int _questionCount = 8;
  final Set<String> _selectedCategories = {};
  String _difficulty = 'All';

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(algorithmCatalogProvider);

    return AppScaffold(
      extendBodyBehindAppBar: false,
      appBar: const GlassAppBar(title: 'Adaptive Quiz Builder'),
      body: AsyncValueWidget(
        value: catalogAsync,
        data: (algorithms) {
          final categories = {
            for (final algorithm in algorithms) algorithm.category,
          }.toList()..sort();
          return LayoutBuilder(
            builder: (context, constraints) {
              final paddingBottom = MediaQuery.of(context).padding.bottom + 32;
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, 24, 24, paddingBottom),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Craft your perfect challenge',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 24),
                        GlassContainer(
                          padding: const EdgeInsets.all(24),
                          child: _buildQuestionSlider(),
                        ),
                        const SizedBox(height: 24),
                        GlassContainer(
                          padding: const EdgeInsets.all(24),
                          child: _buildCategorySelector(categories),
                        ),
                        const SizedBox(height: 24),
                        GlassContainer(
                          padding: const EdgeInsets.all(24),
                          child: _buildDifficultySelector(),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {
                              final configuration = QuizRunConfiguration(
                                questionCount: _questionCount,
                                selectedCategories: _selectedCategories,
                                difficulty: _difficulty,
                              );
                              context.pushNamed(
                                QuizRunScreen.routeName,
                                extra: configuration,
                              );
                            },
                            icon: const Icon(Icons.bolt_rounded),
                            label: const Text('Launch adaptive quiz'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildQuestionSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Number of questions'),
            Text('$_questionCount questions'),
          ],
        ),
        Slider(
          value: _questionCount.toDouble(),
          min: 5,
          max: 20,
          divisions: 15,
          label: '$_questionCount',
          onChanged: (value) {
            setState(() {
              _questionCount = value.round();
            });
          },
        ),
      ],
    );
  }

  Widget _buildCategorySelector(List<String> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Focus areas'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            final selected = _selectedCategories.contains(category);
            return FilterChip(
              label: Text(category),
              selected: selected,
              onSelected: (value) {
                setState(() {
                  if (value) {
                    _selectedCategories.add(category);
                  } else {
                    _selectedCategories.remove(category);
                  }
                });
              },
            );
          }).toList(),
        ),
        if (_selectedCategories.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Tip: leave empty for a cross-category challenge.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }

  Widget _buildDifficultySelector() {
    final difficulties = ['All', 'Beginner', 'Intermediate', 'Advanced'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Difficulty targeting'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: difficulties.map((difficulty) {
            return ChoiceChip(
              label: Text(difficulty),
              selected: _difficulty == difficulty,
              onSelected: (selected) {
                if (!selected) return;
                setState(() {
                  _difficulty = difficulty;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
