import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:visual_algo/features/auth/domain/auth_user.dart';

class AuthFailure implements Exception {
  const AuthFailure(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

class AuthRepository {
  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance {
    unawaited(_auth.setLanguageCode('en'));
  }

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Stream<AuthUser?> authStateChanges() {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return AuthUser.fromFirebaseUser(user);
    });
  }

  Future<AuthUser?> currentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AuthUser.fromFirebaseUser(user);
  }

  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
      await _ensureUserDocument(user);
      return AuthUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(error.code, _mapFirebaseError(error));
    } catch (error, stack) {
      debugPrint('signInWithEmail error: $error\n$stack');
      throw const AuthFailure(
        'unknown',
        'Something went wrong while signing in.',
      );
    }
  }

  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user!;
      await user.updateDisplayName(displayName);
      await _ensureUserDocument(user);
      return AuthUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(error.code, _mapFirebaseError(error));
    } catch (error, stack) {
      debugPrint('signUpWithEmail error: $error\n$stack');
      throw const AuthFailure(
        'unknown',
        'We could not complete your registration. Please try again later.',
      );
    }
  }

  Future<void> sendPasswordReset(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> _ensureUserDocument(User user) async {
    final ref = _firestore.collection('users').doc(user.uid);
    await ref.set({
      'uid': user.uid,
      'displayName': user.displayName,
      'email': user.email,
      'photoUrl': user.photoURL,
      'phoneNumber': user.phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

String _mapFirebaseError(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'invalid-credential':
      return 'Invalid email or password.';
    case 'user-not-found':
      return 'No user found for this email.';
    case 'wrong-password':
      return 'Incorrect password.';
    case 'email-already-in-use':
      return 'This email is already registered.';
    case 'too-many-requests':
      return 'Too many attempts. Please try again later.';
    default:
      return exception.message ?? 'Something went wrong.';
  }
}
