import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visual_algo/features/analytics/domain/user_analytics.dart';
import 'package:visual_algo/features/auth/domain/auth_user.dart';
import 'package:visual_algo/features/quizzes/domain/quiz_models.dart';

class UserAnalyticsRepository {
  UserAnalyticsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<UserAnalytics> watchAnalytics(AuthUser? user) {
    if (user == null) {
      return Stream.value(UserAnalytics.empty());
    }
    final doc = _summaryDoc(user.uid);
    return doc.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return UserAnalytics.empty();
      }
      return UserAnalytics.fromJson(snapshot.data()!);
    });
  }

  Future<void> recordAlgorithmView(AuthUser user, String algorithmId) async {
    final doc = _summaryDoc(user.uid);
    await doc.set({
      'algorithmViews': {algorithmId: FieldValue.serverTimestamp()},
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> recordQuizResult(
    AuthUser user,
    QuizResultPayload payload,
  ) async {
    final doc = _summaryDoc(user.uid);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(doc);
      final data = snapshot.data() ?? <String, dynamic>{};

      final totalQuizzes = (data['totalQuizzes'] as num?)?.toInt() ?? 0;
      final totalScore = (data['totalScore'] as num?)?.toDouble() ?? 0;
      final topicStats = Map<String, dynamic>.from(
        data['topicStats'] as Map? ?? {},
      );
      final recentQuizzes = List<Map<String, dynamic>>.from(
        data['recentQuizzes'] as List? ?? [],
      );

      var newTotalQuizzes = totalQuizzes + 1;
      var newTotalScore = totalScore + payload.accuracy;

      final weakTopics = <String>[];
      final strongTopics = <String>[];
      final topicBreakdown = <String, Map<String, int>>{};
      final correctTopicSet = <String>{};
      final incorrectTopicSet = <String>{};

      for (final question in payload.questions) {
        final topic = question.category;
        final stat = Map<String, dynamic>.from(topicStats[topic] as Map? ?? {});
        final correct = (stat['correct'] as num?)?.toInt() ?? 0;
        final total = (stat['total'] as num?)?.toInt() ?? 0;
        final userAnswer = payload.answers.firstWhere(
          (answer) => answer.questionId == question.id,
        );
        final isCorrect = userAnswer.selectedIndex == question.correctIndex;
        topicStats[topic] = {
          'correct': isCorrect ? correct + 1 : correct,
          'total': total + 1,
        };
        final accuracy =
            (isCorrect ? correct + 1 : correct) / max(1, total + 1);
        if (accuracy < 0.7) {
          weakTopics.add(topic);
        } else if (accuracy >= 0.85 && total + 1 >= 3) {
          strongTopics.add(topic);
        }

        final breakdown = topicBreakdown.putIfAbsent(
          topic,
          () => {'correct': 0, 'total': 0},
        );
        breakdown['total'] = (breakdown['total'] ?? 0) + 1;
        if (isCorrect) {
          breakdown['correct'] = (breakdown['correct'] ?? 0) + 1;
          correctTopicSet.add(topic);
        } else {
          incorrectTopicSet.add(topic);
        }
      }

      final now = DateTime.now();
      recentQuizzes.insert(0, {
        'score': payload.accuracy,
        'totalQuestions': payload.questions.length,
        'timestamp': Timestamp.fromDate(now),
        'weakTopics': weakTopics,
        'strongTopics': strongTopics,
        'topicBreakdown': topicBreakdown,
        'correctTopics': correctTopicSet.toList(),
        'incorrectTopics': incorrectTopicSet.toList(),
      });
      if (recentQuizzes.length > 10) {
        recentQuizzes.removeRange(10, recentQuizzes.length);
      }

      transaction.set(doc, {
        'totalQuizzes': newTotalQuizzes,
        'totalScore': newTotalScore,
        'topicStats': topicStats,
        'recentQuizzes': recentQuizzes,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }

  DocumentReference<Map<String, dynamic>> _summaryDoc(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('analytics')
        .doc('summary');
  }
}
