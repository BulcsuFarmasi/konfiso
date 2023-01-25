import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/shared/app_validators.dart';

mixin EmailValidationCapability {
  BuildContext get context;

  String? validateEmail(String? email) {
    String? errorMessage;
    if (AppValidators.required(email)) {
      errorMessage = AppLocalizations.of(context)!.pleaseProvideAnEmailAddress;
    } else if (AppValidators.email(email!)) {
      errorMessage = AppLocalizations.of(context)!.pleaseProvideAValidEmailAddress;
    }
    return errorMessage;
  }
}
