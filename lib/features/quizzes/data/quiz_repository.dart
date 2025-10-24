import 'dart:math';
import 'package:collection/collection.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';
import 'package:visual_algo/features/quizzes/domain/quiz_models.dart';

class QuizRepository {
  const QuizRepository();

  List<QuizQuestion> createQuiz({
    required List<AlgorithmModel> algorithms,
    required QuizRunConfiguration configuration,
  }) {
    final random = Random();
    final categories = configuration.selectedCategories;
    final filteredAlgorithms = algorithms.where((algorithm) {
      final matchesCategory =
          categories.isEmpty || categories.contains(algorithm.category);
      final matchesDifficulty =
          configuration.difficulty == 'All' ||
          configuration.difficulty == algorithm.difficulty;
      return matchesCategory && matchesDifficulty;
    }).toList();

    final pool = filteredAlgorithms.isEmpty ? algorithms : filteredAlgorithms;
    final questions = <QuizQuestion>[];

    for (final algorithm in pool) {
      questions.addAll([
        _categoryQuestion(algorithm, algorithms, random),
        _complexityQuestion(algorithm, random),
        _scenarioQuestion(algorithm, random),
        _comparisonQuestion(algorithm, algorithms, random),
        _conceptualQuestion(algorithm, random),
      ]);
    }

    questions.shuffle(random);
    return questions.take(configuration.questionCount).toList();
  }

  QuizQuestion _categoryQuestion(
    AlgorithmModel algorithm,
    List<AlgorithmModel> catalog,
    Random random,
  ) {
    final uniqueCategories = {for (final e in catalog) e.category}.toList()
      ..shuffle(random);

    final distractors = uniqueCategories
        .whereNot((c) => c == algorithm.category)
        .take(3)
        .toList();

    final choices = [...distractors, algorithm.category]..shuffle(random);
    final correctIndex = choices.indexOf(algorithm.category);

    return QuizQuestion.forAlgorithm(
      algorithmId: algorithm.id,
      prompt:
          'Which domain best describes the ${algorithm.name} algorithm\'s primary purpose?',
      choices: choices,
      correctIndex: correctIndex,
      explanation:
          '${algorithm.name} mainly falls under the ${algorithm.category.toLowerCase()} category because of its design goal and application domain.',
      difficulty: algorithm.difficulty,
      category: algorithm.category,
    );
  }

  QuizQuestion _complexityQuestion(AlgorithmModel algorithm, Random random) {
    final pool = [
      'O(1)', 'O(log n)', 'O(n)', 'O(n log n)', 'O(n^2)',
      'O(n^3)', 'O(2^n)', 'O(n!)',
      algorithm.complexity.best,
      algorithm.complexity.average,
      algorithm.complexity.worst,
    ]..shuffle(random);

    final correct = algorithm.complexity.worst;
    final choices = (pool..remove(correct)).take(3).toList()..add(correct);
    choices.shuffle(random);

    return QuizQuestion.forAlgorithm(
      algorithmId: algorithm.id,
      prompt:
          'What is the *worst-case* time complexity of ${algorithm.name}, and why is it classified as such?',
      choices: choices,
      correctIndex: choices.indexOf(correct),
      explanation:
          'The worst-case reflects the slowest growth rate under unfavorable input. ${algorithm.name} performs at ${algorithm.complexity.worst} in that case.',
      difficulty: algorithm.difficulty,
      category: algorithm.category,
    );
  }

  QuizQuestion _scenarioQuestion(AlgorithmModel algorithm, Random random) {
    final scenarios = [
      'when the input is already sorted',
      'when all elements are equal',
      'when the data size doubles',
      'when the input contains many duplicates',
    ];
    final selected = scenarios[random.nextInt(scenarios.length)];

    final distractors = [
      'Its average time complexity applies instead.',
      'Its performance becomes worse than expected.',
      'It runs in constant time regardless of input.',
    ]..shuffle(random);

    final choices = [...distractors, 'It runs in ${algorithm.complexity.best}.']
      ..shuffle(random);

    return QuizQuestion.forAlgorithm(
      algorithmId: algorithm.id,
      prompt:
          'How does ${algorithm.name} behave $selected? Choose the most accurate answer.',
      choices: choices,
      correctIndex: choices.indexWhere(
          (c) => c.contains(algorithm.complexity.best) || c.contains('runs in')),
      explanation:
          'Under $selected, ${algorithm.name} achieves its best performance (${algorithm.complexity.best}), since less work is needed compared to the general case.',
      difficulty: 'Hard',
      category: algorithm.category,
    );
  }

  QuizQuestion _comparisonQuestion(
    AlgorithmModel algorithm,
    List<AlgorithmModel> catalog,
    Random random,
  ) {
    final others = (catalog..shuffle(random))
        .whereNot((a) => a.id == algorithm.id)
        .take(3)
        .toList();

    final options = [algorithm, ...others]..shuffle(random);
    final correct = options.reduce((a, b) =>
        _complexityRank(a.complexity.worst) < _complexityRank(b.complexity.worst)
            ? a
            : b);

    final choices = options.map((a) => a.name).toList();

    return QuizQuestion.forAlgorithm(
      algorithmId: algorithm.id,
      prompt:
          'Which of the following algorithms generally has the **lowest time complexity** in the worst case?',
      choices: choices,
      correctIndex: choices.indexOf(correct.name),
      explanation:
          '${correct.name} has the best theoretical performance (worst-case ${correct.complexity.worst}) compared to the others listed.',
      difficulty: 'Hard',
      category: algorithm.category,
    );
  }

  QuizQuestion _conceptualQuestion(AlgorithmModel algorithm, Random random) {
    final conceptTemplates = [
      'What property of ${algorithm.name} ensures it always produces a stable output?',
      'Why is ${algorithm.name} considered better for large data sets than simpler algorithms like Bubble Sort?',
      'In what situation would ${algorithm.name} be less efficient than a linear approach?',
    ];

    final prompt = conceptTemplates[random.nextInt(conceptTemplates.length)];
    final choices = [
      'It divides the input into subproblems recursively.',
      'It uses extra space to maintain order stability.',
      'It avoids unnecessary comparisons by early termination.',
      'It performs parallel computation of subarrays.',
    ]..shuffle(random);

    return QuizQuestion.forAlgorithm(
      algorithmId: algorithm.id,
      prompt: prompt,
      choices: choices,
      correctIndex: 1,
      explanation:
          'The stability and efficiency of ${algorithm.name} depend on its divide-and-conquer structure and space usage for merging/sorting.',
      difficulty: 'Advanced',
      category: algorithm.category,
    );
  }

  int _complexityRank(String c) {
    const order = [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(n^2)',
      'O(n^3)',
      'O(2^n)',
      'O(n!)'
    ];
    return order.indexOf(c);
  }
}
