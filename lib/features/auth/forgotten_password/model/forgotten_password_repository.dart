import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_error.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_exception.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final forgottenPasswordRepositoryProvider =
    Provider((Ref ref) => ForgottenPasswordRepository(ref.read(authServiceProvider)));

class ForgottenPasswordRepository {
  const ForgottenPasswordRepository(this._authService);

  final AuthService _authService;

  Future<void> sendEmail(String email) async {
    try {
      _authService.sendPasswordResetEmail(email);
    } on NetworkException catch (e) {
      throw ForgottenPasswordException(_convertMessageIntoError(e.message!));
    }
  }

  ForgottenPasswordError _convertMessageIntoError(String message) {
    switch (message) {
      case 'EMAIL_NOT_FOUND':
        return ForgottenPasswordError.emailNotFound;
      default:
        return ForgottenPasswordError.other;
    }
  }
}
