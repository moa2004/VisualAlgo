import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/features/analytics/data/user_analytics_repository.dart';
import 'package:visual_algo/features/analytics/domain/user_analytics.dart';
import 'package:visual_algo/features/auth/domain/auth_user.dart';
import 'package:visual_algo/features/auth/providers.dart';

final userAnalyticsRepositoryProvider = Provider<UserAnalyticsRepository>((
  ref,
) {
  return UserAnalyticsRepository();
});

final userAnalyticsStreamProvider = StreamProvider<UserAnalytics>((ref) {
  final repository = ref.watch(userAnalyticsRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  return repository.watchAnalytics(user);
});

final userAnalyticsProvider = Provider<UserAnalytics>((ref) {
  final asyncValue = ref.watch(userAnalyticsStreamProvider);
  return asyncValue.maybeWhen(
    data: (data) => data,
    orElse: UserAnalytics.empty,
  );
});

final currentUserNonNullProvider = Provider<AuthUser?>((ref) {
  return ref.watch(currentUserProvider);
});
