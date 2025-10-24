import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class TopicPerformance {
  const TopicPerformance({
    required this.topic,
    required this.correct,
    required this.total,
    this.lastReviewed,
  });

  final String topic;
  final int correct;
  final int total;
  final DateTime? lastReviewed;

  double get accuracy => total == 0 ? 0 : correct / total;

  int get incorrect => (total - correct).clamp(0, total);

  bool get isStrong => total >= 3 && accuracy >= 0.8;

  bool get isWeak => total >= 2 && accuracy < 0.6;

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'total': total,
      if (lastReviewed != null)
        'lastReviewed': Timestamp.fromDate(lastReviewed!),
    };
  }

  factory TopicPerformance.fromJson(String topic, Map<String, dynamic> json) {
    return TopicPerformance(
      topic: topic,
      correct: (json['correct'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      lastReviewed: (json['lastReviewed'] as Timestamp?)?.toDate(),
    );
  }
}

class QuizTopicBreakdown {
  const QuizTopicBreakdown({
    required this.topic,
    required this.correct,
    required this.total,
  });

  final String topic;
  final int correct;
  final int total;

  double get accuracy => total == 0 ? 0 : correct / total;
}

class QuizSummary {
  QuizSummary({
    required this.score,
    required this.totalQuestions,
    required this.timestamp,
    required this.topicBreakdown,
    required this.correctTopics,
    required this.incorrectTopics,
  });

  final double score;
  final int totalQuestions;
  final DateTime timestamp;
  final Map<String, QuizTopicBreakdown> topicBreakdown;
  final List<String> correctTopics;
  final List<String> incorrectTopics;

  double get percentage => (score * 100).clamp(0, 100);

  List<String> get weakTopics => topicBreakdown.entries
      .where((entry) => entry.value.accuracy < 0.6)
      .map((entry) => entry.key)
      .toList();

  List<String> get strongTopics => topicBreakdown.entries
      .where((entry) => entry.value.accuracy >= 0.85)
      .map((entry) => entry.key)
      .toList();

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'totalQuestions': totalQuestions,
      'timestamp': Timestamp.fromDate(timestamp),
      'topicBreakdown': topicBreakdown.map((key, value) {
        return MapEntry(key, {'correct': value.correct, 'total': value.total});
      }),
      'correctTopics': correctTopics,
      'incorrectTopics': incorrectTopics,
    };
  }

  factory QuizSummary.fromJson(Map<String, dynamic> json) {
    final breakdown = (json['topicBreakdown'] as Map<String, dynamic>? ?? {})
        .map((key, value) {
          if (value is Map<String, dynamic>) {
            return MapEntry(
              key,
              QuizTopicBreakdown(
                topic: key,
                correct: (value['correct'] as num?)?.toInt() ?? 0,
                total: (value['total'] as num?)?.toInt() ?? 0,
              ),
            );
          }
          return MapEntry(
            key,
            QuizTopicBreakdown(topic: key, correct: 0, total: 0),
          );
        });

    return QuizSummary(
      score: (json['score'] as num?)?.toDouble() ?? 0,
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
      timestamp: (json['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      topicBreakdown: breakdown,
      correctTopics: (json['correctTopics'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      incorrectTopics: (json['incorrectTopics'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

class AnalyticsReportSection {
  const AnalyticsReportSection({required this.title, required this.items});

  final String title;
  final List<String> items;
}

class UserAnalytics {
  const UserAnalytics({
    required this.totalQuizzes,
    required this.totalScore,
    required this.topicPerformance,
    required this.recentQuizzes,
    required this.algorithmViews,
    this.updatedAt,
  });

  final int totalQuizzes;
  final double totalScore;
  final Map<String, TopicPerformance> topicPerformance;
  final List<QuizSummary> recentQuizzes;
  final Map<String, DateTime> algorithmViews;
  final DateTime? updatedAt;

  static UserAnalytics empty() => const UserAnalytics(
    totalQuizzes: 0,
    totalScore: 0,
    topicPerformance: {},
    recentQuizzes: [],
    algorithmViews: {},
  );

  double get averageScore =>
      totalQuizzes == 0 ? 0 : (totalScore / totalQuizzes).clamp(0, 1);

  double get bestScore => recentQuizzes.isEmpty
      ? 0
      : recentQuizzes.map((quiz) => quiz.score).reduce(max);

  double get latestScore =>
      recentQuizzes.isEmpty ? 0 : recentQuizzes.first.score;

  List<QuizSummary> get quizHistory => recentQuizzes;

  List<TopicPerformance> get weakTopics =>
      topicPerformance.values.where((topic) => topic.isWeak).toList()
        ..sort((a, b) => a.accuracy.compareTo(b.accuracy));

  List<TopicPerformance> get strongTopics =>
      topicPerformance.values.where((topic) => topic.isStrong).toList()
        ..sort((a, b) => b.accuracy.compareTo(a.accuracy));

  List<String> buildRecommendations() {
    if (totalQuizzes == 0) {
      return [
        'Take your first adaptive quiz to unlock personalised insights.',
        'Explore the algorithm library to bookmark concepts you want to master.',
      ];
    }

    final items = <String>[];
    if (weakTopics.isNotEmpty) {
      final focusTopics = weakTopics.take(3).map((e) => e.topic).join(', ');
      items.add(
        'Review visual walkthroughs for $focusTopics. Re-test after practicing to lock in progress.',
      );
    }
    if (recentQuizzes.length >= 2) {
      final trend = latestScore - recentQuizzes[1].score;
      if (trend >= 0.05) {
        items.add(
          'Great job increasing your score by ${(trend * 100).round()}%. Keep the streak with another quiz this week.',
        );
      } else if (trend <= -0.05) {
        items.add(
          'Scores dipped slightly in your latest quiz. Revisit the topics highlighted in the detailed breakdown before your next attempt.',
        );
      }
    }
    if (items.isEmpty) {
      items.add(
        'Maintain your consistency by scheduling a quiz every few days and revisiting saved notes.',
      );
    }
    return items;
  }

  List<AnalyticsReportSection> buildReport() {
    final sections = <AnalyticsReportSection>[];

    sections.add(
      AnalyticsReportSection(
        title: 'Overall performance',
        items: [
          'Quizzes completed: $totalQuizzes',
          'Average score: ${(averageScore * 100).toStringAsFixed(1)}%',
          if (recentQuizzes.isNotEmpty)
            'Latest score: ${(latestScore * 100).toStringAsFixed(1)}%',
          if (recentQuizzes.length >= 3)
            'Best score: ${(bestScore * 100).toStringAsFixed(1)}%',
        ],
      ),
    );

    if (recentQuizzes.isNotEmpty) {
      final history = recentQuizzes
          .map(
            (quiz) =>
                '${quiz.timestamp.toLocal()} — ${(quiz.percentage).toStringAsFixed(0)}% '
                '(Correct: ${quiz.correctTopics.length}, Incorrect: ${quiz.incorrectTopics.length})',
          )
          .toList();
      sections.add(
        AnalyticsReportSection(title: 'Quiz history', items: history),
      );
    }

    if (topicPerformance.isNotEmpty) {
      final strong = strongTopics.map((topic) {
        return '${topic.topic}: ${(topic.accuracy * 100).toStringAsFixed(0)}% accuracy across ${topic.total} questions.';
      }).toList();
      if (strong.isNotEmpty) {
        sections.add(AnalyticsReportSection(title: 'Strengths', items: strong));
      }

      final improvements = weakTopics.map((topic) {
        return '${topic.topic}: ${(topic.accuracy * 100).toStringAsFixed(0)}% accuracy '
            '(${topic.correct}/${topic.total} correct). Re-watch the visual walkthrough and attempt a targeted quiz.';
      }).toList();
      if (improvements.isNotEmpty) {
        sections.add(
          AnalyticsReportSection(
            title: 'Improvement opportunities',
            items: improvements,
          ),
        );
      }
    }

    return sections;
  }

  factory UserAnalytics.fromJson(Map<String, dynamic> json) {
    final topicStats =
        (json['topicStats'] as Map<String, dynamic>? ?? <String, dynamic>{})
            .map((key, value) {
              if (value is Map<String, dynamic>) {
                return MapEntry(key, TopicPerformance.fromJson(key, value));
              }
              return MapEntry(
                key,
                TopicPerformance(topic: key, correct: 0, total: 0),
              );
            });

    final quizzes =
        (json['recentQuizzes'] as List<dynamic>? ?? <dynamic>[]).map((entry) {
          if (entry is Map<String, dynamic>) {
            return QuizSummary.fromJson(entry);
          }
          return QuizSummary(
            score: 0,
            totalQuestions: 0,
            timestamp: DateTime.now(),
            topicBreakdown: const {},
            correctTopics: const [],
            incorrectTopics: const [],
          );
        }).toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final views =
        (json['algorithmViews'] as Map<String, dynamic>? ?? <String, dynamic>{})
            .map((key, value) {
              if (value is Timestamp) {
                return MapEntry(key, value.toDate());
              }
              if (value is DateTime) {
                return MapEntry(key, value);
              }
              return MapEntry(key, DateTime.now());
            });

    return UserAnalytics(
      totalQuizzes: (json['totalQuizzes'] as num?)?.toInt() ?? 0,
      totalScore: (json['totalScore'] as num?)?.toDouble() ?? 0,
      topicPerformance: topicStats,
      recentQuizzes: quizzes,
      algorithmViews: views,
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }
}
