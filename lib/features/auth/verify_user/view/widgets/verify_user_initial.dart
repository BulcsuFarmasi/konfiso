import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyUserInitial extends StatelessWidget {
  const VerifyUserInitial({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!
                .weveSentAnEmailToVerifyYourEmailAddress,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!
                .pleaseClickOnTheLinkInTheEmailThenReturnHere,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
