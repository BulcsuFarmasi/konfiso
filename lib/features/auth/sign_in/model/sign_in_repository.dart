import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';

final signInRepositoryProvider = Provider((Ref ref) => SignInRepository(ref.read(authServiceProvider)));

class SignInRepository {
  final AuthService _authService;

  SignInRepository(this._authService);

  Future<void> signIn(String email, String password) async {
    await _authService.signIn(email, password);
  }
}