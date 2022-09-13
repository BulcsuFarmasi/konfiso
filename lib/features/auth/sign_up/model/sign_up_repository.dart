import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_service.dart';

final signUpRepositoryProvider = Provider((Ref ref) => SignUpRepository(ref.read(signUpServiceProvider)));

class SignUpRepository {

  final SignUpService signUpService;

  SignUpRepository(this.signUpService);

  Future<void> signUp(String email, String password) async {
    try {
      await signUpService.signUp(email, password);
    } on SignUpError {
      rethrow;
    }
  }
}