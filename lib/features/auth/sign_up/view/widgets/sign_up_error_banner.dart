import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/shared/widgets/error_banner.dart';

class SignUpErrorBanner extends ErrorBanner<SignUpError> {
  const SignUpErrorBanner({super.key, super.error = SignUpError.other});

  @override
  String convertErrorToText(BuildContext context) {
    switch (error) {
      case SignUpError.emailExists:
        return AppLocalizations.of(context)!
            .thisEmailAddressIsAlreadyRegisteredPleaseTryAnAnother;
      case SignUpError.operationNotAllowed:
        return AppLocalizations.of(context)!.thisOperationIsNotAllowed;
      case SignUpError.tooManyAttempts:
        return AppLocalizations.of(context)!
            .youWereTryingTooManyTimesPleaseTryAgainSomeTimeLater;
      case SignUpError.other:
        return AppLocalizations.of(context)!
            .somethingWentWrongPleaseTryAgainLater;
    }
  }
}
