import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_up_expection.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final signInRepositoryProvider = Provider((Ref ref) => SignInRepository(ref.read(authServiceProvider)));

class SignInRepository {
  final AuthService _authService;

  SignInRepository(this._authService);

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
    } on NetworkException catch (e) {
      throw SignInException(_convertMessageIntoError(e.message!));
    }
  }

  SignInError _convertMessageIntoError(String message) {
    switch (message) {
      case 'INVALID_EMAIL':
        return SignInError.invalidEmail;
      case 'INVALID_PASSWORD':
        return SignInError.invalidPassword;
      case 'USER_DISABLED':
        return SignInError.userDisabled;
      default:
        return SignInError.other;
    }
  }
}
