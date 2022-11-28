import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_error.dart';
import 'package:konfiso/shared/widgets/error_banner.dart';

class ForgottenPasswordErrorBanner extends ErrorBanner<ForgottenPasswordError> {
  const ForgottenPasswordErrorBanner({super.key, super.error = ForgottenPasswordError.other});

  @override
  String convertErrorToText(BuildContext context) {
    switch (error) {
      case ForgottenPasswordError.emailNotFound:
        return AppLocalizations.of(context)!.theEmailAddressCouldntBeFound;
      case ForgottenPasswordError.other:
        return AppLocalizations.of(context)!.somethingWentWrongPleaseTryAgainLater;
    }
  }
}
