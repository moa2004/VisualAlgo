import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/features/auth/data/auth_repository.dart';
import 'package:visual_algo/features/auth/domain/auth_user.dart';
import 'package:visual_algo/features/auth/providers.dart';

class AuthViewModel extends AsyncNotifier<AuthUser?> {
  AuthViewModel();

  late AuthRepository _repository;

  @override
  Future<AuthUser?> build() async {
    _repository = ref.read(authRepositoryProvider);
    return _repository.currentUser();
  }

  Future<void> refreshSession() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository.currentUser);
  }

  Future<void> signInWithEmail(String email, String password) async {
  try {
    state = const AsyncLoading();
    final user = await _repository.signInWithEmail(
      email: email,
      password: password,
    );
    state = AsyncData(user);
  } catch (error, stack) {
    state = AsyncError(error, stack);
    rethrow; 
  }
}

  Future<void> signUpWithEmail({
  required String email,
  required String password,
  required String displayName,
}) async {
  try {
    state = const AsyncLoading();
    final user = await _repository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
    state = AsyncData(user);
  } catch (error, stack) {
    state = AsyncError(error, stack);
    rethrow; 
  }
}
  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await _repository.signOut();
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
