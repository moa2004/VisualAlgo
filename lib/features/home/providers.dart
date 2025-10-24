import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/home/data/user_progress_repository.dart';
import 'package:visual_algo/features/home/domain/user_progress.dart';

final userProgressRepositoryProvider = Provider<UserProgressRepository>((ref) {
  return UserProgressRepository();
});

final userProgressStreamProvider = StreamProvider.autoDispose<UserProgress>((
  ref,
) {
  final repository = ref.watch(userProgressRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  return repository.watchProgress(user);
});
