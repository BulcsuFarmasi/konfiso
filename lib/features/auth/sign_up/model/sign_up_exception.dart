import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';

class SignUpException implements Exception {
  final SignUpError error;

  SignUpException(this.error);
}