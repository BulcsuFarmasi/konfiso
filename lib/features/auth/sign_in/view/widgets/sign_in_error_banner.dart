import 'package:intl/intl.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/shared/widgets/error_banner.dart';

class SignInErrorBanner extends ErrorBanner<SignInError> {
  const SignInErrorBanner({super.key, super.error = SignInError.other});

  @override
  String convertErrorToText() {
    switch (error) {
      case SignInError.other:
        return Intl.message('Something went wrong. Please try again later.');
      case SignInError.invalidEmail:
      case SignInError.invalidPassword:
        return Intl.message(
            'Wrong email or password');
      case SignInError.userDisabled:
        return Intl.message('Your account has been disabled.');
    }
  }
}
