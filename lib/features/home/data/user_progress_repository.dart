import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_algo/features/auth/domain/auth_user.dart';
import 'package:visual_algo/features/home/domain/user_progress.dart';
import 'package:visual_algo/features/quizzes/domain/quiz_models.dart';

class UserProgressRepository {
  UserProgressRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<UserProgress> watchProgress(AuthUser? user) {
    if (user == null) {
      return Stream.value(UserProgress.zero(totalAlgorithms: 50));
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('meta')
        .doc('progress')
        .snapshots()
        .map((snapshot) {
          if (!snapshot.exists) {
            return UserProgress.zero(totalAlgorithms: 50);
          }
          return UserProgress.fromJson(snapshot.data()!);
        });
  }

  Future<void> saveRecentAlgorithm(AuthUser user, String algorithmId) async {
    final ref = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('meta')
        .doc('progress');
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      final data = snapshot.data() ?? {};
      final recent = (data['recentAlgorithmIds'] as List<dynamic>? ?? [])
          .map((item) => item as String)
          .toList();
      recent.remove(algorithmId);
      recent.insert(0, algorithmId);
      if (recent.length > 5) {
        recent.removeRange(5, recent.length);
      }
      transaction.set(ref, {
        ...data,
        'recentAlgorithmIds': recent,
        'masteredAlgorithms': data['masteredAlgorithms'] ?? 0,
        'totalAlgorithms': data['totalAlgorithms'] ?? 50,
        'masteredAlgorithmIds':
            (data['masteredAlgorithmIds'] as List<dynamic>? ?? []),
      }, SetOptions(merge: true));
    });
  }

  Future<void> recordQuizAttempt(
    AuthUser user,
    QuizResultPayload result,
  ) async {
    final ref = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('meta')
        .doc('progress');

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      final data = snapshot.data() ?? <String, dynamic>{};
      final masteredIds = <String>{
        ...(data['masteredAlgorithmIds'] as List<dynamic>? ?? [])
            .whereType<String>(),
      };

      for (final question in result.questions) {
        final answer = result.answers.firstWhere(
          (element) => element.questionId == question.id,
        );
        if (answer.selectedIndex == question.correctIndex) {
          masteredIds.add(question.algorithmId);
        }
      }

      final now = DateTime.now();
      final lastQuizTimestamp = data['lastQuizDate'] as Timestamp?;
      final lastQuizDate = lastQuizTimestamp?.toDate();
      var activeDays = (data['activeDays'] as num?)?.toInt() ?? 0;
      if (lastQuizDate == null || !_isSameDay(lastQuizDate, now)) {
        activeDays += 1;
      }

      final previousAttempts = (data['quizAttempts'] as num?)?.toInt() ?? 0;
      final cumulativeAccuracy =
          (data['cumulativeAccuracy'] as num?)?.toDouble() ?? 0;
      final newAttempts = previousAttempts + 1;
      final newCumulativeAccuracy = cumulativeAccuracy + result.accuracy;
      final newAverageAccuracy = newCumulativeAccuracy / newAttempts;

      transaction.set(ref, {
        'totalAlgorithms': data['totalAlgorithms'] ?? 50,
        'recentAlgorithmIds':
            (data['recentAlgorithmIds'] as List<dynamic>? ?? []),
        'masteredAlgorithmIds': masteredIds.toList(growable: false),
        'masteredAlgorithms': masteredIds.length,
        'activeDays': activeDays,
        'lastQuizDate': Timestamp.fromDate(now),
        'quizAttempts': newAttempts,
        'quizAccuracy': newAverageAccuracy,
        'cumulativeAccuracy': newCumulativeAccuracy,
      }, SetOptions(merge: true));
    });
  }

  Future<void> storeLocalPreference(String algorithmId) async {
    final prefs = await SharedPreferences.getInstance();
    final recent = prefs.getStringList('recent_algorithms') ?? <String>[];
    recent.remove(algorithmId);
    recent.insert(0, algorithmId);
    await prefs.setStringList('recent_algorithms', recent.take(5).toList());
  }
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
