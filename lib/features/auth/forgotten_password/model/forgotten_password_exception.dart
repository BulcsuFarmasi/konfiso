import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_error.dart';

class ForgottenPasswordException {
  final ForgottenPasswordError error;

  ForgottenPasswordException(this.error);
}
