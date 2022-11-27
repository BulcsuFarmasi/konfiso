import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';

final forgottenPasswordRepositoryProvider =
    Provider((Ref ref) => ForgottenPasswordRepository(ref.read(authServiceProvider)));

class ForgottenPasswordRepository {
  const ForgottenPasswordRepository(this._authService);

  final AuthService _authService;

  Future<void> sendEmail(String email) async {
    _authService.sendPasswordResetEmail(email);
  }
}
