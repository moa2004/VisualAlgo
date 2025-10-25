import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/async_value_widget.dart';
import 'package:visual_algo/features/algorithms/providers.dart';
import 'package:visual_algo/features/quizzes/data/quiz_repository.dart';
import 'package:visual_algo/features/quizzes/domain/quiz_models.dart';
import 'package:visual_algo/features/quizzes/presentation/quiz_result_screen.dart';

class QuizRunScreen extends ConsumerStatefulWidget {
  const QuizRunScreen({super.key, required this.configuration});

  final QuizRunConfiguration configuration;

  static const routeSegment = 'quiz/run';
  static const routeName = 'quiz-run';

  @override
  ConsumerState<QuizRunScreen> createState() => _QuizRunScreenState();
}

class _QuizRunScreenState extends ConsumerState<QuizRunScreen> {
  final PageController _pageController = PageController();
  final Map<String, int> _answers = {};
  List<QuizQuestion>? _questions;
  bool _showExplanation = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final algorithmsAsync = ref.watch(algorithmCatalogProvider);

    return AppScaffold(
      appBar: AppBar(title: const Text('Quiz in progress')),
      body: AsyncValueWidget(
        value: algorithmsAsync,
        data: (algorithms) {
          if (_questions == null) {
            final repository = const QuizRepository();
            final generated = repository.createQuiz(
              algorithms: algorithms,
              configuration: widget.configuration,
            );
            _questions = generated;
          }
          final questions = _questions!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: _answers.length / questions.length,
                      minHeight: 6,
                      color: AppColors.neonTeal,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Question ${(_pageController.hasClients ? _pageController.page?.round() ?? 0 : 0) + 1} of ${questions.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    final selected = _answers[question.id];
                    return _QuizQuestionCard(
                      question: question,
                      selectedIndex: selected,
                      onSelect: (choiceIndex) {
                        setState(() {
                          _answers[question.id] = choiceIndex;
                          _showExplanation = true;
                        });
                      },
                      showExplanation: _showExplanation && selected != null,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: _goPrevious,
                      child: const Text('Back'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _answers.length == questions.length
                          ? _submit
                          : _goNext,
                      child: Text(
                        _answers.length == questions.length
                            ? 'Submit quiz'
                            : 'Next',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _goPrevious() {
    if (!_pageController.hasClients) return;
    final page = _pageController.page?.round() ?? 0;
    if (page == 0) return;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _showExplanation = false;
    });
  }

  void _goNext() {
    if (!_pageController.hasClients) return;
    final page = _pageController.page?.round() ?? 0;
    if (page >= (_questions?.length ?? 0) - 1) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _showExplanation = false;
    });
  }

  void _submit() {
    final questions = _questions!;
    final answers = _answers.entries
        .map(
          (entry) =>
              QuizAnswer(questionId: entry.key, selectedIndex: entry.value),
        )
        .toList();
    final result = QuizResultPayload(questions: questions, answers: answers);
    context.pushReplacementNamed(QuizResultScreen.routeName, extra: result);
  }
}

class _QuizQuestionCard extends StatelessWidget {
  const _QuizQuestionCard({
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
    required this.showExplanation,
  });

  final QuizQuestion question;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;
  final bool showExplanation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withValues(alpha: 0.04),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text('${question.category} | ${question.difficulty}'),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
            ),
            const SizedBox(height: 12),
            Text(
              question.prompt,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(question.choices.length, (index) {
              final choice = question.choices[index];
              final isSelected = selectedIndex == index;
              Color borderColor = Colors.white.withValues(alpha: 0.12);
              if (showExplanation) {
                if (index == question.correctIndex) {
                  borderColor = AppColors.successGreen;
                } else if (isSelected) {
                  borderColor = AppColors.errorRed;
                }
              } else if (isSelected) {
                borderColor = AppColors.neonTeal;
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => onSelect(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: borderColor, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            String.fromCharCode(65 + index),
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              choice,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            if (showExplanation) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neonTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  question.explanation,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
