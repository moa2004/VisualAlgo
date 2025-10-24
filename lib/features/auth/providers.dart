import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/features/auth/data/auth_repository.dart';
import 'package:visual_algo/features/auth/domain/auth_user.dart';
import 'package:visual_algo/features/auth/view_models/auth_view_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateChangesProvider = StreamProvider<AuthUser?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges();
});

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, AuthUser?>(
  AuthViewModel.new,
);

final currentUserProvider = Provider<AuthUser?>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  return authState.asData?.value;
});
