import "package:cloud_firestore/cloud_firestore.dart";

class UserProgress {
  const UserProgress({
    required this.totalAlgorithms,
    required this.masteredAlgorithms,
    required this.activeDays,
    required this.quizAccuracy,
    required this.recentAlgorithmIds,
    required this.quizAttempts,
    required this.masteredAlgorithmIds,
    this.lastQuizDate,
  });

  final int totalAlgorithms;
  final int masteredAlgorithms;
  final int activeDays;
  final double quizAccuracy;
  final List<String> recentAlgorithmIds;
  final int quizAttempts;
  final List<String> masteredAlgorithmIds;
  final DateTime? lastQuizDate;

  double get completionRatio =>
      totalAlgorithms == 0 ? 0 : masteredAlgorithms / totalAlgorithms;

  static UserProgress zero({int totalAlgorithms = 50}) {
    return UserProgress(
      totalAlgorithms: totalAlgorithms,
      masteredAlgorithms: 0,
      activeDays: 0,
      quizAccuracy: 0,
      recentAlgorithmIds: const [],
      quizAttempts: 0,
      masteredAlgorithmIds: const [],
      lastQuizDate: null,
    );
  }

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      totalAlgorithms: json['totalAlgorithms'] as int? ?? 0,
      masteredAlgorithms: json['masteredAlgorithms'] as int? ?? 0,
      activeDays: json['activeDays'] as int? ?? 0,
      quizAccuracy: (json['quizAccuracy'] as num?)?.toDouble() ?? 0,
      recentAlgorithmIds:
          (json['recentAlgorithmIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      quizAttempts: json['quizAttempts'] as int? ?? 0,
      masteredAlgorithmIds:
          (json['masteredAlgorithmIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastQuizDate: (json['lastQuizDate'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAlgorithms': totalAlgorithms,
      'masteredAlgorithms': masteredAlgorithms,
      'activeDays': activeDays,
      'quizAccuracy': quizAccuracy,
      'recentAlgorithmIds': recentAlgorithmIds,
      'quizAttempts': quizAttempts,
      'masteredAlgorithmIds': masteredAlgorithmIds,
      if (lastQuizDate != null)
        'lastQuizDate': Timestamp.fromDate(lastQuizDate!),
    };
  }

  UserProgress copyWith({
    int? totalAlgorithms,
    int? masteredAlgorithms,
    int? activeDays,
    double? quizAccuracy,
    List<String>? recentAlgorithmIds,
    int? quizAttempts,
    List<String>? masteredAlgorithmIds,
    DateTime? lastQuizDate,
  }) {
    return UserProgress(
      totalAlgorithms: totalAlgorithms ?? this.totalAlgorithms,
      masteredAlgorithms: masteredAlgorithms ?? this.masteredAlgorithms,
      activeDays: activeDays ?? this.activeDays,
      quizAccuracy: quizAccuracy ?? this.quizAccuracy,
      recentAlgorithmIds: recentAlgorithmIds ?? this.recentAlgorithmIds,
      quizAttempts: quizAttempts ?? this.quizAttempts,
      masteredAlgorithmIds: masteredAlgorithmIds ?? this.masteredAlgorithmIds,
      lastQuizDate: lastQuizDate ?? this.lastQuizDate,
    );
  }

  static UserProgress demo() {
    return UserProgress.zero(totalAlgorithms: 50);
  }
}
