import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';

class SignInException implements Exception {
  final SignInError error;

  SignInException(this.error);
}
