import 'package:intl/intl.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/shared/error_banner.dart';

class SignUpErrorBanner extends ErrorBanner<SignUpError> {
  const SignUpErrorBanner({super.key, super.error = SignUpError.other});

  @override
  String convertErrorToText() {
    switch (error) {
      case SignUpError.emailExists:
        return Intl.message(
            'This email address is already registered. Please try an another.');
      case SignUpError.operationNotAllowed:
        return Intl.message('This operation is not allowed.');
      case SignUpError.tooManyAttempts:
        return Intl.message(
            'You were trying too many times, please try again some time later.');
      case SignUpError.other:
        return Intl.message('Something went wrong. Please try again later.');
    }
  }
}
