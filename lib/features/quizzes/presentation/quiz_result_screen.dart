import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/glass_app_bar.dart';
import 'package:visual_algo/core/widgets/glass_container.dart';
import 'package:visual_algo/features/analytics/providers.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/home/providers.dart';
import 'package:visual_algo/features/quizzes/domain/quiz_models.dart';

class QuizResultScreen extends ConsumerStatefulWidget {
  const QuizResultScreen({super.key, required this.result});

  final QuizResultPayload result;

  static const routeSegment = 'quiz/result';
  static const routeName = 'quiz-result';

  @override
  ConsumerState<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends ConsumerState<QuizResultScreen> {
  bool _recorded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_recorded) return;
    final user = ref.read(currentUserProvider);
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final analyticsRepo = ref.read(userAnalyticsRepositoryProvider);
        final progressRepo = ref.read(userProgressRepositoryProvider);
        await Future.wait([
          analyticsRepo.recordQuizResult(user, widget.result),
          progressRepo.recordQuizAttempt(user, widget.result),
        ]);
        ref.invalidate(userAnalyticsStreamProvider);
        ref.invalidate(userProgressStreamProvider);
      });
    }
    _recorded = true;
  }

  @override
  Widget build(BuildContext context) {
    final accuracyPercentage = (widget.result.accuracy * 100).round();
    final theme = Theme.of(context);

    return AppScaffold(
      extendBodyBehindAppBar: false,
      appBar: const GlassAppBar(title: 'Quiz results'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.neonTeal.withValues(alpha: 0.2),
                  child: Text(
                    '$accuracyPercentage%',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.neonTeal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You answered ${widget.result.correctAnswers} of ${widget.result.questions.length} correctly.',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _feedbackLabel(widget.result.accuracy),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: widget.result.questions.length,
                itemBuilder: (context, index) {
                  final question = widget.result.questions[index];
                  final givenAnswer = widget.result.answers
                      .firstWhere((answer) => answer.questionId == question.id)
                      .selectedIndex;
                  final isCorrect = givenAnswer == question.correctIndex;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.04),
                          Colors.white.withValues(alpha: 0.01),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                isCorrect ? Icons.check_circle : Icons.cancel,
                                color: isCorrect
                                    ? AppColors.successGreen
                                    : AppColors.errorRed,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  question.prompt,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...List.generate(question.choices.length, (
                            choiceIndex,
                          ) {
                            final choice = question.choices[choiceIndex];
                            final isAnswer =
                                choiceIndex == question.correctIndex;
                            final isSelection = choiceIndex == givenAnswer;
                            final color = isSelection
                                ? (isAnswer
                                      ? AppColors.successGreen
                                      : AppColors.errorRed)
                                : theme.textTheme.bodyMedium?.color;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    isAnswer
                                        ? Icons.check_circle_outline
                                        : Icons.radio_button_unchecked,
                                    color: isAnswer
                                        ? AppColors.successGreen
                                        : Colors.white54,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      choice,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(color: color),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withValues(alpha: 0.04),
                            ),
                            child: Text(
                              question.explanation,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton(
                  onPressed: () => context.go('/home/quiz'),
                  child: const Text('Retry with new quiz'),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Back to dashboard'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _feedbackLabel(double accuracy) {
    if (accuracy >= 0.9) {
      return 'Spectacular mastery! Keep pushing the envelope.';
    }
    if (accuracy >= 0.7) {
      return 'Great job! Review the tricky ones to cement mastery.';
    }
    if (accuracy >= 0.5) {
      return 'Solid attempt. Revisit the walkthroughs for stronger intuition.';
    }
    return 'Every expert starts somewhere. Re-watch the visuals and try again!';
  }
}
