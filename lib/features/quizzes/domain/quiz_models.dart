import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class QuizQuestion {
  QuizQuestion({
    required this.id,
    required this.algorithmId,
    required this.prompt,
    required this.choices,
    required this.correctIndex,
    required this.explanation,
    required this.difficulty,
    required this.category,
  });

  QuizQuestion.forAlgorithm({
    required String algorithmId,
    required String prompt,
    required List<String> choices,
    required int correctIndex,
    required String explanation,
    required String difficulty,
    required String category,
  }) : this(
         id: _uuid.v4(),
         algorithmId: algorithmId,
         prompt: prompt,
         choices: choices,
         correctIndex: correctIndex,
         explanation: explanation,
         difficulty: difficulty,
         category: category,
       );

  final String id;
  final String algorithmId;
  final String prompt;
  final List<String> choices;
  final int correctIndex;
  final String explanation;
  final String difficulty;
  final String category;
}

class QuizAnswer {
  const QuizAnswer({required this.questionId, required this.selectedIndex});

  final String questionId;
  final int selectedIndex;
}

class QuizRunConfiguration {
  const QuizRunConfiguration({
    required this.questionCount,
    required this.selectedCategories,
    required this.difficulty,
  });

  final int questionCount;
  final Set<String> selectedCategories;
  final String difficulty;
}

class QuizResultPayload {
  const QuizResultPayload({required this.questions, required this.answers});

  final List<QuizQuestion> questions;
  final List<QuizAnswer> answers;

  int get correctAnswers {
    var total = 0;
    for (final answer in answers) {
      final question = questions.firstWhere((q) => q.id == answer.questionId);
      if (question.correctIndex == answer.selectedIndex) {
        total++;
      }
    }
    return total;
  }

  double get accuracy => correctAnswers / questions.length;
}
