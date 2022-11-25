import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/shared/widgets/app/view/app.dart';

class ForgottenPasswordSuccessful extends StatelessWidget {
  const ForgottenPasswordSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.emailIsSentSuccessfully,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.youCanChangeThePasswordAtThePageLinkedInTheEmail,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          AppLocalizations.of(context)!.afterThatYouCanLoginHere,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
