import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';
import 'package:konfiso/features/privacy_policy/services/privacy_poilcy_service.dart';

final signUpRepositoryProvider = Provider((Ref ref) => SignUpRepository(ref.read(authServiceProvider), ref.read(privacyPolicyServiceProvider)));

class SignUpRepository {
  final AuthService _authService;
  final PrivacyPolicyService _privacyPolicyService;

  SignUpRepository(this._authService, this._privacyPolicyService);

  Future<void> signUp(String email, String password) async {
    try {
      await _authService.signUp(email, password);
    } on NetworkException catch (e) {
      throw SignUpException(_convertMessageIntoError(e.message!));
    }
  }

  String getPrivacyPolicy() {
    return _privacyPolicyService.privacyPolicyUrl;
  }

  SignUpError _convertMessageIntoError(String message) {
    switch (message) {
      case 'EMAIL_EXISTS':
        return SignUpError.emailExists;
      case 'OPERATION_NOT_ALLOWED':
        return SignUpError.operationNotAllowed;
      case 'TOO_MANY_ATTEMPTS_TRY_LATER':
        return SignUpError.tooManyAttempts;
      default:
        return SignUpError.other;
    }
  }
}
