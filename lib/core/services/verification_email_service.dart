import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
class VerificationEmailService {
  VerificationEmailService({FirebaseFunctions? functions})
    : _functions = functions ?? FirebaseFunctions.instance;

  final FirebaseFunctions _functions;

  Future<void> sendVerificationEmail({
    required String uid,
    required String email,
    String? displayName,
  }) async {
    try {
      await _functions.httpsCallable('sendVerificationEmail').call({
        'uid': uid,
        'email': email,
        if (displayName != null && displayName.isNotEmpty)
          'displayName': displayName,
      });
      debugPrint(' Verification email callable triggered successfully.');
    } on FirebaseFunctionsException catch (error) {
      debugPrint(' Firebase callable error: ${error.code} ${error.message}');
      rethrow;
    } catch (error, stackTrace) {
      debugPrint(' sendVerificationEmail error: $error\n$stackTrace');
      rethrow;
    }
  }
}
