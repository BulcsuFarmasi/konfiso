import 'package:konfiso/features/sign_up/model/sign_up_error.dart';

class SignUpException implements Exception {
  final SignUpError error;

  SignUpException(this.error);
}