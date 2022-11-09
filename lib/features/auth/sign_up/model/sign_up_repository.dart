import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final signUpRepositoryProvider = Provider((Ref ref) => SignUpRepository(ref.read(authServiceProvider)));

class SignUpRepository {

  final AuthService _authService;

  SignUpRepository(this._authService);

  Future<void> signUp(String email, String password) async {
    try {
      await _authService.signUp(email, password);
    } on NetworkException catch(e) {
      throw SignUpException(_convertMessageIntoError(e.message));
    }
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