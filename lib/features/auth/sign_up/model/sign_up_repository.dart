import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';

final signUpRepositoryProvider = Provider((Ref ref) => SignUpRepository(ref.read(authServiceProvider)));

class SignUpRepository {

  final AuthService signUpService;

  SignUpRepository(this.signUpService);

  Future<void> signUp(String email, String password) async {
    try {
      await signUpService.signUp(email, password);
    } on SignUpError {
      rethrow;
    }
  }
}