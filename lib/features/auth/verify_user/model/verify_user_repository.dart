import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';

final verifyUserRepositoryProvider = Provider((ref) => VerifyUserRepository(ref.read(authServiceProvider)));

class VerifyUserRepository {
  VerifyUserRepository(this._authService);

  final AuthService _authService;


  Future<void> checkVerification() async {
    await _authService.checkVerification();
  }
}