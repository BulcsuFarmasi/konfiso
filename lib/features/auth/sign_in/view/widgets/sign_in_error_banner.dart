import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/shared/widgets/error_banner.dart';

class SignInErrorBanner extends ErrorBanner<SignInError> {
  const SignInErrorBanner({super.key, super.error = SignInError.other});

  @override
  String convertErrorToText(BuildContext context) {
    switch (error) {
      case SignInError.other:
        return AppLocalizations.of(context)!.somethingWentWrongPleaseTryAgainLater;
      case SignInError.invalidEmail:
      case SignInError.invalidPassword:
        return AppLocalizations.of(context)!.wrongEmailOrPassword;
      case SignInError.userDisabled:
        return AppLocalizations.of(context)!.yourAccountHasBeenDisabled;
    }
  }
}
